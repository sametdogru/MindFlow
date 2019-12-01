
import UIKit
import Firebase

class LeaderBoardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

	@IBOutlet weak var listTableView: UITableView!
	var scoreArray: [Int] = []
	var userArray: [String] = []
	var sortedUserArray: [String] = []
	var sortedArray: [Int] = []

	override func viewDidLoad() {
        super.viewDidLoad()

		getData()
		
    }
	
	func getData() {
		
		let fireStore = Firestore.firestore()
		fireStore.collection("UserInfo").addSnapshotListener { (snapshot, error) in
			if error != nil {
				let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
				let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
				alert.addAction(okButton)
				self.present(alert, animated: true, completion: nil)
			} else {
				if snapshot?.isEmpty != true && snapshot != nil {
					for document in snapshot!.documents {
						if let score = document.get("highScore") as? Int {
							if let users = document.get("email") as? String {
								
								self.scoreArray.append(score)
								self.userArray.append(users)
 
								print("Score: \(score) --> User: \(users)")
							}
						}
					}
					
					let offsets = self.scoreArray.enumerated().sorted { $0.element < $1.element }.map { $0.offset }
					let sorted_ints = offsets.map { self.userArray[$0] }
					self.sortedUserArray = sorted_ints.reversed()
					self.sortArray()
				}
			}
		}
	}
 
	func sortArray() {
		self.sortedArray = self.scoreArray.sorted().reversed()
		self.listTableView.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if sortedArray.count < 10 {
			return sortedArray.count
		} else {
			return 10
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ListTableViewCell
		cell.configure(with: "🏆 \(sortedArray[indexPath.row])", user: self.sortedUserArray[indexPath.row], index: indexPath.row+1)
		return cell
	}
	
	@IBAction func backButton(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
}

 
