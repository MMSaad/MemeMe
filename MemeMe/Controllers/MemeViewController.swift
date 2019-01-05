//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/3/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,CustomizeFontDelegate {

    // MARK: Outlets
    @IBOutlet weak var memeAreaView: UIView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextEditor: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var cameraButton:UIBarButtonItem!
    
    @IBOutlet weak var customizaButton: UIBarButtonItem!
    
    // MARK: Vars
    var activeTextField:UITextField?
    var meme:Meme!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.meme = Meme(topMessage:"",bottomMessage:"",originalImage:self.memeImageView.image,memeImage:nil,fontFamily:"HelveticaNeue-CondensedBlack",fontSize:40)
        setupTextFields()
    }
    
    func bindUi(){
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.darkGray,
            NSAttributedString.Key.strokeWidth:  -3.0,
            
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: meme.fontFamily, size: CGFloat(meme.fontSize))!
            
        ]
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextEditor.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
        topTextEditor.textAlignment = .center
    }
    
    func setupTextFields(){
        bottomTextField.delegate = self
        topTextEditor.delegate = self
    
        bindUi()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let field = activeTextField{
            if field == bottomTextField{
                view.frame.origin.y -= getKeyboardHeight(notification)
            }
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: UI Actions
    
    @IBAction func shareButtonPressed(_ sender: Any) {
       // let memeImage = generateMemedImage()
        let image =  generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        activityController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                ///Save Image
                return
            }
        }
        present(activityController, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        //reset
        topTextEditor.text = "TEXT GOES HERE"
        bottomTextField.text = "TEXT GOES HERE"
        memeImageView.image = nil
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        let camera = UIImagePickerController()
        camera.sourceType = .camera
        present(camera, animated: true, completion: nil)
    }
    
    @IBAction func albumButtonPressed(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func customizeButtonPressed(_ sender: Any) {
        let sheet = UIAlertController(title: "Customization", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Fonts", style: .default, handler: { (UIAlertAction) in
            self.performSegue(withIdentifier: "customizeFonts", sender: self)
        }))
        sheet.addAction(UIAlertAction(title: "Colors", style: .default, handler: { (a) in
            //Show Colors Customzations
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (a) in
            sheet.dismiss(animated: true, completion: nil)
        }))
        sheet.popoverPresentationController?.sourceView = memeImageView
        present(sheet, animated: true, completion: nil)
    }
    


public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
    print(info)
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
        memeImageView.image = image
    }
    picker.dismiss(animated: true, completion: nil)
}
    
    public func textFieldDidBeginEditing(_ textField: UITextField){
        activeTextField = textField
        textField.text = ""
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        activeTextField = nil
        textField.resignFirstResponder()
        return true
    }
    
    
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(self.memeAreaView.frame.size)
        self.memeAreaView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customizeFonts"{
            if let ctrl = segue.destination as? CustomizeFontsViewController{
                ctrl.meme = self.meme
                ctrl.memeDelegate = self
            }
        }
    }
    
    
    public func customizationDone(meme:Meme){
        self.meme = meme
        self.bindUi()
    }
    

}
