//
//  StreetViewController.swift
//  PickSwfit
//
//  Created by hydom on 2017/6/13.
//  Copyright © 2017年 Liu. All rights reserved.
//

import UIKit
import SwiftyJSON


let CELLINDENTI = "cellstreet"
class StreetViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    var streetIds:String!
    var allApendString:String!
    var streetAppendingString:String!
    var streetArray = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELLINDENTI)
        self.button .addTarget(self, action: #selector(onclck), for: .touchUpInside)
        streetNetworking()
    }
    
    //MARK - 按钮点击事件
    func onclck(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK - 获取网络
    func streetNetworking(){
        
        let i = (streetIds as NSString).integerValue
        let url = "http://apis.map.qq.com/ws/district/v1/getchildren?&id=\(i)&key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV"
        
        SwfitAFNetworking.get(urlString: url, parameters: nil, success: { (responseObject) in
            
            let json = JSON(responseObject as Any)["result"]
            self.streetArray = json[0].arrayObject!
            
            self.tableView.reloadData()
            
        }) { (error) in
            print(error)
        }
    }
    
    
    //MARK - delegate、datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.streetArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLINDENTI)
        
        var dic = Dictionary<String,Any>()
        dic = self.streetArray[indexPath.row] as! Dictionary<String, Any>
        cell?.textLabel?.text = dic["fullname"] as? String
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var dic = Dictionary<String,Any>()
        dic = self.streetArray[indexPath.row] as! Dictionary<String, Any>
        let str = dic["fullname"] as! String
        self.streetAppendingString = self.allApendString + str
        let alterView = UIAlertController(title: "获取位置:", message: self.streetAppendingString, preferredStyle: .alert)
        let actions = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alterView.addAction(actions)
        self.present(alterView, animated: true, completion: nil)
    }
    
    
//    fileprivate lazy var alterView:UIAlertController = {
//        let alterView = UIAlertController(title: "获取位置:", message: self.streetAppendingString, preferredStyle: .alert)
//
//        let actions = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//        alterView.addAction(actions)
//        self.present(alterView, animated: true, completion: nil)
//        return alterView
//    }()
}
