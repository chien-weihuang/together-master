//
//  clubViewController.swift
//  QuickChat
//
//  Created by MAC on 2017/6/17.
//  Copyright © 2017年 Mexonis. All rights reserved.
//

import UIKit
import Firebase

class secretViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserInfo()
        self.title = "秘密"
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var secretTextview: UITextView!
    let id = Auth.auth().currentUser?.uid
    @IBAction func secretFinish(_ sender: Any) {
        let values = ["secret": secretTextview.text]
        Database.database().reference().child("users").child(id!).child("credentials").updateChildValues(values, withCompletionBlock: { (errr, _) in
            if errr == nil{
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
        }
            
        )}
    
    // toggle key board
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(secretViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Downloads current user credentials
    func fetchUserInfo() {
        
        Database.database().reference().child("users").child(id!).child("credentials").observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: String] {
                if data["secret"] == nil || data["secret"] == ""{
                    self.secretTextview.text = "Placeholder"
                    print("nothing")
                }
                let secret = data["secret"]
                //print(hobby)
                self.secretTextview.text = secret
                
            }
        })
        
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
