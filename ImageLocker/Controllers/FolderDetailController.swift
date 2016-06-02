//
//  FolderDetailController.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 01/06/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit
import JTSImageViewController
extension FolderDetailController{
    override func setupViews(){
        self.view.addSubview(collectionView)
        self.view.addSubview(deleteButton)
        deleteButton.frame = CGRect(x: self.view.frame.size.width-80, y: self.view.frame.size.height-100, width: 50, height: 50)
        
        
        
        self.view.backgroundColor = K.Color.lightGray
    
        setupNav()
        setupConstraints()
    }
    override func setupConstraints() {
        let superView = view
        
        collectionView.snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(superView)
        }
        
        
    }
    func setupNav(){
        
        titleLabel.text = folder.name
        navigationItem.titleView = titleLabel
        
        editButton.addTarget(self, action: #selector(didClickOnEditBbi(_:)), forControlEvents: .TouchUpInside)
        let editBbi = UIBarButtonItem(customView: editButton)
        navigationItem.rightBarButtonItem = editBbi
    }
    func didClickOnEditBbi(sender:AnyObject){
        isEditMode = !isEditMode
        if isEditMode == true {
            editButton.setTitle("Cancel", forState: .Normal)
            titleLabel.text = "Select"
            navigationItem.hidesBackButton = true
            deleteButton.hidden = false
            
        } else {
            editButton.setTitle("Edit", forState: .Normal)
            titleLabel.text = folder.name
            navigationItem.hidesBackButton = false
            deleteButton.hidden = true
            
            let indexPaths:[NSIndexPath] = self.collectionView.indexPathsForSelectedItems()!
            for indexPath in indexPaths{
                self.collectionView.deselectItemAtIndexPath(indexPath, animated: false)
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FolderDetailCollectionCell
                cell.coverView.hidden = true
            }
        }
    }

}
extension FolderDetailController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.folder.images?.count)!
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! FolderDetailCollectionCell
        cell.imgView.image = self.folder.images![indexPath.row]
        
        
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        
//        let screenRect:CGRect = UIScreen.mainScreen().bounds
//        let screenWidth:CGFloat = screenRect.size.width
//        let cellWidth:CGFloat = CGFloat(screenWidth / 4.0) //Replace the divisor with the column count requirement. Make sure to have it in float.
//        let size:CGSize = CGSize(width: cellWidth, height: cellWidth)
//        
//        return size
//    }
}
extension FolderDetailController:UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FolderDetailCollectionCell
        if isEditMode == true {
            cell.coverView.hidden = false
        } else{
            showImageOnViewer(cell.imgView)
        }
        
        //showImageOnViewer(cell.imgView)
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FolderDetailCollectionCell
        if isEditMode == true {
            cell.coverView.hidden = true
        } else{
            //showImageOnViewer(cell.imgView)
        }
    }
    
    func showImageOnViewer(imageView:UIImageView) -> Void{
        
        let imageInfo:JTSImageInfo = JTSImageInfo()
        imageInfo.image = imageView.image
        imageInfo.referenceRect = imageView.frame
        imageInfo.referenceView = imageView.superview
        
        let imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: .Image, backgroundStyle: .Blurred)
        imageViewer.showFromViewController(self, transition: .FromOriginalPosition)
    }
}

class FolderDetailController: Controller{
    lazy var titleLabel:UILabel  = {
        let label = UILabel(frame:CGRect(x: 0, y: 0, width: 100, height: 20))
        label.font = K.Font.americanTypewriter.size(19)
        label.textAlignment = .Center
        label.textColor = .blackColor()
        
        return label
    }()
    lazy var editButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        button.setTitle("Edit", forState: .Normal)
        button.setTitleColor(.darkGrayColor(), forState: .Normal)
        return button
    }()
    
    lazy var deleteButton:UIButton = {
        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "deleteW"), forState: .Normal)
        button.backgroundColor = UIColor.cornflowerColor()
        button.layer.cornerRadius = 50/2
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 1.0
        button.hidden = true
        return button
    }()
    
    var isEditMode:Bool = false
    
    var folder:Model.Folder!
    
    lazy var collectionView: UICollectionView = {
        let screenSize = UIScreen.mainScreen().bounds
        let width = (screenSize.width/4)-4
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        
        //let width = CGFloat(self.view.frame.size.width)/4-15
        
        //let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 8, bottom: 10, right: 8)
        //layout.itemSize = CGSize(width: width, height: width)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(FolderDetailCollectionCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = .clearColor()
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()

}
//
