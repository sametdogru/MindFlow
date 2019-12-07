import UIKit

class GameCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var gameImage: UIImageView!
	@IBOutlet weak var viewVisible: UIView!
	@IBOutlet weak var secondViewVisible: UIView!
	
	func configure(item: ModelLevels) {
		gameImage.image = UIImage(named: item.imageName)
		viewVisible.isHidden = item.status
	}
}
