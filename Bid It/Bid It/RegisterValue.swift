//
//  RegisterValue.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 06/05/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
final class RegisterValue: Codable{
    var Username: String
    var Bday: String
    var Email: String
    var Gender: String
    var PhoneNumber: String
    var Password: String
    var RePassword: String
    
    
    init(Username: String, Bday: String, Email: String, Gender: String, PhoneNumber: String, Password: String, RePassword: String) {
        self.Username = Username
        self.Bday = Bday
        self.Email = Email
        self.Gender = Gender
        self.PhoneNumber = PhoneNumber
        self.Password = Password
        self.RePassword =  RePassword
    }

}
