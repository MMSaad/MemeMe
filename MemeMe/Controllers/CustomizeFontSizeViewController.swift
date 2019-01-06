//
//  CustomizeFontSizeViewController.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/6/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

class CustomizeFontSizeViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var fontSizeSlider: UISlider!
    
    // MARK: Vars
    var fontSize:Float = 40.0
    var memeDelegate:MemeDelegate!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUi()
    }
    
    /**
     Update Slider value
     */
    func bindUi(){
        self.fontSizeSlider.value = fontSize
    }
    
    // MARK: IBActions
    @IBAction func fontSizeSliderValueChanged(_ sender: Any) {
        fontSize = self.fontSizeSlider.value
        memeDelegate.fontSizeChanged(newFontSize: self.fontSize)
    }
    
    
    

}
