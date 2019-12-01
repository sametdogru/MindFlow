
import UIKit
import Firebase

class LoginViewController: UIViewController {

	@IBOutlet weak var emailText: UITextField!
	@IBOutlet weak var passwordText: UITextField!
	override func viewDidLoad() {
        super.viewDidLoad()

		emailText.text = "sametdogru@gmail.com"
		passwordText.text = "123456"
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
}
