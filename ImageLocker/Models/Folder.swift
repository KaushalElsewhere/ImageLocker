//
//  Folder.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 02/06/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit

class Folder: NSObject {
    var identifier: String = ""
    var name: String = ""
    var count: Int = 0
    
    var images: [UIImage]? = nil
    
    var createdAt: NSDate? = NSDate()
    var modifiedAt: NSDate? = NSDate()
}
