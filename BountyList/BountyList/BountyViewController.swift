//
//  BountyViewController.swift
//  BountyList
//
//  Created by Hyeongjung on 2022/08/01.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let nameList = ["brook", "chopper", "franky", "luffy", "nami", "zoro"]
    let bountyList = [3300000, 50, 44000000, 3000000000, 14000000, 8000000000]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
                vc?.name = nameList[index]
                vc?.bounty = bountyList[index]
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bountyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        let img = UIImage(named: "\(nameList[indexPath.row]).jpg" )
        cell.imgView.image = img
        cell.nameLabel.text = nameList[indexPath.row]
        cell.bountyLable.text = "\(bountyList[indexPath.row])"

        return cell
        
        //        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell {
        //            let img = UIImage(named: "\(nameList[indexPath.row]).jpg" )
        //            cell.imgView.image = img
        //            cell.nameLabel.text = nameList[indexPath.row]
        //            cell.bountyLable.text = "\(bountyList[indexPath.row])"
        //            return cell
        //        } else {
        //            return UITableViewCell()
        //        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("---> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }

}

class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLable: UILabel!
}
