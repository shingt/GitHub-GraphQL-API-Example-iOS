import UIKit
import Apollo

private let token = "YOUR_TOKEN"

class TokenAddingInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        request.addHeader(name: "Authorization", value: "Bearer \(token)")
        chain.proceedAsync(request: request, response: response, completion: completion)
    }
}

class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(TokenAddingInterceptor(), at: 0)
        return interceptors
    }
}

final class RepositoriesViewController: UITableViewController {
    private var repositories: [SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository]? {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let url = URL(string: "https://api.github.com/graphql")!
        let transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: url
        )
        return .init(networkTransport: transport, store: store)
    }()
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        let queryString = "GraphQL"
        navigationItem.title = "Query: \(queryString)"

        apollo.fetch(query: SearchRepositoriesQuery(query: queryString, count: 10), cachePolicy: .fetchIgnoringCacheData) { [weak self] result in
            switch result {
            case .success(let result):
                result.data?.search.edges?.forEach { edge in
                    guard let repository = edge?.node?.asRepository?.fragments.repositoryDetails else { return }
                    print("Name: \(repository.name)")
                    print("Path: \(repository.url)")
                    print("Owner: \(repository.owner.resourcePath)")
                    print("Stars: \(repository.stargazers.totalCount)")
                    print("\n")
                }

                self?.repositories = result.data?.search.edges?.compactMap { $0?.node?.asRepository }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell else {
            fatalError()
        }
        
        guard let repository = repositories?[indexPath.row] else {
            fatalError()
        }
        
        cell.configure(with: repository.fragments.repositoryDetails)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
}
