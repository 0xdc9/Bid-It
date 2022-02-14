//
//  HomeExploreCell.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 11/04/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

class HomeExploreCell: UITableViewCell{
    
    @IBOutlet weak var gambar_buat_explore: UIImageView!
    
    @IBOutlet weak var label_nama_auction: UILabel!
    
    @IBOutlet weak var label_category: UILabel!


    @IBOutlet weak var label_description: UILabel!
    
    func seteverythinng(article: HomeExploreStructs){
        gambar_buat_explore.image = article.auction_image
        label_nama_auction.text = article.auction_name
        label_category.text = article.category
        label_description.text = article.description
        gambar_buat_explore.image = article.auction_image
//
        print("[+] HomeExploreCell setted")
        
    }



}
