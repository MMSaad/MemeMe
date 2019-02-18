//
//  MemesManager.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/14/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit
import RealmSwift

class MemesManager: NSObject {
    func getMemes() -> [Meme]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(appDelegate.memes.count == 0){
        let realm = try! Realm()
        
        let memes =  realm.objects(MemeDataModel.self)
            for meme in memes{
                appDelegate.memes.append(meme.toMeme())
            }
        }
        return appDelegate.memes
    }
    
    func saveMeme(meme:Meme){
        let realm = try! Realm()
        var newMeme = meme
        newMeme.id = Date().timeIntervalSince1970
        let memeModel = MemeDataModel().fromMeme(meme:newMeme)
        try! realm.write {
            realm.add(memeModel)
        }
        //Save Original Image
        saveImageDocumentDirectory(image: newMeme.originalImage!, name: "\(newMeme.id).jpg")
        //Save Meme Image
        saveImageDocumentDirectory(image: newMeme.memeImage!, name:"g\(newMeme.id).jpg")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(newMeme)
    }
    
    func saveImageDocumentDirectory(image:UIImage,name:String){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
      
        let imageData = image.jpegData(compressionQuality: 1.0)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func loadImageFromDocument(name:String)->UIImage{
        
        let paths               = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(name)
            return UIImage(contentsOfFile: imageURL.path) ?? UIImage()
            
        }
        return UIImage()
    }
}
