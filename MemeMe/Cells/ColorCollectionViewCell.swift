//
//  ColorCollectionViewCell.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/6/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit


class ColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view:UIView!
    
    var color:UIColor?
    
    func bindUi(color:UIColor){
        self.color = color
        self.view.backgroundColor = self.color
    }
}
