import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

	@IBOutlet weak var emailText: UITextField!
	@IBOutlet weak var passwordText: UITextField!
	@IBOutlet weak var confirmText: UITextField!
	@IBOutlet weak var signUpButton: UIButton!
	var highScore = 0
	override func viewDidLoad() {
        super.viewDidLoad()
		signUpButton.layer.cornerRadius = 25
		signUpButton.clipsToBounds = true
    }
	
	@IBAction func signUpButton(_ sender: Any) {
		
		if emailText.text != "" && passwordText.text == confirmText.text {
			
			Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (auth, error) in
				
				if error != nil {
					self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
				} else {
					let fireStore = Firestore.firestore()
					
					let userDictionary = ["email" : self.emailText.text!, "password" : self.passwordText.text!, "highScore" : self.highScore] as [String : Any]
					
					fireStore.collection("UserInfo").addDocument(data: userDictionary) { (error) in
						if error != nil {
							self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
						}
					}
					self.performSegue(withIdentifier: "toHomeVC", sender: nil)
				}
			}
		} else {
			makeAlert(title: "Error", message: "Email/Password")
		}
	}
	
	func makeAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alert.addAction(okButton)
		self.present(alert, animated: true, completion: nil)
	}
	@IBAction func backButton(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
}
