import UIKit

class ListTableViewCell: UITableViewCell {

	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var userLabel: UILabel!
	@IBOutlet weak var labelNumber: UILabel!

	func configure(with score: String, user: String, index: Int) {
		self.scoreLabel.text = score
		self.userLabel.text = user
		self.labelNumber.text = String(index)
	}
}
