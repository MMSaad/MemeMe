//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/14/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var memeImageView: UIImageView!
    
    func bindData(meme:Meme){
        if let image = meme.memeImage{
            self.memeImageView.image = image
        }
    }
}
