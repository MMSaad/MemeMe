//
//  MemeDataModel.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/18/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit
import RealmSwift


//Meme Data Model to be saved/retrived from Realm Database
class MemeDataModel: Object {
    
    
    // MARK: Properties
    @objc dynamic var id:Double = 0
    @objc dynamic var topMessage:String = "TEXT GOES HERE"
    @objc dynamic var bottomMessage:String = "TEXT GOES HERE"
    @objc dynamic var fontFamily:String = "HelveticaNeue-CondensedBlack"
    @objc dynamic var fontSize:Float = 40
    
    
    
    func toMeme() -> Meme{
        return Meme(id:self.id,topMessage:self.topMessage,bottomMessage:self.bottomMessage,originalImage:nil,memeImage:nil,fontFamily:self.fontFamily,fontSize:self.fontSize)
    }
    
    func fromMeme(meme:Meme) -> MemeDataModel{
        let model = MemeDataModel()
        model.id = meme.id
        model.topMessage = meme.topMessage
        model.bottomMessage = meme.topMessage
        model.fontFamily = meme.fontFamily
        model.fontSize = meme.fontSize
        return model
    }
    
    
}
