//
//  DetailViewController.swift
//  BountyList
//
//  Created by Hyeongjung on 2022/08/04.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    var name: String?
    var bounty: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        upadateUI()
    }
    
    func upadateUI() {
        if let name = self.name, let bounty = self.bounty {
            let img = UIImage(named: "\(name).jpg")
            imgView.image = img
            titleLabel.text = name
            bountyLabel.text = String(bounty)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        //completion: 사라지고나서 동작할 것을 적어준다.
    }
    
}
