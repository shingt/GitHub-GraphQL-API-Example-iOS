import UIKit

final class RepositoryCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var stargazersCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with repository: RepositoryDetails) {
        nameLabel.text = "\(repository.owner.resourcePath)/\(repository.name)"
        urlLabel.text = repository.url
        stargazersCountLabel.text = "Stars: \(repository.stargazers.totalCount)"
    }
}
