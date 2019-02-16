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
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.memeCollectionView.reloadData()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openMemeEditor"{
            if  segue.destination is MemeViewController{
                (segue.destination as! MemeViewController).meme = self.selectedMeme
            }
        }
        
        if segue.identifier == "gotoMemeDetails"{
            if  segue.destination is MemeDetailsViewController{
                (segue.destination as! MemeDetailsViewController).meme = self.selectedMeme
            }
        }
    }
    
    //MARK: UICollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.selectedMeme = MemesManager().getMemes()[indexPath.row]
        performSegue(withIdentifier: "gotoMemeDetails", sender: self)
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
