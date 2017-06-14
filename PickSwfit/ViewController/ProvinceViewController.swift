//
//  ProvinceViewController.swift
//  PickSwfit
//
//  Created by hydom on 2017/6/13.
//  Copyright © 2017年 Liu. All rights reserved.
//

import UIKit
import SwiftyJSON

let CELLIDENTIFIER = "cellidentifier"

class ProvinceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var stringIds:String!
    var appendString:String!
    
    var provinceData = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let topView = UIView(frame:CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 40))
        topView.backgroundColor = UIColor.orange
        tableView.tableHeaderView = topView
        topView.addSubview(button)
        view.addSubview(tableView)
        
        provinceNetworking()
    }
    
    //MARK - 市级数据请求
    func provinceNetworking(){
        let i = (stringIds as NSString).integerValue
        let strs = "http://apis.map.qq.com/ws/district/v1/getchildren?&id=\(i)&key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV"
        SwfitAFNetworking.get(urlString:strs, parameters: nil, success: { (responseObject) in
            
            let json = JSON(responseObject as Any)["result"]
            self.provinceData = json[0].arrayObject!
            
            
            print(self.provinceData)
            self.tableView.reloadData()
        }) { (error) in
            print("错误值:\(error)")
        }
    }
    
    fileprivate lazy var button: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.frame = CGRect.init(x: SCREEN_W-100, y: 10, width: 100, height: 30)
        button .setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = NSTextAlignment.right
        button .setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action:#selector(tapped) , for: .touchUpInside)
        return button
    }()
    
    //MARK - 获取按钮点击事件
    func tapped(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    fileprivate lazy var tableView:UITableView = {
        
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self,forCellReuseIdentifier:CELLIDENTIFIER)
        return tableView
        
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.provinceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLIDENTIFIER)
        var dic = Dictionary<String,Any>()
        dic = self.provinceData[indexPath.row] as! Dictionary<String, Any>
        cell?.textLabel?.text = dic["fullname"] as? String
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var dic = Dictionary<String,Any>()
        dic = self.provinceData[indexPath.row] as! Dictionary<String, Any>
        //MARK - 跳转控制器
        let street = StreetViewController()
        street.streetIds = dic["id"] as! String
        
        let appString = dic["fullname"] as! String
        street.allApendString = self.appendString  + appString
        self.present(street, animated: true, completion: nil)
        
    }
    
    
}
