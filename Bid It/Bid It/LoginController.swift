//
//  LoginController.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 09/04/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

public var ResponseCode: String = ""
// PARSING TO OTHER CLASS TO SET
public var NameParse:String =  ""
public var birthdateParse: String = ""
public var emailParse: String = ""
public var phonenumParse: String = ""
public var virtualaccparse = "419"
public var encodedprofilepic: String = ""

class LoginController: UIViewController{
 
    @IBOutlet weak var viewer_login: UIView!
    @IBOutlet weak var ngeround_button_login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ngeround_button_login.layer.borderWidth = 1
        ngeround_button_login.layer.cornerRadius = 8
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToNextItem(_:)))
        rightSwipe.direction = .right
        viewer_login.addGestureRecognizer(rightSwipe)
    }
    
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    //    @IBAction func backtolaunch(_ sender: UISwipeGestureRecognizer) {
    //        let viewit =  storyboard?.instantiateViewController(withIdentifier: "WelcomeToBar") as! WelcomeToBar
//        present(viewit, animated: true)
//
//    }
    
    @objc func moveToNextItem(_ sender:UISwipeGestureRecognizer) {
        
        switch sender.direction{
        case .right:
            print("swipped")
            let viewit =  storyboard?.instantiateViewController(withIdentifier: "WelcomeToBar") as! WelcomeToBar
            present(viewit, animated: true)
        //left swipe action
        default:
            print("")
        }
        
    }
    
    func recurse_response() {
        let parsed_username: String = usernameText.text!
        let parsed_password: String = passwordText.text!
        let get_value = LoginValue(username: parsed_username, password: parsed_password)
        var APIRequest = APIuri.init(path: "sign-in", ResponseApi: "")
        
        // prepare zero(tab-bar)
        let viewit = storyboard?.instantiateViewController(withIdentifier: "ZeroViewController") as! ZeroViewController
        
        // prepare profile
       
        APIRequest.call_api(get_value, complete: {
            Result in switch Result{
            case .success(let get_value):
                ResponseCode = get_value.code
                print(ResponseCode)
                print("[!] API RESP")
                print(get_value.username)
                print(get_value.gender)
                print(get_value.email)
                print(get_value.phonenumber)
                print(get_value.birthday)
                print("[!] API RESP")
                
                if ResponseCode == "success"{
                    DispatchQueue.main.async {
                                NameParse = get_value.username
                                birthdateParse = get_value.birthday
                                emailParse = get_value.email
                                phonenumParse = get_value.phonenumber
                                virtualaccparse += get_value.phonenumber
                                encodedprofilepic = get_value.profilepic
                        
                                self.present(viewit, animated: true)
                    }
                }
                else{
                    print("and it works ")
                }
                
                print("debug \(ResponseCode)")
                
            case .failure(let error):
                print("[-] error disini: \(error)" )
                print("[-] error data: \(get_value)")
            } // case
        })// call api
        print("Fixed value is \(ResponseCode)")
        
        
    }
    
    
    @IBAction func login_tapped(_ sender: UIButton) {
        // tembak api
        recurse_response()

      
       
        
        
    }// le button login tapped
    

    
    
   
    
    
    
} // whole class



