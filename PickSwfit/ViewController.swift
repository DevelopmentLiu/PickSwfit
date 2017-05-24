//
//  ViewController.swift
//  PickSwfit
//
//  Created by hydom on 2017/5/24.
//  Copyright © 2017年 Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //懒加载
//    lazy var tableView : UITableView = UITableView()
    var tableView :UITableView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        
        httpNetwork()
    }
}

extension ViewController{

    func setupUI(){
        self.tableView = UITableView(frame: CGRect.init(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height-64), style: .grouped)
        self.tableView?.dataSource = self;
        self.tableView?.delegate = self;
        self.view.addSubview(tableView!)
    }
    
    func httpNetwork(){
        let strs = ""
        SwfitAFNetworking.get(urlString:strs, parameters: nil, success: { (responseObject) in
//            print("这是正确的",responseObject!["result"]);
            
            let dataArray = responseObject?["result"] as! NSArray
            
            let cityArray = dataArray[0] as! NSArray
            
            print("这是请求的省市级数据 \(dataArray[0])");
            
            print(cityArray.count)
            
        }) { (error) in
            print("这是错误的",error)
        }
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CellIdent = "cellIdenit"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdent)
        
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: CellIdent)
            cell?.textLabel?.text = "Don't worry, you will be OK"
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headView = UIView()
        headView.backgroundColor = UIColor.orange
        let labels = UILabel()
        labels.frame = CGRect.init(x: 0, y: 0, width: 130, height: 30)
        labels.textColor = UIColor.white
        labels.text = "This is a monster"
        labels.textAlignment = NSTextAlignment.center
        labels.font = UIFont.systemFont(ofSize: 14)
        headView.addSubview(labels)
        return headView;
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    
    
    
    
}
