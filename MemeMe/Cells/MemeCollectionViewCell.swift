//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/14/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

// Meme Collection View Custom Cell
class MemeCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var memeImageView: UIImageView!
    
    // Bind Cell to Meme
    func bindData(meme:Meme){
        if let image = meme.memeImage{
            self.memeImageView.image = image
        }else{
            self.memeImageView.image = FilesHelper().loadImageFromDocument(name:"g\(meme.id).jpg")
        }
    }
}
