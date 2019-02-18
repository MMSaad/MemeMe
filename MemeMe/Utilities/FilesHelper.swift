//
//  FilesHelper.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/18/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

// File Helper to Save/Read Memes Images from Document Library
class FilesHelper: NSObject {
    
    // Save Image to Document Library
    func saveImageDocumentDirectory(image:UIImage,name:String) -> Bool{
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
        
        let imageData = image.jpegData(compressionQuality: 1.0)
       return fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    // Read Image from Document Library
    func loadImageFromDocument(name:String)->UIImage{
        
        let paths               = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let dirPath = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(name)
            return UIImage(contentsOfFile: imageURL.path) ?? UIImage()
            
        }
        return UIImage()
    }
}
