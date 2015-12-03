//
//  ViewController.swift
//  Meems
//
//  Created by raxit cholera on 12/1/15.
//  Copyright © 2015 kodeguide. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var selected_Image: UIImageView!
    
    @IBOutlet weak var toptoolbar: UIToolbar!
    @IBOutlet weak var Bottomtoolbar: UIToolbar!
    @IBOutlet weak var textFieldBottom: UITextField!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var camaraBtn: UIBarButtonItem!
    @IBAction func pickan_image(sender: AnyObject) {

        presentViewWithSource(UIImagePickerControllerSourceType.PhotoLibrary)
      
    }
    @IBAction func pickfrom_camara(sender: AnyObject) {

        presentViewWithSource(UIImagePickerControllerSourceType.Camera)
        
    }
    @IBAction func actionBtnClicked(sender: AnyObject) {
        
        let img = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    func save() {
        //        let meemObj = MeemObject(topText: textFieldTop.text!, bottomText: textFieldBottom.text!, originalImage: self.selected_Image.image!, memedImage: generateMemedImage())
        
        //        UIImageWriteToSavedPhotosAlbum(generateMemedImage(), self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    @IBAction func reseteverything(sender: AnyObject) {
        restall()
    }
    func generateMemedImage() -> UIImage {
        
        hideToolBar(true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        hideToolBar(false)
        return memedImage
    }
    func hideToolBar(show:Bool)
    {
        self.toptoolbar.hidden = show
        self.Bottomtoolbar.hidden = show
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.selected_Image.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("Canceled")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldTop.text = "TOP"
        self.textFieldBottom.text = "BOTTOM"
        textFieldBottom.delegate = self
        textFieldTop.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifiations()
    }
    func presentViewWithSource(source:UIImagePickerControllerSourceType)
    {
        let presentView  = UIImagePickerController()
        presentView.delegate = self
        presentView.sourceType = source
        self.presentViewController(presentView, animated: true, completion: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifiations()

        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            camaraBtn.enabled = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.frame.origin.y = 0
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
        textField.text = ""
        }
    }
    
    func keyboardWillShow (notification:NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification:NSNotification) -> CGFloat {
        let info = notification.userInfo
        let keyboardSize = info![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifiations() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifiations() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func restall()
    {
        self.textFieldBottom.text = "BOTTOM"
        self.textFieldTop.text = "TOP"
        self.selected_Image.image = nil
    }


}

