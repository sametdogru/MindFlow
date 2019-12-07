import UIKit
class ViewController: UIViewController {

	@IBOutlet weak var signUpButton: UIButton!
	@IBOutlet weak var signInButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		signUpButton.layer.cornerRadius = 25
		signUpButton.clipsToBounds = true
		signInButton.layer.cornerRadius = 25
		signInButton.clipsToBounds = true
	}

	@IBAction func loginButton(_ sender: Any) {
		self.performSegue(withIdentifier: "toLoginVC", sender: nil)
	}
	
	@IBAction func signUpButton(_ sender: Any) {
		self.performSegue(withIdentifier: "toRegisterVC", sender: nil)
	}
	
}

