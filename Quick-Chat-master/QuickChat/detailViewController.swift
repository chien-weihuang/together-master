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
        self.title = "編輯自介"
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var profilePic: RoundedImageView!
     let imagePicker = UIImagePickerController()
    var checktrigger = false
    //profiel picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profilePic.image = pickedImage
            print("Profile Image Picked ")
        }
        picker.dismiss(animated: true, completion: nil)
    }

    
    
    
    
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func ageButton(_ sender: Any) {
    }
   
    @IBAction func updateDetail(_ sender: Any) {
        // change picture
        let user = Auth.auth().currentUser
        let storageRef = Storage.storage().reference().child("usersProfilePics").child(user!.uid)
        let imageData = UIImageJPEGRepresentation(self.profilePic.image!, 0.1)
        storageRef.putData(imageData!, metadata: nil, completion: { (metadata, err) in
            if err == nil {
                let path = metadata?.downloadURL()?.absoluteString
                let values = ["profilePicLink": path!]
                Database.database().reference().child("users").child((user?.uid)!).child("credentials").updateChildValues(values, withCompletionBlock: { (errr, _) in
                    if errr == nil {
                        
                        print("Change profile picture Success")
                        
                    }
                })
            }
        })

          // text field change
        if (username.text != nil) {
            let user = Auth.auth().currentUser
            let values = ["name": username.text!]
            Database.database().reference().child("users").child((user?.uid)!).child("credentials").updateChildValues(values, withCompletionBlock: { (errr, _) in
                if errr == nil {
                    print("Change name success")
                    //inform user by alert
                    let alertController = UIAlertController(
                        title: "提示",
                        message: "資料已更新完畢",
                        preferredStyle: .alert)
                    
                    // 建立[確認]按鈕
                    let okAction = UIAlertAction(
                        title: "確認",
                        style: .default,
                        handler: {
                            (action: UIAlertAction!) -> Void in
                            print("按下確認後，閉包裡的動作")
                    })
                    alertController.addAction(okAction)
                    
                    // 顯示提示框
                    self.present(
                        alertController,
                        animated: true,
                        completion: nil)
                    
                }
            })
        
        }
        
        
        
        
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
