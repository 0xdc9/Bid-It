//
//  BidPageControll.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 12/04/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

public var mybidprice: String = ""
public var bid_status:  String = ""
class BidPageControll:UIViewController{
    
    override func viewDidLoad() {
        status_no_bid.text! = ""
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.view_tapped(sender:)))
        self.rounding_inside_view.addGestureRecognizer(gesture)
        // round default label
        rounding_nameless.layer.cornerRadius = 8
        rounding_nameless.layer.borderWidth = 1
        rounding_nameless.layer.masksToBounds = true
        
        rounding_auction_label.layer.borderWidth = 1
        rounding_auction_label.layer.cornerRadius = 8
        rounding_auction_label.layer.masksToBounds = true
        
        rounding_my_bid_label.layer.borderWidth = 1
        rounding_my_bid_label.layer.cornerRadius = 8
        rounding_my_bid_label.layer.masksToBounds = true
        
        rounding_status_label.layer.cornerRadius = 8
        rounding_status_label.layer.borderWidth = 1
        rounding_status_label.layer.masksToBounds = true
        
        // rounding view
        rounding_inside_view.layer.borderWidth = 2
        rounding_inside_view.layer.cornerRadius = 10
        rounding_inside_view.layer.masksToBounds = true
        
        // rounding non default label
        label_auction_name_mybid.layer.borderWidth = 1
        label_auction_name_mybid.layer.cornerRadius = 8
        label_auction_name_mybid.layer.masksToBounds = true
        label_end_date.layer.borderWidth = 1
        label_end_date.layer.cornerRadius = 8
        label_end_date.layer.masksToBounds = true
        label_my_placed_bid.layer.borderWidth = 1
        label_my_placed_bid.layer.cornerRadius = 8
        label_my_placed_bid.layer.masksToBounds = true
        label_status.layer.cornerRadius = 8
        label_status.layer.borderWidth = 1
        label_status.layer.masksToBounds = true
        fetch_bidded()
        print("loaded")
        super.viewDidLoad()
        
    }
    

    @objc func view_tapped(sender: UITapGestureRecognizer){
        print("tapped detected")
        if (selected_auction_name != "" && bid_status != "empty"){
            let viewit = storyboard?.instantiateViewController(withIdentifier: "detail_auction") as! detail_auction
            present(viewit, animated: true, completion: nil)
        }
        else{
            print("yes, youu have no bid")
        }
    }
    
    
    // defauult outlet
    @IBOutlet weak var rounding_auction_label: UILabel!
    @IBOutlet weak var rounding_nameless: UILabel!
    @IBOutlet weak var rounding_my_bid_label: UILabel!
    @IBOutlet weak var rounding_status_label: UILabel!
    @IBOutlet weak var rounding_inside_view: UIView!
    @IBOutlet weak var label_status: UILabel!
    
    
    // non-default outlet
    @IBOutlet weak var label_auction_name_mybid: UILabel!
    @IBOutlet weak var label_end_date: UILabel!
    @IBOutlet weak var label_my_placed_bid: UILabel!
    @IBOutlet weak var image_my_placed_bid: UIImageView!
    @IBOutlet weak var status_no_bid: UILabel!
    
    
    
    func fetch_bidded(){
        do{
            let param_to_send = put_bidded(username: NameParse)
            // CODE API
            let url = URL(string: "http://127.0.0.1:4242/my-bid")! // path to your LOCALHOST API
            var request = URLRequest(url: url)
            request.httpMethod = "POST" // HTTP METHODS
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(param_to_send)
            let task = URLSession.shared.dataTask(with: request){data, response, _ in guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200, let jsonValue = data else{
                return
                }// task
                do{
                    let respon_detail = try JSONDecoder().decode(get_bidded.self, from: jsonValue)
                    print(respon_detail.status[0])
                    if (respon_detail.status[0] == "empty"){
                        DispatchQueue.main.async {
                            bid_status = respon_detail.status[0]
                            self.status_no_bid.text! = "you have no bid"
                            self.status_no_bid.font = UIFont.systemFont(ofSize: 20.0)
                            
                            self.label_end_date.text! = ""
                            self.label_status.text! = ""
                            self.label_my_placed_bid.text = ""
                            self.label_auction_name_mybid.text! = ""
                            self.rounding_auction_label.text = ""
                            self.rounding_nameless.text! = ""
                            self.rounding_my_bid_label.text! = ""
                            self.rounding_status_label.text! = ""
                            self.rounding_status_label.text! = ""
                            
                            // parsed
                            self.rounding_auction_label.isHidden = true
                            self.rounding_nameless.isHidden = true
                            self.rounding_my_bid_label.isHidden = true
                            self.rounding_status_label.isHidden = true
                            self.label_status.isHidden = true
                            self.label_auction_name_mybid.isHidden = true
                            self.label_end_date.isHidden = true
                            self.label_my_placed_bid.isHidden = true
                            self.image_my_placed_bid.isHidden = true
                        }
                        
                    }
                        
                    else if (respon_detail.status[0] != "empty"){
                        DispatchQueue.main.async {
                            self.status_no_bid.text! = ""
                            self.status_no_bid.isHidden = true
                            selected_auction_name = respon_detail.status[0]
                            categories_home = respon_detail.status[1]
                            selected_image = respon_detail.status[2]
                            mybidprice = respon_detail.status[3]
                            selected_startdate = respon_detail.status[4]
                            selected_enddate = respon_detail.status[5]
                            selected_desc = respon_detail.status[6]
                            print("FROM my bid page")
                            print(selected_startdate)
                            print(selected_enddate)
                            print(selected_desc)
                            print(mybidprice)
                            
                            self.label_auction_name_mybid.text = selected_auction_name
                            self.label_end_date.text = selected_enddate
                            self.label_my_placed_bid.text = mybidprice
                            
                            let dec_b64 = Data(base64Encoded: selected_image, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                            
                            self.image_my_placed_bid.image = UIImage.init(data: dec_b64!)
                            
                            
                        }
                    }
                   
                } catch{
                    print("Error value: \(error.localizedDescription)")
                }// catch & do
            }
            task.resume()
        }catch{
            print("error lagi")
        } // catch
        
    }// fetch_bidded
    
}// pid bage controll

struct put_bidded: Codable{
    let username: String
}

struct get_bidded: Codable{
    let status: [String]
}
