//
//  preferenceViewController.swift
//  QuickChat
//
//  Created by MAC on 2017/6/17.
//  Copyright © 2017年 Mexonis. All rights reserved.
//

import UIKit
import Firebase


class preferenceViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var preferencePicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "偏好"
        self.preferencePicker.delegate = self
        self.preferencePicker.dataSource = self
        fetchUserInfo()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    let preference = ["可愛","氣質","穩重","有錢","強壯","豐虞","纖細","聰明","白淨"]
    @IBOutlet weak var preferenceLabel: UILabel!
    let id = Auth.auth().currentUser?.uid
    @IBAction func preferenceFinish(_ sender: Any) {
        let values = ["preference": lastanswer]
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        
        return preference.count
    }

    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        // 設置為陣列 meals 的第 row 項資料
        return preference[row]
    }
    var lastanswer = ""
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {
      
        lastanswer = preference[row]
        preferenceLabel.text = preference[row]
        
    }

    //toggle keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(preferenceViewController.dismissKeyboard))
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
                                let preference = data["preference"]
                //print(hobby)
                if preference != ""{
                    self.preferenceLabel.text = preference
                }
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
