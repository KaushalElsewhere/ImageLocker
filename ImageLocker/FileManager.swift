//
//  FileManager.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 31/05/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit
import DKImagePickerController

class FileManager{
    private let defaults = NSUserDefaults.standardUserDefaults()
    static let sharedInstance = FileManager()
    var hash = [String : [String:String]]()
    
    func createNewFolderWith(assets: [DKAsset], name:String ) -> Folder{
        
        let images = convertAssetsToImages(assets)
        
    
        let folder = Folder()
        let id = NSUUID().UUIDString
        folder.identifier = id
        folder.name = name
        folder.count = images.count
        
        
        let data : NSData = NSKeyedArchiver.archivedDataWithRootObject(folder)
        let key = id
        defaults.setObject(data, forKey: key)
        
        let dict = ["name" : name,
                    "count": String(images.count)]
        
        
        hash[key] = dict
        defaults.setObject(hash, forKey: "hash")
        
        return folder
    }
    
    func convertAssetsToImages(assets: [DKAsset]) -> [UIImage]{
        var images:[UIImage] = []
        
        for asset in assets{
            asset.fetchOriginalImage(true, completeBlock: { (image, info) in
                if let img = image{
                    images.append(img)
                }
                
            })
        }
        
        return images
    }

    
    
    
}
