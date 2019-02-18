//
//  MemesManager.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/14/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit
import RealmSwift

// Manage Memes Data
class MemesManager: NSObject {
    
    // Get All Memes
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
    
    // Save a New Meme
    func saveMeme(meme:Meme)-> Bool{
        
        var newMeme = meme
        newMeme.id = Date().timeIntervalSince1970
        
        //Save Original Image
        let originalSaved = FilesHelper().saveImageDocumentDirectory(image: newMeme.originalImage!, name: "\(newMeme.id).jpg")
        
        //Save Meme Image
        let generatedSaved = FilesHelper().saveImageDocumentDirectory(image: newMeme.memeImage!, name:"g\(newMeme.id).jpg")
        
        if originalSaved && generatedSaved {
            let realm = try! Realm()
            let memeModel = MemeDataModel().fromMeme(meme:newMeme)
            try! realm.write {
                realm.add(memeModel)
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memes.append(newMeme)
            return true
        }
        return false
    }
    
    
}
