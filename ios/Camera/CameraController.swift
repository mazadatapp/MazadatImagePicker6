//
//  CameraController.swift
//  MazadatImagePicker6
//
//  Created by Karim Saad on 20/11/2022.
//  Copyright © 2022 Facebook. All rights reserved.
//

import UIKit

class CameraController: SwiftyCamViewController,SwiftyCamViewControllerDelegate {

    var flip_button : UIButton!
    var flash_button : UIButton!
    var camera_button : UIButton!
    var captured_photo : UIImageView!
    var capturedImage : UIImage!
    var overlayView : Overlay!
    var title_view : UIView!
    var retake_next_view : UIView!
    var retake_button : UIButton!
    var next_button : UIButton!
    var back_button : UIButton!
    
    var title_text=""
    var aspectRatioX:Float!
    var aspectRatioY:Float!
    var promise:RCTPromiseResolveBlock!
    
    var isFront=true
    var flashOn=false;
    var fileName:URL!
    
    var currenController:CameraController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraDelegate = self
        currenController=self
        view.backgroundColor = UIColor.black
        
        let width=view.frame.width
        let height=view.frame.height
        
        overlayView = Overlay(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        overlayView.setAspectRatio(aspect_ratio_x: aspectRatioX, aspect_ratio_y: aspectRatioY)
        view.addSubview(overlayView)

        let title_width = 8 * title_text.count + 32
        title_view=UIView(frame: CGRect(x: Int(view.frame.size.width)/2 - title_width / 2, y: 48, width: title_width, height: 40))
        title_view.cornerRadius = 6
        title_view.backgroundColor = UIColor.white

        let title_=UILabel(frame: CGRect(x: 0, y: 0, width: title_view.frame.width, height: title_view.frame.height))
        title_.text = title_text
        title_.font.withSize(17)
        title_.textAlignment = .center
        title_.textColor = UIColor.init(red: 0, green: 0.6588, blue: 0.6823, alpha: 1)
        title_view.addSubview(title_)
        
        view.addSubview(title_view)
        
        captured_photo = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        captured_photo.contentMode = .scaleAspectFit
        captured_photo.isHidden = true
        view.addSubview(captured_photo)
        
        camera_button=UIButton(frame: CGRect(x: width/2 - 16, y: height - 84, width: 60, height: 60))
        camera_button.setImage(UIImage(named: "ic_camera"), for: .normal)
        
        view.addSubview(camera_button)
        
        flip_button=UIButton(frame: CGRect(x: 24, y: height - 72, width: 24, height: 24))
        flip_button.setImage(UIImage(named: "ic_flip"), for: .normal)
        view.addSubview(flip_button)
        
        flash_button=UIButton(frame: CGRect(x: 84, y: height - 72, width: 24, height: 24))
        flash_button.setImage(UIImage(named: "ic_flash"), for: .normal)
        view.addSubview(flash_button)
        
        retake_next_view = UIView(frame: CGRect(x: 0, y: height - 80, width: width, height: 80))
        retake_next_view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        next_button=UIButton(frame: CGRect(x: width - 100, y: 14 , width: 80, height: 50))
        next_button.setTitle("Next", for: .normal)
        next_button.setTitleColor(UIColor.white, for: .normal)
        retake_next_view.addSubview(next_button)
        
        retake_button=UIButton(frame: CGRect(x: 20, y: 14 , width: 80, height: 50))
        retake_button.setTitle("Retake", for: .normal)
        retake_button.setTitleColor(UIColor.white, for: .normal)
        retake_next_view.addSubview(retake_button)
        
        
        
        retake_next_view.isHidden = true
        view.addSubview(retake_next_view)
        
        back_button=UIButton(frame: CGRect(x: 20, y: 53 , width: 30, height: 30))
        back_button.tintColor = UIColor.white
        back_button.setImage(UIImage(named: "ic_back"), for: .normal)
        view.addSubview(back_button)
        
        
        back_button.addTarget(self, action: #selector(self.backPressed(_:)), for: .touchUpInside)
        flip_button.addTarget(self, action: #selector(self.flipPressed(_:)), for: .touchUpInside)
        flash_button.addTarget(self, action: #selector(self.flashPressed(_:)), for: .touchUpInside)
        camera_button.addTarget(self, action: #selector(self.capturePressed(_:)), for: .touchUpInside)
        next_button.addTarget(self, action: #selector(self.nextPressed(_:)), for: .touchUpInside)
        retake_button.addTarget(self, action: #selector(self.retakePressed(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func backPressed(_ sender: AnyObject) {
        dismiss(animated: true)
    }
    @objc func flashPressed(_ sender: UIButton) {
      flashOn = !flashOn
  
      if(isFront){
        flashMode = .on
      }else{
        flashMode = .off
      }
        
    }
    
    @IBAction func flipPressed(_ sender: UIButton) {
      switchCamera()
    }
    
    @objc func capturePressed(_ sender: AnyObject) {
        takePhoto()
    }
    
    @IBAction func retakePressed(_ sender: UIButton) {
      
      overlayView.isHidden=false;
      captured_photo.isHidden=true
      retake_next_view.isHidden=true

      flash_button.isHidden=false
      flip_button.isHidden=false
      camera_button.isHidden=false
      
      showPreviewLayer(flag: true)
      self.view.bringSubviewToFront(back_button)
    }
    
    open func setData(title_:String,aspectRatioX_: Float ,aspectRatioY_: Float){
      self.title_text=title_
      self.aspectRatioX=aspectRatioX_
      self.aspectRatioY=aspectRatioY_
    }
    open func setPromise(promise:RCTPromiseResolveBlock!){
      self.promise=promise
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
      fileName = capturedImage.saveImage(name: "photo.png")
      print(fileName.path)
        self.currenController.dismiss(animated: false)
        let controller=EditPhoto()
        controller.setData(title_: title_text, aspectRatioX_: aspectRatioX, aspectRatioY_: aspectRatioY, fileName: fileName, from: "camera")
        controller.setPromise(promise: promise)
        controller.modalPresentationStyle = .fullScreen
        
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(controller, animated: true, completion: nil)
        //self.present(controller, animated: true, completion:nil)
        
       
        
      
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
      
      capturedImage = photo

      overlayView?.isHidden=true;
      captured_photo.isHidden=false
      retake_next_view.isHidden=false

      flash_button.isHidden=true
      flip_button.isHidden=true
      camera_button.isHidden=true

      captured_photo.image=photo

      showPreviewLayer(flag: false)

      self.view.bringSubviewToFront(captured_photo)
      self.view.bringSubviewToFront(title_view)
      self.view.bringSubviewToFront(retake_next_view)
      self.view.bringSubviewToFront(back_button)
         // Called when takePhoto() is called or if a SwiftyCamButton initiates a tap gesture
         // Returns a UIImage captured from the current session
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
         // Called when startVideoRecording() is called
         // Called if a SwiftyCamButton begins a long press gesture
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
         // Called when stopVideoRecording() is called
         // Called if a SwiftyCamButton ends a long press gesture
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
         // Called when stopVideoRecording() is called and the video is finished processing
         // Returns a URL in the temporary directory where video is stored
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
         // Called when a user initiates a tap gesture on the preview layer
         // Will only be called if tapToFocus = true
         // Returns a CGPoint of the tap location on the preview layer
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        // Called when a user initiates a pinch gesture on the preview layer
        // Will only be called if pinchToZoomn = true
        // Returns a CGFloat of the current zoom level
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
         // Called when user switches between cameras
         // Returns current camera selection
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
