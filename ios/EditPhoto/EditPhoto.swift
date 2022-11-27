//
//  EditPhoto.swift
//  MazadatImagePicker6
//
//  Created by Karim Saad on 20/11/2022.
//  Copyright © 2022 Facebook. All rights reserved.
//

import UIKit
class EditPhoto: UIViewController {
    var cropView: CropperView!
    var title_view: UIView!
    var title_: UILabel!
    var back_button: UIButton!
    var next_button: UIButton!
    var reset_button: UIButton!
    
    var zoom_image_height: NSLayoutConstraint!
    var zoom_view: UIView!
    var image_zoom: UIImageView!
    
    var rotate_left_button: UIButton!
    var rotate_right_button: UIButton!
      
    var zoom_out_button: UIButton!
    var from=""
    var title_text=""
    var aspectRatioX:Float!
    var aspectRatioY:Float!
    var fileName:URL!
    var step=0
    var promise:RCTPromiseResolveBlock!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        let width = view.frame.width
        let height = view.frame.height
        cropView=CropperView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        view.addSubview(cropView)
        
        
//        
//        let zoom_out_height=all_rect.width * CGFloat(aspect_ratio_y/aspect_ratio_x)
//        zoom_out=UIView(frame: CGRect(x: 0, y: all_rect.height/2 - zoom_out_height/2, width: all_rect.width, height: zoom_out_height))
//        zoom_out.backgroundColor = .white
//        
//        zoom_out_image=UIImageView(frame: CGRect(x: 0, y: 0, width: zoom_out.frame.width, height: zoom_out.frame.height))
//        
//        zoom_out_image.contentMode = .scaleAspectFit
//        zoom_out.addSubview(zoom_out_image)
//        zoom_out.isHidden=true
//        
//        
//        image_view.addSubview(image_)
//        image_view.addSubview(zoom_out)
//        
        
        let zoom_view_height = CGFloat(Float(width) * aspectRatioY / aspectRatioX)
        zoom_view = UIView(frame: CGRect(x: 0, y: height/2 - zoom_view_height/2, width: width, height: zoom_view_height))
        zoom_view.clipsToBounds = true
        
