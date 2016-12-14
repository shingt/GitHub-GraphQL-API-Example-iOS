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
        
        let configuration: URLSessionConfiguration = .default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData // To avoid 412
        
        let url = URL(string: "https://api.github.com/graphql")!
        let apollo = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))        
        apollo.fetch(query: SearchRepositoriesQuery(query: queryString, count: 10), completionHandler: { (result, error) in
            if let error = error { print("Error: \(error)"); return }
            
            result?.data?.search.edges?.forEach { edge in
                guard let repository = edge?.node?.asRepository else { return }
                print("Name: \(repository.name)")
                print("Path: \(repository.url)")
                print("Owner: \(repository.owner.path)")
                print("Stars: \(repository.stargazers.totalCount)")
                print("\n")
            }
           
            self.repositories = result?.data?.search.edges?.flatMap { $0?.node?.asRepository }
        })
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
        
        cell.configure(with: repository)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
}
