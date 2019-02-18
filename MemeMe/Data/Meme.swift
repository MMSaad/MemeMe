//
//  Meme.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/3/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

struct Meme {
    
    var topMessage:String
    var bottomMessage:String
    
    var originalImage:UIImage?
    var memeImage:UIImage?
    
    var fontFamily:String
    var fontSize:Float
    var fontColor:UIColor
    
    mutating func reset(){
        bottomMessage = "TEXT GOES HERE"
        topMessage = "TEXT GOES HERE"
        memeImage = nil
        originalImage = nil
        fontFamily = "HelveticaNeue-CondensedBlack"
        fontSize = 40
        fontColor = UIColor.white
    }
}
