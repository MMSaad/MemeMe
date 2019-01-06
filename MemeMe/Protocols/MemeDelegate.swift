//
//  MemeDelegate.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/6/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

protocol MemeDelegate {
    func fontFamilyChanged(newFont:String)
    func fontSizeChanged(newFontSize:Float)
    func colorChanged(color:UIColor)
}
