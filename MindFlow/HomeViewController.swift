import UIKit
import Firebase
import AVFoundation


class HomeViewController: UIViewController {
	
	@IBOutlet weak var emailText: UILabel!
	@IBOutlet weak var highScoreText: UILabel!
	@IBOutlet weak var playButton: UIButton!
	@IBOutlet weak var leaderBoardButton: UIButton!
	@IBOutlet weak var logOutClick: UIButton!
	
	var scoreArray: [Int] = []
	var userArray: [String] = []
	var audioPlayer: AVAudioPlayer!

	override func viewDidLoad() {
		super.viewDidLoad()
		setUp()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		sendDataFirebase()
	}
	
	func setUp() {
		self.emailText.text = Auth.auth().currentUser?.email!
		playButton.layer.cornerRadius = 25
		playButton.clipsToBounds = true
		leaderBoardButton.layer.cornerRadius = 25
		leaderBoardButton.clipsToBounds = true
		logOutClick.layer.cornerRadius = 20
		logOutClick.clipsToBounds = true
	}
	
	func sendDataFirebase() {
		let fireStore = Firestore.firestore()
		fireStore.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
				if error != nil {
					//print(error?.localizedDescription)
				} else {
					if snapshot?.isEmpty != true && snapshot != nil {
						for document in snapshot!.documents {
							fireStore.collection("UserInfo").addSnapshotListener { (snapshot, error) in
								if error != nil {
									let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
									let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
									alert.addAction(okButton)
									self.present(alert, animated: true, completion: nil)
								}
								if let highScore = document.get("highScore") as? Int {
									self.highScoreText.text = "HighScore: \(highScore)"
								}
							}
						}
					}
				}
			}
		}
	
	@IBAction func playButton(_ sender: Any) {
		self.performSegue(withIdentifier: "toGameVC", sender: nil)
		
		if let soundURL = Bundle.main.url(forResource: "start", withExtension: "mp3") {
				do {
					audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
				}
				catch {
					print(error)
				}
				
				audioPlayer.play()
			}else{
				print("Unable to locate audio file")
			}
		
	}
	
	@IBAction func leaderBoardButton(_ sender: Any) {
		self.performSegue(withIdentifier: "toLeaderBoardVC", sender: nil)
	}

	@IBAction func logoutClick(_ sender: Any) {
		do {
			try Auth.auth().signOut()
		} catch {
			
		}
		navigationController?.popToRootViewController(animated: true)
	}
 
}
