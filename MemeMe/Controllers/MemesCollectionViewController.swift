//
//  MemesCollectionViewController.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/14/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

class MemesCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //Vars
    var selectedMeme:Meme?
    
    //Outlets
    @IBOutlet weak var memeCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.memeCollectionView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: UICollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.selectedMeme = MemesManager().getMemes()[indexPath.row]
        performSegue(withIdentifier: "openMemeEditor", sender: self)
    }
    
    
    // MARK: UICollectionView Data Source
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return MemesManager().getMemes().count
    }
    
    
 
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = memeCollectionView.dequeueReusableCell(withReuseIdentifier: "memeCollectionImage", for: indexPath) as? MemeCollectionViewCell
        if let cell = cell{
            let meme = MemesManager().getMemes()[indexPath.row]
            cell.bindData(meme: meme)
            return cell
        }
        return UICollectionViewCell()
    }

    @IBAction func addMemeButtonPressed(_ sender: Any) {
        self.selectedMeme = nil
        performSegue(withIdentifier: "openMemeEditor", sender: self)
    }
    
}
