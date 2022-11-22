//
//  Gallery.swift
//  MazadatImagePicker6
//
//  Created by Karim Saad on 20/11/2022.
//  Copyright © 2022 Facebook. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
@available(iOS 14, *)
class Gallery: UIViewController,PHPickerViewControllerDelegate{
    var title_text=""
    var aspectRatioX:Float!
    var aspectRatioY:Float!
    var fileName:URL!
    var picker:PHPickerViewController!
    var promise:RCTPromiseResolveBlock!
    var paths=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque=false
        view.backgroundColor = UIColor.white
//        let test=UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
//        test.backgroundColor = UIColor.red
//        view.addSubview(test)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var config=PHPickerConfiguration()
        config.selectionLimit = 10
        config.filter = PHPickerFilter.images
        config.preferredAssetRepresentationMode = .automatic
        
        
        picker=PHPickerViewController(configuration: config)
        picker.delegate = self
        present(self.picker, animated: true, completion: nil)
        
    }
    
    open func setData(title_:String,aspectRatioX_: Float ,aspectRatioY_: Float){
      self.title_text=title_
      self.aspectRatioX=aspectRatioX_
      self.aspectRatioY=aspectRatioY_
    }
    
    open func setPromise(promise:RCTPromiseResolveBlock!){
      self.promise=promise
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        var count=results.count
        self.picker.dismiss(animated: true)
        print(results.count)
        if(count==0){
            dismiss(animated: true)
        }
        var index=0
        
        for result in results{
            
            result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async { [self] in
                    if let image = image as? UIImage {
                        var path_=image.saveImage(name: "photo".appending(String(index)).appending(".png"))
                        fileName=URL(string: "file://"+path_.path)
                        paths+=path_.path+","
                        print(URL(string: paths))
                        print(count)
                        print("-------------")
                        
                        print(paths)
                        if(paths.count>0){
                            paths=String(paths.dropLast(1))
                        }
                        print(paths)
                        index+=1
                        if(index == count){
                            if(count==1){
                                DispatchQueue.main.async{
                                    self.dismiss(animated: false)
                                    let controller=EditPhoto()
                                    controller.setData(title_: self.title_text, aspectRatioX_: self.aspectRatioX, aspectRatioY_: self.aspectRatioY, fileName: fileName, from: "gallery")
                                    controller.setPromise(promise: self.promise)
                                    controller.modalPresentationStyle = .fullScreen
                                    self.present(controller, animated: true, completion: nil)
                                }
                                
                            }else{
                                self.promise([paths])
                                self.dismiss(animated: true)
                            }
                        }
                    }
                }
            }
            result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier, completionHandler: { [self]
                url,error in
               
            })
           
            
        }
           
    }


}
