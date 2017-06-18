//
//  otherUserProfileViewController.swift
//  QuickChat
//
//  Created by MAC on 2017/6/17.
//  Copyright © 2017年 Mexonis. All rights reserved.
//

import UIKit
import Firebase

class otherUserProfileViewController: UIViewController, UINavigationControllerDelegate {
   
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    var detailname = ""
    var detailImage = UIImage()
    var detailHobby = ""
    var detailSecret = ""
    var detailPreference = ""
    var detailclub = ""

    @IBOutlet weak var detailPic: UIImageView!
    
    @IBOutlet weak var detailName: UILabel!
    
    @IBOutlet weak var realHobby: UITextView!
    
    @IBOutlet weak var realPreference: UITextView!
    
    @IBOutlet weak var realClub: UITextView!
    
    
    @IBOutlet weak var realSecret: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPic.image = detailImage
        detailName.text = detailname
        realHobby.text = detailHobby
        realPreference.text = detailPreference
        realClub.text = detailclub
        realSecret.text = detailSecret
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Hides current viewcontroller
    func dismissSelf() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func quitButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatVC
        
        self.present(nextViewController, animated:true, completion:nil)
        
        
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
