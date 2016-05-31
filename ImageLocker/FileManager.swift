//
//  FileManager.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 31/05/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//

import UIKit
import DKImagePickerController

class FileManager: NSObject{
    static let sharedInstance = FileManager()
    
//    func createNewFolderWith(assets: [DKAsset]) -> Model.Folder{
//        let id = NSUUID().UUIDString
//        let name = "newFolder"
//        let count = assets.count
//        
//    }
    
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
    
    func saveToUserDefault(data:NSData, withKey key:String){
        
    }
    
    
}
