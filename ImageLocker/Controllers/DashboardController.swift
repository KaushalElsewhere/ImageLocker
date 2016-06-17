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

protocol DashboardControllerDelegate: class{
    func dashboardController(vc:DashboardController, didSelectFolder folder: String) -> Void
}
extension DashboardController{

    typealias FolderNamehandler = (String) -> Void
    func didClickAddItem(sender: AnyObject) {
        let pickerController = DKImagePickerController()
        
        pickerController.didSelectAssets = {[unowned self]  (assets: [DKAsset]) in
            if assets.count > 0 {
                
                self.showdialogForFolderName(){ folderName in
                    
                    let newFolder = FileManager.sharedInstance.createNewFolderWith(assets, name: folderName)
                    
                    let hashes  = FileManager.sharedInstance.hash
                    self.folders = Array(hashes.keys)
                    
                    
                    
                    /*
                    let images = FileManager.sharedInstance.convertAssetsToImages(assets)
                    print(images.count)
                    print(folderName)
                    
                    let folder = Model.Folder(
                        identifier: NSUUID().UUIDString,
                        name: folderName,
                        count: images.count,
                        images: images,
                        createdAt: NSDate(),
                        modifiedAt: NSDate()
                    )
                    
                    self.folders.append(folder)
                    */
                    self.tableView.reloadData()
                }
            }
            
        }
        
        self.presentViewController(pickerController, animated: true) {}
    }
    func showdialogForFolderName(completion: FolderNamehandler){
        let alert = UIAlertController(title: "Give your folder a name", message: nil, preferredStyle: .Alert)
        let done = UIAlertAction(title: "Done", style: .Default) { (action) in
            
            completion((alert.textFields?.first?.text)!)
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Folder name"
            textField.addTarget(self, action: #selector(self.didChangeinAlertTextField(_:)), forControlEvents: .EditingChanged)
        }
        done.enabled = false
        alert.addAction(cancel)
        alert.addAction(done)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func didChangeinAlertTextField(sender: AnyObject){
        if let alert:UIAlertController = self.presentedViewController as? UIAlertController{
            alert.message = nil;
            
            let text1 = (alert.textFields?.first)! as UITextField
            let done:UIAlertAction = alert.actions.last! as UIAlertAction
            let isTyped:Bool = text1.text?.characters.count > 0
            
            done.enabled = isTyped

        }
    }
}

extension DashboardController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let dict = FileManager.sharedInstance.hash[folders[indexPath.row]]!
        
        cell.textLabel?.text = dict["name"]! + " (\(dict["count"]!))"
        return cell
    }
}

extension DashboardController:UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        delegate?.dashboardController(self, didSelectFolder: folders[indexPath.row])
    }
}

extension DashboardController{
    override func setupViews() {
        readHashfromFileManager()
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
    
    func readHashfromFileManager(){
        self.folders = Array(FileManager.sharedInstance.hash.keys)
    }
}
class DashboardController: Controller {
    weak var delegate:DashboardControllerDelegate?
    
    var folders = [String]()
    
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
