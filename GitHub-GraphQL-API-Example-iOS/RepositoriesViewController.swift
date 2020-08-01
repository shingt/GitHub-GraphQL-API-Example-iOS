import UIKit
import Apollo

private let token = "YOUR_TOKEN"

final class RepositoriesViewController: UITableViewController {
    var repositories: [SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository]? {
        didSet {
            tableView.reloadData()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        let queryString = "GraphQL"
        navigationItem.title = "Query: \(queryString)"
        
        let url = URL(string: "https://api.github.com/graphql")!
        let transport = HTTPNetworkTransport(url: url)
        transport.delegate = self
        let apollo = ApolloClient(networkTransport: transport)

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

extension RepositoriesViewController: HTTPNetworkTransportPreflightDelegate {
    func networkTransport(_ networkTransport: HTTPNetworkTransport, shouldSend request: URLRequest) -> Bool {
        true
    }

    func networkTransport(_ networkTransport: HTTPNetworkTransport, willSend request: inout URLRequest) {
          var headers = request.allHTTPHeaderFields ?? [String: String]()
          headers["Authorization"] = "Bearer \(token)"
          request.allHTTPHeaderFields = headers
    }
}
