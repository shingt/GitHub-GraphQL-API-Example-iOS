import UIKit

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
        
        apollo.fetch(query: SearchRepositoriesQuery(query: queryString, count: 10)) { (result, error) in
            if let error = error { print("Error: \(error)"); return }
            print(result ?? "No result")
            result?.data?.search.edges?.forEach { edge in
                guard let repository = edge?.node?.asRepository?.fragments.repositoryDetails else { return }
                print("Name: \(repository.name)")
                print("Path: \(repository.url)")
                print("ResourcePath: \(repository.owner.resourcePath)")
                print("Stars: \(repository.stargazers.totalCount)")
                print("\n")
            }
            
            self.repositories = result?.data?.search.edges?.flatMap { $0?.node?.asRepository }
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
