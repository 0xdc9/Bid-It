//
//  SecondViewController.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 09/04/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        print("history loaded")
        fetch_bidded()
        super.viewDidLoad()
        hist_auct.layer.borderWidth=1
        hist_auct.layer.cornerRadius = 8
        hist_auct.layer.masksToBounds = true
        
        hist_endate.layer.borderWidth=1
        hist_endate.layer.cornerRadius = 8
        hist_endate.layer.masksToBounds = true
        
        hist_bid.layer.borderWidth=1
        hist_bid.layer.cornerRadius = 8
        hist_bid.layer.masksToBounds = true
        
        hist_result.layer.borderWidth=1
        hist_result.layer.cornerRadius = 8
        hist_result.layer.masksToBounds = true
        
        hist_panel.layer.borderWidth=1
        hist_panel.layer.cornerRadius = 8
        hist_panel.layer.masksToBounds = true
        
        hist_auct_name.layer.borderWidth=1
        hist_auct_name.layer.cornerRadius = 8
        hist_auct_name.layer.masksToBounds = true
        
        hist_endate_parse.layer.borderWidth=1
        hist_endate_parse.layer.cornerRadius = 8
        hist_endate_parse.layer.masksToBounds = true
        
        hist_my_bid.layer.borderWidth=1
        hist_my_bid.layer.cornerRadius = 8
        hist_my_bid.layer.masksToBounds = true
        
        hist_my_bid_status.layer.borderWidth=1
        hist_my_bid_status.layer.cornerRadius = 8
        hist_my_bid_status.layer.masksToBounds = true
        
        hist_images.layer.borderWidth=1
        hist_images.layer.cornerRadius = 8
        hist_images.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    // fixed panel
    
    @IBOutlet weak var hist_auct: UILabel!
    @IBOutlet weak var hist_endate: UILabel!
    @IBOutlet weak var hist_bid: UILabel!
    @IBOutlet weak var hist_result: UILabel!
    @IBOutlet weak var hist_panel: UIView!
    
    
    // changing panel
    @IBOutlet weak var hist_auct_name: UILabel!
    @IBOutlet weak var hist_endate_parse: UILabel!
    @IBOutlet weak var hist_my_bid: UILabel!
    @IBOutlet weak var hist_my_bid_status: UILabel!
    @IBOutlet weak var hist_images: UIImageView!
    @IBOutlet weak var hist_if_no_bid: UILabel!
    
    
    func fetch_bidded(){
        do{
            let param_to_send = param_username(username: NameParse)
            // CODE API
            let url = URL(string: "http://127.0.0.1:4242/my-bid-history")! // path to your LOCALHOST API
            var request = URLRequest(url: url)
            request.httpMethod = "POST" // HTTP METHODS
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(param_to_send)
            let task = URLSession.shared.dataTask(with: request){data, response, _ in guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200, let jsonValue = data else{
                return
                }// task
                do{
                    let respon_detail = try JSONDecoder().decode(get_history.self, from: jsonValue)
                    print(respon_detail.status[0])
                    if (respon_detail.status[0] == "empty"){
                        DispatchQueue.main.async {
                            bid_status = respon_detail.status[0]
                            //print("ITS EMPTY BOI")
                            self.hist_panel.isHidden = true
                
                        }
                        
                    }
                        
                    else if (respon_detail.status[0] != "empty"){
                        DispatchQueue.main.async {
                           self.hist_if_no_bid.text! = ""
                            self.hist_if_no_bid.isHidden = true
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
                            
                          
                            
                            let dec_b64 = Data(base64Encoded: selected_image, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                            
                           
                            
                            
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
}

struct param_username: Codable{
    let username: String
}

struct get_history: Codable{
    let status: [String]
}
