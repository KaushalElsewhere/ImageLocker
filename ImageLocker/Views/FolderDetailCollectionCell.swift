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
        coverView.addSubview(checkmark)
        imgView.addSubview(coverView)
        contentView.addSubview(imgView)
    
        backgroundColor = .whiteColor()
        
        setupConstraints()
    }
    override func setupConstraints() {
        let superView = contentView
        
        imgView.snp_makeConstraints { (make) in
            make.edges.equalTo(superView).inset(5)
        }
        
        coverView.snp_makeConstraints { (make) in
            make.edges.equalTo(imgView)
        }
        checkmark.snp_makeConstraints { (make) in
            make.width.height.equalTo(32)
            make.centerX.equalTo(coverView.snp_centerX)
            make.centerY.equalTo(coverView.snp_centerY)
        }
        
    }
}
class FolderDetailCollectionCell: CollectionCell {
    lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var coverView:UIView = {
       let view = UIView()
        view.backgroundColor = .whiteColor()
        view.alpha = 0.4
        view.hidden = true
        
        return view
    }()
    
    lazy var checkmark:UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.image = UIImage(named: "check")!
        return imageView
    }()
}
