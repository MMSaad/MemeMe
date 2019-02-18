//
//  MemeDelegate.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/6/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

// Delegate for Meme Editor Callback
protocol MemeDelegate {
    // Font Family Had been Changed
    func fontFamilyChanged(newFont:String)
    
    //Font Size Had been Changed
    func fontSizeChanged(newFontSize:Float)
}
