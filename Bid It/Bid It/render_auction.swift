//
//  render_auction.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 24/10/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

public var selected_startdate:String = ""
public var selected_enddate:String = ""
public var selected_desc:String = ""
public var selected_image:String = ""
public var selected_auction_name:String = ""

class render_auction:UIViewController{
    override func viewDidLoad() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.checkAction(sender:)))
        self.rounding_view.addGestureRecognizer(gesture)
        super.viewDidLoad()
        ui_corner.layer.borderWidth = 1
        ui_corner.layer.cornerRadius = 8
        ui_corner.layer.borderWidth = 1
        ui_corner.layer.cornerRadius = 8
        ui_corner.layer.borderWidth = 1
        ui_corner.layer.cornerRadius = 8
        rounding_view.layer.borderWidth = 1
        rounding_view.layer.cornerRadius = 8
        get_datas()
        
    }
    
    
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        
        print("tapped and it works")// -> call api class
        let viewit = storyboard?.instantiateViewController(withIdentifier: "detail_auction") as! detail_auction
        present(viewit, animated: true, completion: nil)
        
    } // add logic view tapped
    
    @IBAction func back_button(_ sender: UIButton) {
        self.auct_name.text = ""
        self.toko_lelang.text = ""
        self.start_date.text = ""
        self.end_date.text = ""
        self.image_auction.image = nil
        let viewit =  storyboard?.instantiateViewController(withIdentifier: "ZeroViewController") as! ZeroViewController
        present(viewit, animated: true)
        categories_home = ""
        resp.init(status: [""])
    }
    @IBOutlet weak var ui_corner: UIButton!
    @IBOutlet weak var auct_name: UILabel!
    @IBOutlet weak var toko_lelang: UILabel!
    @IBOutlet weak var start_date: UILabel!
    @IBOutlet weak var end_date: UILabel!
    @IBOutlet weak var image_auction: UIImageView!
    
    @IBOutlet weak var rounding_view: UIView!
    // view  tapped
    
    
    
    func get_datas(){
        var ResponseInFunc:String = ""
        do{
            let param_to_send = send_to_api(category: categories_home)
            // CODE API
            let url = URL(string: "http://127.0.0.1:4242/get-auction")! // path to your LOCALHOST API
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
                    let respon = try JSONDecoder().decode(resp.self, from: jsonValue)
                    ResponseInFunc = respon.status[0]
                    print(ResponseInFunc)
                    
                    
                    /* if response meet the requirements of what you desired and you want to call clas viewcontroller or set text to the
                     GUI, always use DispatchQueue.main.async { } but make sure you declared it before the declaration of URLSession.shared.dataTask
                     */
                    
                    DispatchQueue.main.async {
                        self.auct_name.text = respon.status[0]
                        self.start_date.text = respon.status[5]
                        self.end_date.text = respon.status[6]
                        self.toko_lelang.text = respon.status[4]
                        
                        // setting it for other classes
                        selected_auction_name = respon.status[0]
                        selected_startdate = respon.status[5]
                        selected_enddate = respon.status[5]
                        selected_desc = respon.status[2]
                        selected_image = respon.status[3]
                        
//                        self.category_id.text = respon.status[1]
//                        self.auction_description.text = respon.status[2]
                        
                        
                        
                        // parsing from base64 to image
                        let dec_b64 = Data(base64Encoded: respon.status[3], options: Data.Base64DecodingOptions.ignoreUnknownCharacters)

                        self.image_auction.image = UIImage.init(data: dec_b64!)
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
    
  
}// whole class

struct resp: Codable {
    let status: [String]
}// response

struct send_to_api: Codable{
    let category: String
}
