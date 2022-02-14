//
//  ProfileController.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 06/05/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit



class ProfileController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // get base64 string of image
        if encodedprofilepic.count != 0{
            let parseimage = Data(base64Encoded: encodedprofilepic, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            // set it
            profile_picture.layer.cornerRadius = profile_picture.frame.size.width / 2
            profile_picture.clipsToBounds = true
            profile_picture.layer.borderColor = UIColor.black.cgColor
            profile_picture.layer.borderWidth = 3
            profile_picture.image = UIImage.init(data: parseimage!)
            
        }
      
        else{
            profile_picture.layer.cornerRadius = profile_picture.frame.size.width / 2
            profile_picture.clipsToBounds = true
            profile_picture.layer.borderColor = UIColor.black.cgColor
            profile_picture.layer.borderWidth = 3
            profile_picture.image = UIImage(named: "no-pic")
        }
        
        userlabel.text = NameParse
        birthdatelabel.text = birthdateParse
        emaillabel.text = emailParse
        phonelabel.text = phonenumParse
        virtuallabel.text = virtualaccparse
    }
    @IBOutlet weak var profile_picture: UIImageView!
    @IBOutlet weak var userlabel: UILabel!
    @IBOutlet weak var birthdatelabel: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var phonelabel: UILabel!
    @IBOutlet weak var virtuallabel: UILabel!
}
