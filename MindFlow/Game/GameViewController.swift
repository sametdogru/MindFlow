
import UIKit
import Firebase
import AVFoundation

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
	@IBOutlet weak var gameCollectionView: UICollectionView!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	
	private let viewModel = ViewModelLevels()
	var counter = 0
	var count = 0
	var score = 0
	var timer = Timer()
	var previousIndex = 0
	let fireStore = Firestore.firestore()
	var gameList: [ModelLevels]!
	var level = 1
	var highScore = 0
	var audioPlayer: AVAudioPlayer!
	
	override func viewDidLoad() {
        super.viewDidLoad()
	
		self.getData()
		self.setUp()
		shuffleList()
    }
	
	func setUp() {
		gameList = viewModel.level1.value
		scoreLabel.text = "Score: \(score)"
		levelLabel.text = "Level 1"
		count = 180
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.countDown), userInfo: nil, repeats: true)
	}
	
	@objc func countDown() {
		count = count - 1
		timeLabel.text = "Time: \(count)"
	
		if count == 0 {
			timer.invalidate()
			self.scoreLabel.text = "Score: \(count)"

			let alert = UIAlertController(title: "Time", message: "Time's Up", preferredStyle: .alert)
			let okButton = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
				self.navigationController?.popViewController(animated: true)
			}
			let replayButton = UIAlertAction(title: "Replay", style: .default) { (UIAlertAction) in
				self.score = 0
				self.scoreLabel.text = "Score: \(self.score)"
				self.count = 180
				self.timeLabel.text = "Time: \(self.count)"
				self.setStatus()
				self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.countDown), userInfo: nil, repeats: true)
				self.gameCollectionView.reloadData()
			}
			alert.addAction(okButton)
			alert.addAction(replayButton)
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	func shuffleList() {
		gameList.shuffle()
	}

	func setStatus() {
		gameList.removeAll()
		gameList = viewModel.level1.value
		self.levelLabel.text = "Level 1"
		self.level = 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return gameList.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GameCollectionViewCell
		cell.configure(item: gameList[indexPath.row])
		return cell
	}
    
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		playSound(with: "tick")
		if gameList[indexPath.row].status == true {
			return
		}
		
		counter = counter + 1
		gameList[indexPath.row].status = true
		gameCollectionView.reloadData()

		if counter == 1 {
			previousIndex = indexPath.row
		} else if counter == 2 {
			if gameList[indexPath.row].imageId != gameList[previousIndex].imageId {
				playSound(with: "error")
				self.gameCollectionView.isUserInteractionEnabled = false
				DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 1), execute: {
					self.gameList[indexPath.row].status = false
					self.gameList[self.previousIndex].status = false
					self.gameCollectionView.isUserInteractionEnabled = true
					self.gameCollectionView.reloadData()
					
				})
			} else {
					playSound(with: "success")
					self.gameCollectionView.reloadData()
			}
			counter = 0
		}
		
		DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 3), execute: {
			self.isLevelCompleted()
		})
	}
	
	func isLevelCompleted() {
		var isFinished = 0
		
		for i in 0..<gameList.count {
			if gameList[i].status == true {
				isFinished = isFinished + 1
			}
		}
		if isFinished == gameList.count {
			
			self.level = level + 1
			checkLevel()
			
			if level == 5 {
				
				timer.invalidate()
				self.scoreLabel.text = "Score: \(count)"
                sendDataFirebase()
				let alert = UIAlertController(title: "Tebrikler 🎉", message: "Score: \(count)", preferredStyle: .alert)
				let okButton = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
				}
				alert.addAction(okButton)
				self.present(alert, animated: true, completion: nil)
				print("finish")
			}
		}
	}
	
	func sendDataFirebase() {
		if count > highScore {
			fireStore.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
			if error != nil {
				self.makeAlert(title: "Error", message: error!.localizedDescription)
			} else {
				if snapshot?.isEmpty != true && snapshot != nil {
					for document in snapshot!.documents {
						let documentID = document.documentID
						
						self.fireStore.collection("UserInfo").document(documentID).setData(["highScore" : self.count], merge: true) { (error) in
							if error != nil {
								//print(error?.localizedDescription)
							} else {
								self.navigationController?.popViewController(animated: true)
							}
						 }
					 }
				 }
			  }
		  }
	   } else {
			self.navigationController?.popViewController(animated: true)
	   }
    }
 
	func getData() {
		
		fireStore.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
			if error != nil {
				self.makeAlert(title: "Error", message: error!.localizedDescription)
			} else {
				if snapshot?.isEmpty != true && snapshot != nil {
					for document in snapshot!.documents {
						self.fireStore.collection("UserInfo").addSnapshotListener { (snapshot, error) in
							if let highScore = document.get("highScore") as? Int {
								self.highScore = highScore
							}
						}
					}
				}
			}
		}
	}
	
	func playSound(with audioName: String) {
		if let soundURL = Bundle.main.url(forResource: audioName, withExtension: "mp3") {
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
	
	func checkLevel() {
		gameList.removeAll()
		if level == 2 {
			self.levelLabel.text = "Level 2"
			gameList = viewModel.level2.value
			
		} else if level == 3 {
			self.levelLabel.text = "Level 3"
			gameList = viewModel.level3.value
			
		} else if level == 4 {
			self.levelLabel.text = "Level 4"
			gameList = viewModel.level4.value
		}
		shuffleList()
		self.gameCollectionView.reloadData()
	}
	
	func makeAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
		alert.addAction(okButton)
		self.present(alert, animated: true, completion: nil)
	}
}
 
