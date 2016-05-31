//
//  UIFont.swift
//  ImageLocker
//
//  Created by Kaushal Elsewhere on 29/05/16.
//  Copyright © 2016 Elsewhere. All rights reserved.
//
import UIKit

public extension UIFont {
    public convenience init?(name fontName: String) {
        self.init(name: fontName, size: UIFont.systemFontSize())
    }
    
    func size(size: CGFloat) -> UIFont {
        
        return self.fontWithSize(size)
    }
    
    public static func fontWithName(name:String)(size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size)!
    }
}