//
//  DialogsHelper.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/18/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

//Dialogs Helper
class DialogsHelper: NSObject {

    // Get Error Dialog
    func getErrorAlert(title:String, message:String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    // Get Action Sheet with Custom buttons
    func getActionSheet(title:String,buttons:[String],delegate:ActionSheetDelegate) -> UIAlertController{
        let sheet = UIAlertController(title: nil, message: title, preferredStyle: .actionSheet)
        for button in buttons{
            sheet.addAction(UIAlertAction(title: button, style: .default, handler: { (UIAlertAction) in
                delegate.buttonClicked(title: button)
            }))
        }
        
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (a) in
            sheet.dismiss(animated: true, completion: nil)
        }))
        return sheet
    }
}
