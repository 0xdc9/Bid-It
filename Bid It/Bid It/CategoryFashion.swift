//
//  CategoryFashion.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 12/04/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

class CategoryFashion: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        let viewit =  storyboard?.instantiateViewController(withIdentifier: "ZeroViewController") as! ZeroViewController
        present(viewit, animated: true)
    }
    
    @IBAction func ImageTapped(_ sender: UIButton) {
        let viewit =  storyboard?.instantiateViewController(withIdentifier: "BidControlDetail") as! BidControlDetail
        present(viewit, animated: true)
    }
}


