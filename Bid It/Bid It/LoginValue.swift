//
//  LoginValue.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 03/05/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation



final class LoginValue: Codable{
    var username: String
    var password: String
    init(username:String, password: String) {
        self.username = username
        self.password = password
    }
    enum success{
        case itworks
    }
}

