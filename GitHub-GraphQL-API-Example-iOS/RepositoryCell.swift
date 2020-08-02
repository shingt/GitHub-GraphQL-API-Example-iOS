import UIKit

final class RepositoryCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var stargazersCountLabel: UILabel!
    
    func configure(with repository: RepositoryDetails) {
        nameLabel.text = "\(repository.owner.resourcePath)/\(repository.name)"
        urlLabel.text = repository.url
        stargazersCountLabel.text = "Stars: \(repository.stargazers.totalCount)"
    }
}
