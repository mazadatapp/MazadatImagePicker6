//
//  Overlay.swift
//  MazadatImagePicker6
//
//  Created by Karim Saad on 20/11/2022.
//  Copyright © 2022 Facebook. All rights reserved.
//

import UIKit

class Overlay: UIView {

    var once=true
    var centerView:CGRect!
    var topView:UIView!
    var bottomView:UIView!
    var leftView:UIView!
    var rightView:UIView!
    
    var aspect_ratio_x:Float = 4.0
    var aspect_ratio_y:Float = 3.0
    override func draw(_ rect: CGRect) {
        
        let width=rect.width * 0.8
        let height=width * CGFloat(aspect_ratio_y/aspect_ratio_x)
        centerView = CGRect(x: rect.width/2 - width / 2, y: rect.height / 2 - height / 2 , width: width, height: height)
        
        topView=UIView(frame: CGRect(x: 0, y: 0, width: rect.width, height: centerView.minY))
        topView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        bottomView=UIView(frame: CGRect(x: 0, y: centerView.maxY, width: rect.width, height: rect.height - centerView.maxY))
        bottomView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        leftView = UIView(frame: CGRect(x: 0, y: centerView.minY, width: centerView.minX, height: centerView.height))
        leftView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
         
        rightView = UIView(frame: CGRect(x: centerView.maxX, y: centerView.minY, width: rect.width - centerView.maxX, height: centerView.height))
        rightView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
           
        addSubview(topView)
        addSubview(bottomView)
        addSubview(leftView)
        addSubview(rightView)
    }
    
    
    func setAspectRatio(aspect_ratio_x:Float,aspect_ratio_y:Float){
        self.aspect_ratio_x = aspect_ratio_x
        self.aspect_ratio_y = aspect_ratio_y
        setNeedsDisplay()
    }
   

}
