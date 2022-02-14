//
//  WelcomeToBar.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 09/04/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

class WelcomeToBar: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ngeround_button_signin.layer.borderWidth = 1
        ngeround_button_signin.layer.cornerRadius = 8
        ngeround_button_Signup.layer.borderWidth = 1
        ngeround_button_Signup.layer.cornerRadius = 8
    }

    @IBOutlet weak var ngeround_button_signin: UIButton!
    
    @IBOutlet weak var ngeround_button_Signup: UIButton!
    
    
    @IBAction func sign_up(_ sender: Any) {
                let viewit = storyboard?.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
                present(viewit, animated: false, completion: nil)
    }
    
    @IBAction func sign_in(_ sender: Any) {
        let viewit = storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        
        present(viewit, animated: false, completion: nil)
    }
    
    
//    @IBAction func tapped_debug(_ sender: UIButton) {
//        let viewit = storyboard?.instantiateViewController(withIdentifier: "detail_auction") as! detail_auction
//        
//        present(viewit, animated: false, completion: nil)
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
