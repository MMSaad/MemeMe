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
        if let image = meme?.memeImage{
            self.memeImageView.image = image
        }else{
            self.memeImageView.image = MemesManager().loadImageFromDocument(name:"g\(meme!.id).jpg")
        }
        
    }
    

    
    @IBAction func shareButtonPressed(_ sender: Any) {
        if let image = meme?.memeImage{
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        activityController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                self.dismiss(animated: true, completion: nil)
                return
            }
        }
        activityController.popoverPresentationController?.sourceView = self.memeImageView
        present(activityController, animated: true, completion: nil)
        }
    }
    
}
