
import UIKit
import Firebase

class LoginViewController: UIViewController {

	@IBOutlet weak var emailText: UITextField!
	@IBOutlet weak var passwordText: UITextField!
	@IBOutlet weak var signInButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		signInButton.layer.cornerRadius = 25
		signInButton.clipsToBounds = true
    }
	
	@IBAction func signInButton(_ sender: Any) {
		
		if emailText.text != "" && passwordText.text != "" {
			Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (auth, error) in
				
				if error != nil {
					self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
				} else {
					self.performSegue(withIdentifier: "toHomeVC", sender: nil)
				}
			}
		} else {
			makeAlert(title: "Error", message: "Username/Password??")
		}
	}

	func makeAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
		alert.addAction(okButton)
		self.present(alert, animated: true, completion: nil)
	}
	
	@IBAction func backButton(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
}
