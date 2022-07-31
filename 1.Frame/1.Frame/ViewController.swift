    //
//  ViewController.swift
//  1.Frame
//
//  Created by Hyeongjung on 2022/07/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var adorableImage: UIImageView!
    @IBOutlet weak var value: UILabel!
    var currentPrice = 1000000
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        value.text = String(currentPrice)
        adorableImage.image = UIImage(named: "IMG_0068")
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        let alert = UIAlertController(title: "아이유 콘서트가격", message: "현재 가격은 \(currentPrice) 입니다.", preferredStyle: .alert)
        let text = UIAlertAction(title: "확인", style: .default, handler:  { action in
            self.randomPrice()
        })
        alert.addAction(text)
        present(alert, animated: true, completion: nil)
        
    }
    func randomPrice() {
        let ramdomPrices = arc4random_uniform(10000) + 1
        currentPrice = Int(ramdomPrices)
        value.text = String(ramdomPrices)
    }
    

}

