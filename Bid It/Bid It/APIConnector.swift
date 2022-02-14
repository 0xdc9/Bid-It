//
//  APIConnector.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 03/05/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation

enum Errcode: Error{
    case gawork
    case decodeerror
    case weloz_noidea
}

enum success{
    case itworks
}
struct APIuri{
    let FIXURL: URL
    init(path: String, ResponseApi: String) {
        let parsing = "http://127.0.0.1:4242/\(path)"
        guard let FIXURL = URL(string: parsing) else {fatalError()}
        self.FIXURL = FIXURL
    }// init
    
    
    
    mutating func call_api(_ value:LoginValue, complete:@escaping(Result<ResponseAPILogin, Errcode>) -> Void){
        var fixed_code: String = ""
        do{
            // preparing data
            var requests = URLRequest(url: FIXURL)
            requests.httpMethod = "POST"
            requests.addValue("application/json", forHTTPHeaderField: "Content-Type")
            requests.httpBody = try JSONEncoder().encode(value)
            
            
            // action
            let task = URLSession.shared.dataTask(with: requests){data, response, _ in guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200, let jsonValue = data else{
                    complete(.failure(.gawork))
                    return
                }
             // the entire task
            
                print("[+] APIConnector : JSON VALUE \(jsonValue)")
            // get response
                do{
                    let respon = try JSONDecoder().decode(ResponseAPILogin.self, from: jsonValue)
                    print("[+] APIConnector: Code respon: \(respon.code)")
                    //print(respon.password)
                    fixed_code = respon.code
                    complete(.success(respon))
                    
                }catch{
                    print("[+] APIConnector : error dibawah")
                    print(error)
                    complete(.failure(.decodeerror))
                }
            } // task
            
            task.resume()
        } // do
        catch{
            complete(.failure(.weloz_noidea))
        } // catch
        
    }//call_api
    
    
    mutating func call_api_signup(_ value:RegisterValue, complete:@escaping(Result<ResponseAPI, Errcode>) -> Void){
        var fixed_code: String = ""
        do{
            // preparing data
            var requests = URLRequest(url: FIXURL)
            requests.httpMethod = "POST"
            requests.addValue("application/json", forHTTPHeaderField: "Content-Type")
            requests.httpBody = try JSONEncoder().encode(value)
            
            
            // action
            let task = URLSession.shared.dataTask(with: requests){data, response, _ in guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200, let jsonValue = data else{
                complete(.failure(.gawork))
                return
                }
                // the entire task
                
                print("[+] APIConnector : JSON VALUE \(jsonValue)")
                // get response
                do{
                    let respon = try JSONDecoder().decode(ResponseAPI.self, from: jsonValue)
                    print("[+] APIConnector: Code respon: \(respon.code)")
                    //print(respon.password)
                    fixed_code = respon.code
                    complete(.success(respon))
                    
                }catch{
                    print("[+] APIConnector : error dibawah")
                    print(error)
                    complete(.failure(.decodeerror))
                }
            } // task
            
            task.resume()
        } // do
        catch{
            complete(.failure(.weloz_noidea))
        } // catch
        
    }//call_api
}// apiuri

struct ResponseAPILogin:Codable {
    let code: String
    let username: String
    let gender: String
    let email: String
    let phonenumber: String
    let birthday: String
    let profilepic: String
}

struct ResponseAPI:Codable {
    let code: String
}
