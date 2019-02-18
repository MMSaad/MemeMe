//
//  ColorPickerViewController.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/6/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    // MARK: Outlets
    
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    // MARK: Vars
    var colors :[UIColor] = []
    var selectedColor:UIColor!
    var memeDelegate:MemeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildColorList()
    }
    
    /**
     Add some color as example
    */
    func buildColorList(){
        // Add demo color list
       colors = [UIColor.red,UIColor.white,UIColor.green,UIColor.blue,UIColor.cyan,UIColor.gray,UIColor.brown,UIColor.magenta,UIColor.purple,UIColor.orange,UIColor.yellow]
        self.colorsCollectionView.reloadData()
        if let colorIndex =  colors.firstIndex(of: selectedColor){
            let indexPath = IndexPath(row: colorIndex, section: 0)
           self.colorsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        }
    }
    

    // MARK: CollectionView Data Source protocol Implementation
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.colors.count
    }
    
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCellView", for: indexPath) as! ColorCollectionViewCell
        if colors.count > indexPath.row {
            cell.bindUi(color: colors[indexPath.row])
        }
            return cell
    }
    
    
    // MARK: Collectiomview delegate protocol implementation
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //self.memeDelegate.colorChanged(color:colors[indexPath.row])
    }

}
