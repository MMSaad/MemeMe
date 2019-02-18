//
//  CustomizeFontFamilyViewController.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/6/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

class CustomizeFontFamilyViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var fontsPicker: UIPickerView!
    
    // MARK: Vars
    var fontList:[String] = []
    var fontName:String!
    var memeDelegate:MemeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFonts()
    }
    
    /**
     Load system fonts 
     */
    func loadFonts(){
        for  family in UIFont.familyNames{
            for  name in UIFont.fontNames(forFamilyName: family ){
                fontList.append(name)
            }
        }
        fontsPicker.reloadAllComponents()
        if let fontIndex =  fontList.firstIndex(of: fontName){
            fontsPicker.selectRow(fontIndex, inComponent: 0, animated: true)
        }
    }
    
    
    // MARK: PickerView Data source protocol implementation
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return fontList.count
    }
    
    // MARK: PickerViewDelegate Implementation
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return fontList[row];
    }
    
    
    
    // MARK: PickerView Delegate protocol implementation
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.fontName = fontList[row]
        memeDelegate.fontFamilyChanged(newFont: self.fontName)
    }
    
}
