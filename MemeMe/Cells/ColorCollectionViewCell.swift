//
//  ColorCollectionViewCell.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/6/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit


class ColorCollectionViewCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var view:UIView!
    
    //Vars
    var color:UIColor?
    
    func bindUi(color:UIColor){
        self.color = color
        self.view.backgroundColor = self.color
    }
}
