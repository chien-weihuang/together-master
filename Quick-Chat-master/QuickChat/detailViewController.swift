//
//  detailViewController.swift
//  QuickChat
//
//  Created by MAC on 2017/6/15.
//  Copyright © 2017年 Mexonis. All rights reserved.
//

import UIKit
import Firebase
import Photos

class detailViewController: UIViewController, UIImagePickerControllerDelegate ,UITextFieldDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserInfo()
        self.imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var profilePic: RoundedImageView!
     let imagePicker = UIImagePickerController()
    var checktrigger = false
    @IBAction func profilePicButton(_ sender: Any) {
        let sheet = UIAlertController(title: nil, message: "Select the source", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openPhotoPickerWith(source: .camera)
        })
        let photoAction = UIAlertAction(title: "Gallery", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openPhotoPickerWith(source: .library)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sheet.addAction(cameraAction)
        sheet.addAction(photoAction)
        sheet.addAction(cancelAction)
        self.present(sheet, animated: true, completion: nil)
        
        let user = Auth.auth().currentUser
        let storageRef = Storage.storage().reference().child("usersProfilePics").child(user!.uid)
        let imageData = UIImageJPEGRepresentation(self.profilePic.image!, 0.1)
        storageRef.putData(imageData!, metadata: nil, completion: { (metadata, err) in
            if err == nil {
                let path = metadata?.downloadURL()?.absoluteString
                let values = ["profilePicLink": path!]
                Database.database().reference().child("users").child((user?.uid)!).child("credentials").updateChildValues(values, withCompletionBlock: { (errr, _) in
                    if errr == nil {
                        
                        //self.profilePic.image = UIImage.init(named: "profile pic")
                        
                    }
                })
            }
        })
        
        
    }
    //open picture
    func openPhotoPickerWith(source: PhotoSource) {
        switch source {
        case .camera:
            let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
            if (status == .authorized || status == .notDetermined) {
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        case .library:
            let status = PHPhotoLibrary.authorizationStatus()
            if (status == .authorized || status == .notDetermined) {
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
   
        
       
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profilePic.image = pickedImage
            print("I am in imagepicker controller")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ageButton(_ sender: Any) {
    }
    
    //Downloads current user credentials
    func fetchUserInfo() {
        if let id = Auth.auth().currentUser?.uid {
            User.info(forUserID: id, completion: {[weak weakSelf = self] (user) in
                DispatchQueue.main.async {
                    weakSelf?.username.text = user.name
                    //weakSelf?.emailLabel.text = user.email
                    weakSelf?.profilePic.image  = user.profilePic
                    weakSelf = nil
                }
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
