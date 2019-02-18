//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/14/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

// Memes Table View Custom Cell
class MemeTableViewCell: UITableViewCell {
    
    
    // MARK: Outlets
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topMemeLabel: UILabel!
    @IBOutlet weak var bottomMemeLabel: UILabel!
    
    
    // Bind Cell Data to Meme
    func bindData(meme:Meme){
        self.topMemeLabel.text = meme.topMessage
        self.bottomMemeLabel.text = meme.bottomMessage
        if let image = meme.memeImage{
            self.memeImageView.image = image
        }else{
            self.memeImageView.image = FilesHelper().loadImageFromDocument(name:"g\(meme.id).jpg")
        }
    }
    
}
