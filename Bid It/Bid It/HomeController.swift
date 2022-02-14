//
//  HomeController.swift
//  Bid It
//
//  Created by I Komang Sughosa Anantawijaya on 10/04/21.
//  Copyright © 2021 I Komang Sughosa Anantawijaya. All rights reserved.
//

import Foundation
import UIKit

public var categories_home: String = ""

class HomeController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var table_view_explore: UITableView!

    @IBOutlet weak var label_saldo: UILabel!
    
   // @IBOutlet weak var spam_test: UILabel!
    var articles: [HomeExploreStructs] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label_saldo.text = "Rp. 5.000.000"
        articles = HomeExploreStructs.getdata()
        table_view_explore.delegate=self
        table_view_explore.dataSource=self
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let datas = articles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeExploreCell") as! HomeExploreCell
        cell.seteverythinng(article: datas)
        
        return cell
    }
    
    
    
    // buttons
    @IBAction func button_electronic(_ sender: UIButton) {
        print("[+]HomeController: eletronic touched")
        categories_home = "tech"
        let view_render_auction = storyboard?.instantiateViewController(withIdentifier: "render_auction") as! render_auction
        present(view_render_auction, animated: true, completion: nil)
        
    }
    
    
    @IBAction func button_fashion(_ sender: UIButton) {
        print("[+]HomeController: fashion touched")
        categories_home = "fashion"
        let view_render_auction = storyboard?.instantiateViewController(withIdentifier: "render_auction") as! render_auction
        present(view_render_auction, animated: true, completion: nil)
    }
    
    
    @IBAction func button_automotive(_ sender: UIButton) {
        print("[+]HomeController: automotive touched")
        categories_home = "automotive"
        let view_render_auction = storyboard?.instantiateViewController(withIdentifier: "render_auction") as! render_auction
        present(view_render_auction, animated: true, completion: nil)
    }
    
    
    
    @IBAction func button_game(_ sender: UIButton) {
        print("[+]HomeController: game touched")
        categories_home = "game"
        let view_render_auction = storyboard?.instantiateViewController(withIdentifier: "render_auction") as! render_auction
        present(view_render_auction, animated: true, completion: nil)
    }
    
    
    
    
    
}

