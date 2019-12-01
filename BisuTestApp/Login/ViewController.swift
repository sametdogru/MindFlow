
import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var signUpButton: UIButton!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		signUpButton.layer.borderWidth = 1
		signUpButton.layer.borderColor = UIColor.white.cgColor
	}


	@IBAction func loginButton(_ sender: Any) {
		self.performSegue(withIdentifier: "toLoginVC", sender: nil)
	}
	
	@IBAction func signUpButton(_ sender: Any) {
		self.performSegue(withIdentifier: "toRegisterVC", sender: nil)
	}
	
}

