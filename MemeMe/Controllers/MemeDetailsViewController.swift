//
//  MemeDetailsViewController.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/16/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {

    //Outlets
    @IBOutlet weak var memeImageView: UIImageView!
    
    //Vars
    var meme:Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meme = meme{
            self.memeImageView.image = meme.memeImage
        }
        
    }
    

    

}
