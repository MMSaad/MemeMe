//
//  CustomizeFontsViewController.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/5/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

class CustomizeFontsViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate  {

    
    // MARK: Vars
    var fontList:[String] = []
    var meme:Meme!
    var memeDelegate:CustomizeFontDelegate!
    
    // MARK: Outlets
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var fontsPicker: UIPickerView!
    @IBOutlet weak var previewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFonts()
        updateUi()
        updatePreview()
    }
    
    func updateUi(){
        if let fontIndex =  fontList.firstIndex(of: meme.fontFamily){
            fontsPicker.selectRow(fontIndex, inComponent: 0, animated: true)
        }
        fontSizeSlider.value = meme.fontSize
        fontSizeLabel.text = "\(meme.fontSize)"
    }
    
    func loadFonts(){
        
        for  family in UIFont.familyNames{
            for  name in UIFont.fontNames(forFamilyName: family ){
                fontList.append(name)
            }
        }
        fontsPicker.reloadAllComponents()
        
    }
    
    @IBAction func fontSizeSliderValueChanged(_ sender: Any) {
        self.meme.fontSize = fontSizeSlider.value
        updatePreview()
    }
    
    func updatePreview(){
        self.previewLabel.font = UIFont(name: meme.fontFamily, size: CGFloat(meme.fontSize))
    }

    // MARK: PICKER VIEW DATA SOURCE IMPLEMENTATION
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
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.meme.fontFamily = fontList[row]
        updatePreview()
    }
    
   
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.memeDelegate.customizationDone(meme: self.meme)
        self.dismiss(animated: true, completion: nil)
    }
    
}
