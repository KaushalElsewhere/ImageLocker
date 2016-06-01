//
//  FolderDetailController.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 01/06/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit
extension FolderDetailController{
    override func setupViews(){
        self.view.addSubview(collectionView)
        
        self.view.backgroundColor = K.Color.lightGray
    
        setupConstraints()
    }
    override func setupConstraints() {
        let superView = view
        
        collectionView.snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(superView)
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        let screenRect:CGRect = UIScreen.mainScreen().bounds
        let screenWidth:CGFloat = screenRect.size.width
        let cellWidth:CGFloat = CGFloat(screenWidth / 4.0) //Replace the divisor with the column count requirement. Make sure to have it in float.
        let size:CGSize = CGSize(width: cellWidth, height: cellWidth)
        
        return size
    }
}
extension FolderDetailController:UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

class FolderDetailController: Controller{
    
    var folder:Model.Folder!
    
    lazy var collectionView: UICollectionView = {
        let width = CGFloat(self.view.frame.size.width)/4-15
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 8, bottom: 10, right: 8)
        //layout.itemSize = CGSize(width: width, height: width)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(FolderDetailCollectionCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = .clearColor()
        return collectionView
    }()

}
