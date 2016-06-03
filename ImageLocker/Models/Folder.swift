//
//  Folder.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 02/06/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit

class Folder: NSObject, NSCoding {
    var identifier: String
    var name: String
    //var count: Int32
    
    var images: [UIImage]
    
    var createdAt: NSDate
    var modifiedAt: NSDate
    
    init(identifier:String = NSUUID().UUIDString, name:String, images: [UIImage], createdAt:NSDate = NSDate(), modifiedAt:NSDate = NSDate() ){
        self.identifier = identifier
        self.name = name
        //self.count = count
        self.images = images
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
        
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let identifier = decoder.decodeObjectForKey("identifier") as? String,
        let name = decoder.decodeObjectForKey("name") as? String,
        let images = decoder.decodeObjectForKey("images") as? [UIImage],
        let createdAt = decoder.decodeObjectForKey("createdAt") as? NSDate,
        let modifiedAt = decoder.decodeObjectForKey("modifiedAt") as? NSDate
        else { return nil }
        
        self.init(
            identifier:identifier,
            name:  name,
            //count: decoder.decodeIntForKey("count"),
            images: images,
            createdAt: createdAt,
            modifiedAt: modifiedAt
        )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.identifier,forKey: "identifier")
        aCoder.encodeObject(self.name,forKey: "name")
        aCoder.encodeObject(self.images,forKey: "images")
        aCoder.encodeObject(self.createdAt,forKey: "createdAt")
        aCoder.encodeObject(self.modifiedAt,forKey: "modifiedAt")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
