//
//  GallerySingleImage.swift
//  MazadatImagePicker6
//
//  Created by Karim Saad on 20/11/2022.
//  Copyright © 2022 Facebook. All rights reserved.
//

import UIKit

class GallerySingleImage: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    var picker:UIImagePickerController!
    var title_text=""
    var aspectRatioX:Float!
    var aspectRatioY:Float!
    var fileName:URL!
    var promise:RCTPromiseResolveBlock!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        //view.backgroundColor=UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        picker=UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.delegate=self
        present(picker, animated: true)
        // Do any additional setup after loading the view.
    }
    
    open func setData(title_:String,aspectRatioX_: Float ,aspectRatioY_: Float){
      self.title_text=title_
      self.aspectRatioX=aspectRatioX_
      self.aspectRatioY=aspectRatioY_
    }
    
    open func setPromise(promise:RCTPromiseResolveBlock!){
      self.promise=promise
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: false)
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let path="file://"+tempImage.saveImage(name: "photo.png").path
        let controller=EditPhoto()
        controller.setData(title_: self.title_text, aspectRatioX_: self.aspectRatioX, aspectRatioY_: self.aspectRatioY, fileName: URL(string: path)!, from: "gallery")
        controller.setPromise(promise: self.promise)
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: {
            self.dismiss(animated: false)
        })
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
