//
//  detail_auction.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 31/10/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

class detail_auction: UIViewController, UITextFieldDelegate{
    override func viewDidLoad() {
       
        rounding_top_bid.layer.cornerRadius = 8
        rounding_top_bid.layer.borderWidth = 1
        rounding_back_button.layer.borderWidth = 1
        rounding_back_button.layer.cornerRadius = 8
        rounding_bid_now.layer.borderWidth = 1
        rounding_bid_now.layer.cornerRadius = 8
        uitextfieldonlynumber.delegate = self
        rounding_about_view.layer.borderWidth = 1
        rounding_about_view.layer.cornerRadius = 8
        rounding_auctions.layer.borderWidth = 1
        rounding_auctions.layer.cornerRadius = 8
        
        super.viewDidLoad()
        print("detail loaded")
        start_date.text = selected_startdate
        end_date.text = selected_enddate
        bid_name.text = selected_auction_name
        let dec_b64 = Data(base64Encoded: selected_image, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        auction_image_detail.image = UIImage.init(data: dec_b64!)
        description_detail.text = selected_desc
        get_datas()
        
        
    }// override did load
    
    @IBOutlet weak var start_date: UILabel!
    @IBOutlet weak var end_date: UILabel!
    @IBOutlet weak var bid_name: UILabel!
    @IBOutlet weak var top_bid_one: UILabel!
    @IBOutlet weak var top_bid_two: UILabel!
    @IBOutlet weak var top_bid_three: UILabel!
    @IBOutlet weak var bid_user_one: UILabel!
    @IBOutlet weak var bid_user_two: UILabel!
    @IBOutlet weak var bid_user_three: UILabel!
    @IBOutlet weak var bid_description: UILabel!
    
    
    @IBOutlet weak var rounding_top_bid: UIView!
    
    @IBOutlet weak var top_bidder_label: UILabel!
    @IBOutlet weak var label_numone: UILabel!
    @IBOutlet weak var label_numtwo: UILabel!
    @IBOutlet weak var label_numthree: UILabel!
    @IBOutlet weak var uitextfieldonlynumber: UITextField!
    
    @IBOutlet weak var rounding_about_view: UIView!
    @IBOutlet weak var auction_image_detail: UIImageView!
    @IBOutlet weak var description_detail: UILabel!
    
    @IBOutlet weak var rounding_auctions: UIView!
    @IBAction func back_to_render(_ sender: UIButton) {
        let view_render_auction = storyboard?.instantiateViewController(withIdentifier: "render_auction") as! render_auction
        present(view_render_auction, animated: true, completion: nil)
    }
    @IBOutlet weak var rounding_back_button: UIButton!
    
    @IBAction func bid_now(_ sender: UIButton) {
        //let price_value = try Int(uitextfieldonlynumber.text!)
        //place_bid(price: price_value!)
        print("DEBUG IN PLACE BID")
        print(uitextfieldonlynumber.text!)
        if (uitextfieldonlynumber.text! != ""){
            let price_value = Int(uitextfieldonlynumber.text!)
            
            
            
            //place_bid(price: Int(uitextfieldonlynumber.text))
            print("bid price" + uitextfieldonlynumber.text!)
            print("auction name " + selected_auction_name)
            print("name " + NameParse)
            place_bid(price: price_value!)
        }
       
        
    }// bid now
    
    @IBOutlet weak var rounding_bid_now: UIButton!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
    
    func get_datas(){
        var ResponseInFunc:String = ""
        do{
            let param_to_send = sending_param(auction: selected_auction_name)
            // CODE API
            let url = URL(string: "http://127.0.0.1:4242/get-place-bid")! // path to your LOCALHOST API
            var request = URLRequest(url: url)
            request.httpMethod = "POST" // HTTP METHODS
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(param_to_send)
            let task = URLSession.shared.dataTask(with: request){data, response, _ in guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200, let jsonValue = data else{
                return
                }
                
                // the entire task
                print("JSON VALUE \(jsonValue)")
                
                // get response
                do{
                    let respon = try JSONDecoder().decode(receiving_placebid.self, from: jsonValue)
                    for (i) in respon.status.enumerated(){
                        print(i)
                    }
                    
                    
                    /* if response meet the requirements of what you desired and you want to call clas viewcontroller or set text to the
                     GUI, always use DispatchQueue.main.async { } but make sure you declared it before the declaration of URLSession.shared.dataTask
                     */
                    
                    DispatchQueue.main.async {
                        // set name
                        print(respon.status.count)
                        if (respon.status[0] != "empty" && respon.status.count == 6){
                            self.top_bid_one.text = respon.status[0]
                            self.top_bid_two.text = respon.status[2]
                            self.top_bid_three.text = respon.status[4]
                            
                            // set bid
                            self.bid_user_one.text = "Rp. " + respon.status[1]
                            self.bid_user_two.text = "Rp. " + respon.status[3]
                            self.bid_user_three.text = "Rp. " + respon.status[5]
                        }
                        else if(respon.status.count == 2){
                             self.top_bid_one.text = respon.status[0]
                             self.bid_user_one.text = "Rp. " + respon.status[1]
                             self.top_bid_two.text = ""
                             self.top_bid_three.text = ""
                             self.bid_user_two.text = ""
                             self.bid_user_three.text = ""
                             self.label_numtwo.text = ""
                             self.label_numthree.text = ""
                            
                        }
                        else if(respon.status.count == 4){
                            self.top_bid_one.text = respon.status[0]
                            self.bid_user_one.text = "Rp. " + respon.status[1]
                            self.top_bid_two.text = respon.status[2]
                            self.top_bid_three.text = ""
                            self.bid_user_two.text = "Rp. " + respon.status[3]
                            self.bid_user_three.text = ""
                            self.label_numthree.text = ""
                        }
                        else{
                            self.top_bid_one.text = ""
                            self.top_bid_two.text = ""
                            self.top_bid_three.text = ""
                            self.bid_user_one.text = ""
                            self.bid_user_two.text = ""
                            self.bid_user_three.text = ""
                            self.top_bidder_label.text = "no bidder yet"
                            self.label_numone.text = ""
                            self.label_numtwo.text = ""
                            self.label_numthree.text = ""
                            
                            
                        }
                        
                        // set bid placed
                        print("setted")
                    } // dispatch
                    
                    
                    
                }catch{
                    print("Error value: \(error.localizedDescription)")
                    
                } // catch
                
            } // task
            task.resume()
            
        }// do
            
        catch{
            print("error lagi")
        }// catch
        
    }// get_datas
    
    // place bid
    func place_bid(price: Int){
        print(price)
        do{
            let param_to_send = place_bid_param(auction: selected_auction_name, bid_price: price, username: NameParse)
            // CODE API
            let url = URL(string: "http://127.0.0.1:4242/place-user-bid")! // path to your LOCALHOST API
            var request = URLRequest(url: url)
            request.httpMethod = "POST" // HTTP METHODS
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(param_to_send)
            let task = URLSession.shared.dataTask(with: request){data, response, _ in guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200, let jsonValue = data else{
                return
                }// task
                do{
                    let respon_detail = try JSONDecoder().decode(receiving_placebid.self, from: jsonValue)
                    
                    DispatchQueue.main.async {
                        print(respon_detail.status[0])
                        self.viewDidLoad()
                    }
                } catch{
                    print("Error value: \(error.localizedDescription)")
                }// catch & do
        }
            task.resume()
        }catch{
            print("error lagi")
            } // catch
        
    }// place bid

    
}// whole class





struct receiving_placebid: Codable {
    let status: [String]
}// response

struct sending_param: Codable{
    let auction: String
}

struct place_bid_param: Codable {
    let auction: String
    let bid_price: Int
    let username: String
}
