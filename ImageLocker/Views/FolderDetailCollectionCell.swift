//
//  FolderDetailCollectionCell.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 01/06/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit
extension FolderDetailCollectionCell{
    override func setupViews() {
        contentView.addSubview(imgView)
        backgroundColor = .whiteColor()
        //self.layer.borderColor = UIColor.blackColor().CGColor
        //self.layer.cornerRadius = 5.0
        //self.layer.borderWidth = 1.0
        
        setupConstraints()
    }
    override func setupConstraints() {
        let superView = contentView
        
        imgView.snp_makeConstraints { (make) in
            make.edges.equalTo(superView).inset(5)
        }
    }
}
class FolderDetailCollectionCell: CollectionCell {
    lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
}
