//
//  ViewController.swift
//  PickSwfit
//
//  Created by hydom on 2017/5/24.
//  Copyright © 2017年 Liu. All rights reserved.
//

import UIKit
import SwiftyJSON
let  SCREEN_W = UIScreen.main.bounds.size.width
let  SCREEN_H = UIScreen.main.bounds.size.height
let  CELLNAME = "cellIdenit"



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //    lazy var tableView : UITableView = UITableView()
    var cityData = Array<Any>()
    override func viewDidLoad() {
        super.viewDidLoad()
        let topView = UIView(frame:CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 64))
        topView.backgroundColor = UIColor.lightGray
        tableView.tableHeaderView = topView
        view.addSubview(tableView)
        view.addSubview(label)
        httpNetwork()
    }
    
    // MARK: - 网络数据请求
    func httpNetwork(){
        let strs = "http://apis.map.qq.com/ws/district/v1/list?key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV"
        SwfitAFNetworking.get(urlString:strs, parameters: nil, success: { (responseObject) in
            print(responseObject!["result"]);
            let json = JSON(responseObject as Any)["result"]
            self.cityData = json[0].arrayObject!
            //            print(self.cityData.count)
            self.tableView.reloadData()
        }){ (error) in
            print("错误的,\(error)")
        }
        
    }
    
    
    // MARK: - Lazy Load
    fileprivate lazy var tableView:UITableView = {
        
        let tableView =  UITableView(frame:CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H) , style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self,forCellReuseIdentifier:CELLNAME)
        return tableView
        
    }()
    
    fileprivate lazy var label:UILabel = {
        let label = UILabel(frame: CGRect.init(x: SCREEN_W/2-50, y: 20, width: 120, height: 30))
        label.text = "拉取网络城市列表"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        return label
        
    }()
    
    
    
    // MARK: - delegate、datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLNAME)
        
        //MARK - 获取数据
        var dic = Dictionary<String,Any>()
        dic = self.cityData[indexPath.row] as! Dictionary<String, Any>
        cell?.textLabel?.text = (dic["fullname"] as! String)
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        //        print("打印\(String(describing: dic["fullname"]))")
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var dic = Dictionary<String,Any>()
        dic = self.cityData[indexPath.row] as! Dictionary<String, Any>
        //MARK - 跳转控制器
        let pro = ProvinceViewController()
        pro.stringIds = dic["id"] as! String
        pro.appendString = dic["fullname"] as! String
        self.present(pro, animated: true, completion: nil)
        
        
        
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //            return 25;
    //        }
    
}












