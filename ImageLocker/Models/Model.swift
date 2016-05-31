//
//  Model.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 28/05/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit

struct Model{
    
    struct Image {
        let identifier: String
        let image: UIImage
        let folderId: String
        let createdAt: NSDate?
        let modifiedAt: NSDate?
    }
    
    struct Folder {
        let identifier: String
        let name: String
        let createdAt: NSDate?
        let modifiedAt: NSDate?
    }
}
