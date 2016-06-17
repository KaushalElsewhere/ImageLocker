//
//  FolderDetailController.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 01/06/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit
import JTSImageViewController
import ImageViewer


//MARK: Methods
extension FolderDetailController{
    func didClickOnEditBbi(sender: AnyObject){
        isEditMode = !isEditMode
        
        let indexPaths:[NSIndexPath] = self.collectionView.indexPathsForSelectedItems()!
        for indexPath in indexPaths{
            self.collectionView.deselectItemAtIndexPath(indexPath, animated: false)
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FolderDetailCollectionCell
            cell.coverView.hidden = true
        }
        
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
            
            
        }
    }
    
    func readAllFolderImagesFromDefault(){
        if let folder = FileManager.sharedInstance.readFolderFromDefaultForKey(self.folderIdentifier) as? Folder {
            self.folder = folder
            collectionView.collectionViewLayout =  createLayoutwithCellCount(self.folder.images.count ?? 0)
        }
    }
    
    func didSelectDeleteBtn(sender: AnyObject){
        
//        let defaultStyle = UIAlertController
//        
//        MZAlertControllerStyle *defaultStyle = [UIAlertController mz_sharedStyle];
//        defaultStyle.blurEffectStyle = UIBlurEffectStyleDark;
//        defaultStyle.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        
        
        let alert = UIAlertController(title: "Lorem Ipsum", message: "Haqoona matata, yaaro, ghum ko maaro goli.", preferredStyle: .Alert)
        
        let done = UIAlertAction(title: "Done", style: .Default) { (action) in
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(done)
        
        
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension FolderDetailController{
    override func setupViews(){
        
        readAllFolderImagesFromDefault()
        
        self.view.addSubview(collectionView)
        self.view.addSubview(deleteButton)
        deleteButton.frame = CGRect(x: self.view.frame.size.width-80, y: self.view.frame.size.height-100, width: 50, height: 50)
        
        deleteButton.addTarget(self, action: #selector(didSelectDeleteBtn(_:)), forControlEvents: .TouchUpInside)
        
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
    

}
extension FolderDetailController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.folder.images.count)
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! FolderDetailCollectionCell
        cell.imgView.image = self.folder.images[indexPath.row]
        
        
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
            cell.selected = true
            //showImageOnViewer(cell.imgView)
            
            showGalleryImageViewer(cell.contentView,selectedIndex: indexPath.row)
        }
        
        //showImageOnViewer(cell.imgView)
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FolderDetailCollectionCell
        if isEditMode == true {
            cell.coverView.hidden = true
        } else{
            //showImageOnViewer(cell.imgView)
            showGalleryImageViewer(cell.contentView,selectedIndex: indexPath.row)
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
extension FolderDetailController{
    func showGalleryImageViewer(displacedView: UIView, selectedIndex index:Int) {
        
        let imageProvider = SomeImageProvider()
        imageProvider.images = self.folder.images
        
//        let frame = CGRect(x: 0, y: 0, width: 200, height: 24)
//        let headerView = CounterView(frame: frame, currentIndex: displacedView.tag, count: self.folder.images.count)
//        let footerView = CounterView(frame: frame, currentIndex: displacedView.tag, count: images.count)
        
        let galleryViewController = GalleryViewController(imageProvider: imageProvider,
                                                          displacedView: displacedView,
                                                          imageCount: folder.images.count,
                                                          startIndex: index)
//        galleryViewController.headerView = headerView
//        galleryViewController.footerView = footerView
        
//        galleryViewController.launchedCompletion = { print("LAUNCHED") }
//        galleryViewController.closedCompletion = { print("CLOSED") }
//        galleryViewController.swipedToDismissCompletion = { print("SWIPE-DISMISSED") }
        
//        galleryViewController.landedPageAtIndexCompletion = { index in
//            
//            print("LANDED AT INDEX: \(index)")
//            
////            headerView.currentIndex = index
////            footerView.currentIndex = index
//        }
        
        self.presentImageGallery(galleryViewController)
    }
    
}
class SomeImageProvider: ImageProvider {
    var images: [UIImage]!
    func provideImage(completion: UIImage? -> Void) {
        completion(images.first)
    }
    
    func provideImage(atIndex index: Int, completion: UIImage? -> Void) {
        completion(images[index])
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
    
    var folder:Folder!
    var folderIdentifier:String!
    
    var layout:UICollectionViewFlowLayout{
        return self.createLayoutwithCellCount(3)
    }
    
    lazy var collectionView: UICollectionView = {
        
    
        //let width = CGFloat(self.view.frame.size.width)/4-15
        
        //let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 8, bottom: 10, right: 8)
        //layout.itemSize = CGSize(width: width, height: width)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(FolderDetailCollectionCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = .clearColor()
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    func createLayoutwithCellCount(count:Int) -> UICollectionViewFlowLayout {
        
        var number:Int
        
        switch count {
        case 1...5:
            number = 2
        case 6...11:
            number = 3
        case 12...100000000000:
            number = 4
        default:
            fatalError("image count is beyond limit, please check and correct")
        }
        
        
        let screenSize = UIScreen.mainScreen().bounds
        let width = (screenSize.width/CGFloat(number)) - CGFloat(number+2)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 3
        return layout
    }
}
//
