//
//  CollectionCell.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 01/06/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
}
