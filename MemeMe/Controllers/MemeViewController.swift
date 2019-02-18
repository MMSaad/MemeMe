//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 1/3/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomSheet
import CropViewController

class MemeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,MemeDelegate,CropViewControllerDelegate {
    
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
        if self.meme == nil{
            self.meme = Meme(id:0,topMessage:"TEXT GOES HERE",bottomMessage:"TEXT GOES HERE",originalImage:self.memeImageView.image,memeImage:nil,fontFamily:"HelveticaNeue-CondensedBlack",fontSize:40)

        }
        setupTextFields()
    }
    
    func bindUi(){
        self.topTextEditor.text = self.meme.topMessage
        self.bottomTextField.text = self.meme.bottomMessage
        self.memeImageView.image = self.meme.originalImage
        if self.meme.originalImage == nil && self.meme.id > 0{
            self.meme.originalImage = MemesManager().loadImageFromDocument(name:"\(meme.id).jpg")
            self.memeImageView.image = self.meme.originalImage
        }
        self.shareMemeButton.isEnabled = self.meme.originalImage != nil
        formatTextField(field: self.topTextEditor)
        formatTextField(field: self.bottomTextField)
    }
    
    func bindData(){
        self.meme.topMessage = self.topTextEditor.text ?? ""
        self.meme.bottomMessage = self.bottomTextField.text ?? ""
    }
    
    func formatTextField(field:UITextField){
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.darkGray,
            NSAttributedString.Key.strokeWidth:  -3.0,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: meme.fontFamily, size: CGFloat(meme.fontSize))!
        ]
        field.defaultTextAttributes = memeTextAttributes
        field.textAlignment = .center
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
        bindData()
        let image =  generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        activityController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                self.meme.memeImage = image
                MemesManager().saveMeme(meme: self.meme)
                self.dismiss(animated: true, completion: nil)
                return
            }
        }
        activityController.popoverPresentationController?.sourceView = self.memeImageView
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        chooseImageFrom(Source: .camera)
    }
    
    @IBAction func albumButtonPressed(_ sender: Any) {
        chooseImageFrom(Source: .photoLibrary)
    }
    
    @IBAction func customizeButtonPressed(_ sender: Any) {
        //To hide keyboard
        self.topTextEditor.resignFirstResponder()
        self.bottomTextField.resignFirstResponder()
        
        let sheet = UIAlertController(title: nil, message: "Customization", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Font Family", style: .default, handler: { (UIAlertAction) in
            if let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "FontFamilyBottomSheet") as? CustomizeFontFamilyViewController{
                ctrl.fontName = self.meme.fontFamily
                ctrl.memeDelegate = self
                self.showBottomSheet(controller: ctrl)
            }
        }))
        sheet.addAction(UIAlertAction(title: "Font size", style: .default, handler: { (a) in
            if let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "FontSizeBottomSheet") as? CustomizeFontSizeViewController{
                ctrl.fontSize = self.meme.fontSize
                ctrl.memeDelegate = self
                self.showBottomSheet(controller: ctrl)
            }
        }))
//        sheet.addAction(UIAlertAction(title: "Font Color", style: .default, handler: { (a) in
//            if let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "FontColorBottomSheet") as? ColorPickerViewController{
//                ctrl.selectedColor = self.meme.fontColor
//                ctrl.memeDelegate = self
//                self.showBottomSheet(controller: ctrl)
//            }
//        }))
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (a) in
            sheet.dismiss(animated: true, completion: nil)
        }))
        sheet.popoverPresentationController?.sourceView = memeImageView
        present(sheet, animated: true, completion: nil)
        
    }
    
    
    
    // MARK : Helper Methods
    
    func chooseImageFrom(Source:UIImagePickerController.SourceType){
        let imageSelector = UIImagePickerController()
        imageSelector.sourceType = Source
        imageSelector.delegate  = self
        present(imageSelector, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(self.memeAreaView.frame.size)
        self.memeAreaView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return memedImage
    }
    
    func showBottomSheet(controller:UIViewController){
        let bottomSheet = MDCBottomSheetController(contentViewController: controller)
        self.present(bottomSheet, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: UITextFieldDelegate protocol Implementation
    public func textFieldDidBeginEditing(_ textField: UITextField){
        activeTextField = textField
        textField.text = ""
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        activeTextField = nil
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        bindData()
    }
    
    
    // MARK: UIImagePickerControllerDelegate protocol Implementation
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            picker.dismiss(animated: true, completion: nil)
            let cropViewController = CropViewController(croppingStyle: .default, image: image)
            cropViewController.delegate = self
            present(cropViewController, animated: true, completion: nil)
            

        }
        
    }
    
    
    // MARK: CropViewControllerDelegate protocol implementation
   public func cropViewController(_ cropViewController: CropViewController, didCropImageToRect rect: CGRect, angle: Int){
    cropViewController.dismissAnimatedFrom(self, toView: self.memeImageView, toFrame: self.memeImageView.frame, setup: nil, completion: nil)
    }
    

   public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
                    self.meme.originalImage = image
                    self.bindUi()
        
    }
    
    // MARK: MemeDelegate protocol implementation
    public func fontFamilyChanged(newFont:String){
        self.meme.fontFamily = newFont
        self.bindUi()
    }
    
    public  func fontSizeChanged(newFontSize:Float){
        self.meme.fontSize = newFontSize
        self.bindUi()
    }
    
//    public func colorChanged(color:UIColor){
//        self.meme.fontColor = color
//        self.bindUi()
//    }
    
}
