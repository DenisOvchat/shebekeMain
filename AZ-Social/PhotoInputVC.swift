//
//  PhotoInputVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 30.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class PhotoInputVC:UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var avatar: UIButton!
    //var id:Int
    override func viewDidLoad() {
        imagePicker.delegate = self
        avatar.layer.cornerRadius = 75
        avatar.layer.masksToBounds = true
        avatar.layer.shadowColor = UIColor.black.cgColor
        avatar.layer.shadowRadius = 2
        avatar.layer.shadowOpacity = 1
        
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func avatarClicked(_ sender: AnyObject)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    /*func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
     if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
     //data.userIcon.contentMode = .ScaleAspectFit
     //data.userIcon = pickedImage
     avatar.setImage(pickedImage, for: UIControlState.normal)
     print("ggg")
     }
     print("GG")
     dismiss(animated: true, completion: nil)
     }*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //data.userIcon.contentMode = .ScaleAspectFit
            //data.userIcon = pickedImage
            let cgim = pickedImage.cgImage
            let minim = min(cgim!.height,cgim!.width)
            let maxim = max(cgim!.height,cgim!.width)
            print(pickedImage.size)
            
            
            let x0 = (cgim!.width - minim)/2
            let y0 = (cgim!.height - minim)/2
            let rect = CGRect(x: x0, y: y0, width: minim, height: minim)
            let im = (cgim!.cropping(to: rect))
            
            //avatar.setImage(UIImage(cgImage: im!, scale: 1.0, orientation: pickedImage.imageOrientation ), for: UIControlState.normal)
            print("ggg")
            avatar.setBackgroundImage(UIImage(cgImage: im!, scale: 1.0, orientation: pickedImage.imageOrientation ), for: UIControlState.normal)
            
            let jpeg = UIImageJPEGRepresentation(pickedImage, 1)
            
          //  var data = NSMutableDictionary()
           // data.setValue(String(data: jpeg!, encoding: String.Encoding.utf8), forKey: "avatar")
           // var data = ("avatar" + "=" + String(data: jpeg!, encoding: String.Encoding.utf8)!).data(using: String.Encoding.utf8)
            ServerManager.shared(named: "main")?.POSTFormRequestByAdding(postfix: "/persons/verification", data: jpeg!, complititionHandler: nil, withCookies: true)
            
        }
        print("GG")
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("canceld")
        dismiss(animated: true, completion: nil)
    }
    
    
}
