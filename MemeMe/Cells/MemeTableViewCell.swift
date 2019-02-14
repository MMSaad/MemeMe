//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/14/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topMemeLabel: UILabel!
    @IBOutlet weak var bottomMemeLabel: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(meme:Meme){
        self.topMemeLabel.text = meme.topMessage
        self.bottomMemeLabel.text = meme.bottomMessage
        if let image = meme.memeImage{
            self.memeImageView.image = image
        }
    }

}
