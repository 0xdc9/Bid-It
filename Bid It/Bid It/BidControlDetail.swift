//
//  BidControlDetail.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 12/04/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

class BidControlDetail: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToNextItem(_:)))
        rightSwipe.direction = .right
        BidControlDetail.addGestureRecognizer(rightSwipe)
    }

    @objc func moveToNextItem(_ sender:UISwipeGestureRecognizer) {
        
        switch sender.direction{
        case .right:
            print("[+] BidControlDetail: swiped")
            let viewit =  storyboard?.instantiateViewController(withIdentifier: "BidPageControll") as! BidPageControll
            present(viewit, animated: true)
        //left swipe action
        default:
            print("[+] BidControlDetail: weloz")
        }
        
    }
    
    @IBOutlet weak var BidControlDetail: UIView!
    @IBOutlet weak var label_your_bid: UILabel!
    
    @IBOutlet weak var get_your_bid: UITextField!
    
    @IBAction func SetWithButton(_ sender: UIButton) {
        let parse_value: String = get_your_bid.text!
        
        label_your_bid.text = "Your bid is Rp. " + parse_value
        
    }
    
    @IBAction func back_to_bid(_ sender: UIButton) {
        let viewit =  storyboard?.instantiateViewController(withIdentifier: "CategoryFashion") as! CategoryFashion
        present(viewit, animated: true)
    }
    
}
