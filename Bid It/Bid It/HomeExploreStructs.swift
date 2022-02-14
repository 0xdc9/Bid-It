//
//  HomeExploreStructs.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 11/04/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

struct HomeExploreStructs{
    
    let category: String
    let description: String
    let auction_name: String
    var auction_image: UIImage
    
    
    static func getdata() -> [HomeExploreStructs]{
        let data1 = HomeExploreStructs(category: "Fashion", description: "Vans Rose oldskool Size US 10", auction_name: "Rara Vans Auct", auction_image: #imageLiteral(resourceName: "auction_fashion"))

        let data2 = HomeExploreStructs(category: "Game", description: "Dota TI pass full", auction_name: "XYZgameshop dota pass", auction_image: #imageLiteral(resourceName: "auction_game"))

        let data3 = HomeExploreStructs(category: "Automotive", description: "BMW E90", auction_name: "MTHAuto BMW Auction", auction_image: #imageLiteral(resourceName: "auction_automotive"))


//        var all_data: [HomeExploreStructs]=[]
//        all_data.append(data1)
//        all_data.append(data2)
//        all_data.append(data3)
        return [data1, data2, data3]
    }
    
    
}