        image_zoom=UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: zoom_view_height))
        image_zoom.contentMode = .scaleAspectFit
        zoom_view.addSubview(image_zoom)
        zoom_view.backgroundColor = .white
        print("size")
        print(zoom_view_height)
        print(image_zoom.frame.size)
        view.addSubview(zoom_view)
        zoom_view.isHidden=true
        
        let title_width = 8 * title_text.count + 32
        title_view=UIView(frame: CGRect(x: Int(view.frame.size.width)/2 - title_width / 2, y: 48, width: title_width, height: 40))
        title_view.cornerRadius = 6
        title_view.backgroundColor = UIColor.white

        title_=UILabel(frame: CGRect(x: 0, y: 0, width: title_view.frame.width, height: title_view.frame.height))
        title_.text = title_text
        title_.font.withSize(17)
        title_.textAlignment = .center
        title_.textColor = UIColor.init(red: 0, green: 0.6588, blue: 0.6823, alpha: 1)
        title_view.addSubview(title_)
        
        view.addSubview(title_view)
        
        
        
        next_button=UIButton(frame: CGRect(x: width - 60, y: 53 , width: 40, height: 30))
        next_button.tintColor = UIColor.white
        next_button.setTitle("Next", for: .normal)
        next_button.titleLabel?.textAlignment = .right
        view.addSubview(next_button)
        
        back_button=UIButton(frame: CGRect(x: 20, y: 53 , width: 30, height: 30))
        back_button.tintColor = UIColor.white
        back_button.setImage(UIImage(named: "ic_back"), for: .normal)
        back_button.tintColor = .white
        view.addSubview(back_button)
        
        reset_button=UIButton(frame: CGRect(x: 20, y: height - 65 , width: 80, height: 30))
        reset_button.setTitleColor(.red, for: .normal)
        reset_button.setTitle("Reset", for: .normal)
        reset_button.tintColor = .white
        view.addSubview(reset_button)
        
        rotate_left_button=UIButton(frame: CGRect(x: width - 210, y: height - 65 , width: 30, height: 30))
        rotate_left_button.tintColor = UIColor.white
        rotate_left_button.setImage(UIImage(named: "ic_rotate_left"), for: .normal)
        rotate_left_button.tintColor = .white
        view.addSubview(rotate_left_button)
        
        zoom_out_button=UIButton(frame: CGRect(x: width - 130, y: height - 65 , width: 30, height: 30))
        zoom_out_button.tintColor = UIColor.white
        zoom_out_button.setImage(UIImage(named: "ic_zoom_out"), for: .normal)
        zoom_out_button.tintColor = .white
        view.addSubview(zoom_out_button)
        
        rotate_right_button=UIButton(frame: CGRect(x: width - 50, y: height - 65 , width: 30, height: 30))
        rotate_right_button.tintColor = UIColor.white
        rotate_right_button.setImage(UIImage(named: "ic_rotate_right"), for: .normal)
        rotate_right_button.tintColor = .white
        view.addSubview(rotate_right_button)
        
        
        
        // Do any additional setup after loading the view.
        
        back_button.addTarget(self, action: #selector(self.backPressed(_:)), for: .touchUpInside)
        rotate_left_button.addTarget(self, action: #selector(self.rotateLefttPressed(_:)), for: .touchUpInside)
        rotate_right_button.addTarget(self, action: #selector(self.rotateRightPressed(_:)), for: .touchUpInside)
        zoom_out_button.addTarget(self, action: #selector(self.zoomOutPressed(_:)), for: .touchUpInside)
        next_button.addTarget(self, action: #selector(self.nextPressed(_:)), for: .touchUpInside)
        reset_button.addTarget(self, action: #selector(self.resetPressed(_:)), for: .touchUpInside)
        
//        let lottie = LottieAnimationView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
//        view.addSubview(lottie)
//        let url = URL(string: "https://assets1.lottiefiles.com/packages/lf20_ujlt8xt3.json")!
//        LottieAnimation.loadedFrom(url: url, closure: { [weak self] animation in
//            lottie.animation = animation
//            lottie.play()
//        }, animationCache: LRUAnimationCache.sharedCache)
//        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("hello")
        print(fileName)
        print(fileName.path)
        
        let filePath = fileName.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            print("FILE AVAILABLE")
            
            cropView.setImage(image: UIImage(contentsOfFile: fileName.path)!)
            cropView.setAspectRatio(aspect_ratio_x: aspectRatioX, aspect_ratio_y: aspectRatioY)
        } else {
            print("FILE NOT AVAILABLE")
        }
      //cropView.setImage(image: UIImage(contentsOfFile: fileName.path)!)
    }
    
    open func setData(title_:String,aspectRatioX_: Float ,aspectRatioY_: Float,fileName:URL,from:String){
      self.title_text=title_
      self.aspectRatioX=aspectRatioX_
      self.aspectRatioY=aspectRatioY_
      self.fileName=fileName
      self.from=from
        print(fileName)
    }
    @objc func setPromise(promise:RCTPromiseResolveBlock!){
        self.promise=promise
    }
    
    @objc func backPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
      
    @objc func rotateLefttPressed(_ sender: UIButton) {
        cropView.rotateLeft()
      }
      
    @objc func rotateRightPressed(_ sender: UIButton) {
        cropView.rotateRight()
      }
    @objc func zoomOutPressed(_ sender: UIButton) {
        cropView.zoomOut()
        rotate_left_button.isHidden=true
        rotate_right_button.isHidden=true
        
        
      }
    
    @objc func nextPressed(_ sender: UIButton) {
        if(step==0){
            image_zoom.image=UIImage(cgImage: cropView.getCroppedImage().cgImage!)
            zoom_view.isHidden=false
           
            cropView.isHidden=true
            
            image_zoom.enableZoom()
//            zoom_image_height.constant = zoom_view.frame.width * CGFloat(aspectRatioY/aspectRatioX)
          
            rotate_left_button.isHidden=true
            rotate_right_button.isHidden=true
            zoom_out_button.isHidden=true
        }else if(step==1){
            let image = zoom_view.snapshot(of: zoom_view.bounds)
  //          finalImage.isHidden=false
  //          zoomView.isHidden=true
            //finalImage.image = image
          var fileName=image.saveImage(name: "photo.png")
          
          promise(fileName.path)
          dismiss(animated: true)
        }
        step+=1
      }
    
    @objc func resetPressed(_ sender: UIButton) {
        
        step = 0
        cropView.reset()
        zoom_view.isHidden=true
        cropView.isHidden=false
        
        rotate_left_button.isHidden=false
        rotate_right_button.isHidden=false
        zoom_out_button.isHidden=false
        
        cropView.rotateToDefault()
      }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
