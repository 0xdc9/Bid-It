//
//  RegisterController.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 09/04/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

class RegisterController: UIViewController{
    
   
    // textfields
    @IBOutlet weak var getUsername: UITextField!
    @IBOutlet weak var getBdate: UITextField!
    @IBOutlet weak var getEmail: UITextField!
    @IBOutlet weak var getPhoneNum: UITextField!
    @IBOutlet weak var getPassword: UITextField!
    @IBOutlet weak var getRePassword: UITextField!
    
    // buttons strings
    
    @IBOutlet weak var male_button_selected: UIButton!
    @IBOutlet weak var female_button_selected: UIButton!
    
    @IBOutlet weak var ngeround_button_sign_up: UIButton!
    
    @IBOutlet weak var BirthDayTextField: UITextField!
    //some textfields
    // flag for selected or not
    var button_male = false
    var button_female = false
    var gender_fixed: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ngeround_button_sign_up.layer.borderWidth = 1
            ngeround_button_sign_up.layer.cornerRadius = 8
        female_button_selected.setBackgroundImage(UIImage(named: "radiobutton_not_filled"), for: UIControl.State.normal)
        male_button_selected.setBackgroundImage(UIImage(named: "radiobutton_not_filled"), for: UIControl.State.normal)
        datepick()
    }
    // buttons tappeda
    @IBAction func male_button_tapped(_ sender: UIButton) {
        if (button_male == false){
            sender.setBackgroundImage(UIImage(named: "radiobutton_filled"), for: UIControl.State.normal)
            female_button_selected.setBackgroundImage(UIImage(named: "radiobutton_not_filled"), for: UIControl.State.normal)
            
            button_male = true
            button_female = false
            gender_fixed = "Male"
        }
    }
    
    @IBAction func female_button_tapped(_ sender: UIButton) {
        if (button_female == false){
            sender.setBackgroundImage(UIImage(named: "radiobutton_filled"), for: UIControl.State.normal)
            male_button_selected.setBackgroundImage(UIImage(named: "radiobutton_not_filled"), for: UIControl.State.normal)
            button_female = true
            button_male = false
            gender_fixed = "Female"
        }
    }
    
    
    
    
    @IBAction func sign_up_tapped(_ sender: Any) {
        
        let ParsedUsername: String = getUsername.text!
        let ParsedBday: String = getBdate.text!
        let ParseEmail: String = getEmail.text!
        let ParsePhoneNum: String = getPhoneNum.text!
        let ParsePassword: String = getPassword.text!
        let ParseRepassword: String = getRePassword.text!
        let ParsedGender: String = gender_fixed
        // call api
        
        
        let Regist = RegisterValue(Username: ParsedUsername, Bday: ParsedBday, Email: ParseEmail, Gender: ParsedGender, PhoneNumber: ParsePhoneNum, Password: ParsePassword, RePassword: ParseRepassword)
        
        var APICALL = APIuri.init(path: "sign-up", ResponseApi: "")
        
         let viewit = storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController // prepare UI
        APICALL.call_api_signup(Regist, complete: {
            Result in switch Result{
            case .success(let Regist):
                ResponseCode = Regist.code
                if ResponseCode == "Setted and ok"{
                    DispatchQueue.main.async {
                        self.present(viewit, animated: true)

                    }
                }
                
            case .failure(let error):
                print("[-] error disini : \(error)" )
                print("[-] error data: \(Regist)")
            } // case
        })// call api
        
        print("DEBUG SIGN UP")
        print("Gendernya" + gender_fixed)
        print("DEBUG SIGN UP END")
        
        
    }
    
    
    // bar for pickin
    
     let pickbday = UIDatePicker()
    
   
    
    func datepick(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //get value when selected(buutton + textfield)
        let pickedbutton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(ispressed))
        
        toolbar.setItems([pickedbutton], animated: true)
        
        // add it
        BirthDayTextField.inputAccessoryView = toolbar
        BirthDayTextField.inputView = pickbday
        pickbday.datePickerMode = .date
        
    }
    
    @objc func ispressed(){
        // format the date
        
        let format = DateFormatter()
        format.dateStyle = .medium
        format.timeStyle = .none
        
        print("tanggal " +  format.string(from: pickbday.date))
        BirthDayTextField.text = format.string(from: pickbday.date)
        self.view.endEditing(true)
        
        
    }
    
}
