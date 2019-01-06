//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/3/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class MemeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,MemeDelegate {

    // MARK: Outlets
    @IBOutlet weak var memeAreaView: UIView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextEditor: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var cameraButton:UIBarButtonItem!
    @IBOutlet weak var shareMemeButton: UIBarButtonItem!
    
    // MARK: Vars
    var activeTextField:UITextField?
    var meme:Meme!
    
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.meme = Meme(topMessage:"TEXT GOES HERE",bottomMessage:"TEXT GOES HERE",originalImage:self.memeImageView.image,memeImage:nil,fontFamily:"HelveticaNeue-CondensedBlack",fontSize:40,fontColor:UIColor.white)
        setupTextFields()
    }
    
    func bindUi(){
        self.topTextEditor.text = self.meme.topMessage
        self.bottomTextField.text = self.meme.bottomMessage
        self.memeImageView.image = self.meme.originalImage
        self.shareMemeButton.isEnabled = self.meme.originalImage != nil
    }
    
    func formatTextFields(){
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.darkGray,
            NSAttributedString.Key.strokeWidth:  -3.0,
            NSAttributedString.Key.foregroundColor: self.meme.fontColor,
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
        formatTextFields()
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
    
    
    
    // MARK: Keyboard Notifications
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
        self.meme.reset()
        self.bindUi()
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
        //
//        if let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "FontFamilyBottomSheet") as? CustomizeFontFamilyViewController{
//            ctrl.fontName = self.meme.fontFamily
//            ctrl.memeDelegate = self
//            let bottomSheet = MDCBottomSheetController(contentViewController: ctrl)
//            bottomSheet.title = "Customize Font Family"
//            present(bottomSheet, animated: true, completion: nil)
//        }
        
//        if let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "FontSizeBottomSheet") as? CustomizeFontSizeViewController{
//            ctrl.fontSize = self.meme.fontSize
//            ctrl.memeDelegate = self
//            let bottomSheet = MDCBottomSheetController(contentViewController: ctrl)
//            bottomSheet.title = "Customize Font Size"
//            present(bottomSheet, animated: true, completion: nil)
//        }
        
        if let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "FontColorBottomSheet") as? ColorPickerViewController{
            ctrl.selectedColor = self.meme.fontColor
            ctrl.memeDelegate = self
            let bottomSheet = MDCBottomSheetController(contentViewController: ctrl)
            bottomSheet.title = "Customize Font Color"
            present(bottomSheet, animated: true, completion: nil)
        }
    }
    
    
    
    // MARK : Helper Methods
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(self.memeAreaView.frame.size)
        self.memeAreaView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return memedImage
    }
    
    
    
    
    // MARK: UITextFieldDelegate Implementation
    public func textFieldDidBeginEditing(_ textField: UITextField){
        activeTextField = textField
        textField.text = ""
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        activeTextField = nil
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: UIImagePickerControllerDelegate Implementation
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        print(info)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.meme.originalImage = image
            self.bindUi()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Meme Delegate
    public func fontFamilyChanged(newFont:String){
        self.meme.fontFamily = newFont
        self.formatTextFields()
    }
    
    public  func fontSizeChanged(newFontSize:Float){
        self.meme.fontSize = newFontSize
        self.formatTextFields()
    }
    
    public func colorChanged(color:UIColor){
        self.meme.fontColor = color
        self.formatTextFields()
    }
    
}
