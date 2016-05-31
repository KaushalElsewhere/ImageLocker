//
//  DashboardController.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 27/05/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit
import SnapKit
import DGElasticPullToRefresh
import DKImagePickerController

extension DashboardController{
    func didClickAddItem(sender: AnyObject) {
        let pickerController = DKImagePickerController()
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets")
            print(assets)
            
        }
        
        self.presentViewController(pickerController, animated: true) {}
    }
}

extension DashboardController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        return cell
    }
}

extension DashboardController:UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

extension DashboardController{
    override func setupViews() {
        view.addSubview(tableView)
        
        view.backgroundColor = K.Color.lightGray
        tableView.dataSource = self
        tableView.delegate = self
        
        setupNav()
        setupConstraints()
    }
    
    override func setupConstraints() {
        let superView = self.view
        
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(superView)
        }
    }
    
    func setupNav(){
        let titleLabel = UILabel(frame:CGRect(x: 0, y: 0, width: 100, height: 20))
        titleLabel.font = K.Font.americanTypewriter.size(19)
        titleLabel.text = "Folders"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = .blackColor()
        navigationItem.titleView = titleLabel
        
        let bbitem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(didClickAddItem(_:)))
        navigationItem.rightBarButtonItem = bbitem
    }
    
}
class DashboardController: Controller {
    
    var folders:[Model.Folder]?
    
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        //tableView.separatorStyle = .None
        tableView.backgroundColor = .clearColor()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        let header = UIView(frame:CGRect(x: 0, y: 0, width: 0, height: 60))
        tableView.tableHeaderView = header
        return tableView
    }()
    
}
