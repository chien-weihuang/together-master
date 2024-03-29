//
//  imageCard.swift
//  QuickChat
//
//  Created by MAC on 2017/6/17.
//  Copyright © 2017年 Mexonis. All rights reserved.
//


import UIKit

class imageCard: CardView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    
        
        // image
        
        let imageView = UIImageView(image: UIImage(named: "dummy_image"))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1.0)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        
        imageView.frame = CGRect(x: 12, y: 12, width: self.frame.width - 24, height: self.frame.height - 150)
        self.addSubview(imageView)
        
        //name
        
        
        let nameLabel = UILabel()
        nameLabel.text = "姓名"
        nameLabel.font = UIFont(name: "AvenirNext-Bold", size: 19)
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .center
        nameLabel.frame = CGRect(x: (self.frame.width / 2) - 90, y: 17, width: 180, height: 60)
        self.addSubview(nameLabel)
        
        
        // dummy text boxes
        
//        let textBox1 = UIView()
//        textBox1.backgroundColor = UIColor(red: 67/255, green: 79/255, blue: 182/255, alpha: 1.0)
//        textBox1.layer.cornerRadius = 12
//        textBox1.layer.masksToBounds = true
//        
//        textBox1.frame = CGRect(x: 12, y: imageView.frame.maxY + 15, width: 300, height: 24)
//        self.addSubview(textBox1)
//        
        
        //intro
        
        let introLabel = UILabel()
        introLabel.text = "自我介紹:"
        introLabel.font = UIFont(name: "AvenirNext-Bold", size: 17)
        introLabel.textColor = UIColor.white
        introLabel.textAlignment = .left
        introLabel.lineBreakMode = .byWordWrapping;
        introLabel.numberOfLines = 0;
        introLabel.frame = CGRect(x: 16, y: imageView.frame.maxY + 15, width: self.frame.width - 32, height:70)
        self.addSubview(introLabel)
        
//        let textBox2 = UIView()
//        textBox2.backgroundColor = UIColor(red: 67/255, green: 79/255, blue: 182/255, alpha: 1.0)
//        textBox2.layer.cornerRadius = 12
//        textBox2.layer.masksToBounds = true
//        
//        textBox2.frame = CGRect(x: 12, y: textBox1.frame.maxY + 10, width: 120, height: 24)
//        self.addSubview(textBox2)
        
        //hobby
        
        let hobbyLabel = UILabel()
        hobbyLabel.text = "興趣: "
        hobbyLabel.numberOfLines = 2
        hobbyLabel.font = UIFont(name: "AvenirNext-Bold", size: 17)
        hobbyLabel.textColor = UIColor.white
        hobbyLabel.textAlignment = .left
        hobbyLabel.lineBreakMode = .byWordWrapping;
        hobbyLabel.numberOfLines = 0;
        hobbyLabel.frame = CGRect(x: 16, y: introLabel.frame.maxY + 10, width: 120, height: 24)
        self.addSubview(hobbyLabel)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
