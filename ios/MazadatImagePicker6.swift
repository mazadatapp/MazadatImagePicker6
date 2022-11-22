import UIKit
@objc(MazadatImagePicker6)
class MazadatImagePicker6: NSObject {

  @objc
  func multiply(_ a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) {
      DispatchQueue.main.async{
          let controller = CameraController()
          controller.modalPresentationStyle = .fullScreen
          UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(controller, animated: true, completion: nil)
      }
    resolve(a*b)
  }
    
    @objc
    func openCamera(_ title_:String, aspect_ratio_x: Float, aspect_ratio_y: Float, resolve : @escaping  RCTPromiseResolveBlock,reject : @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async{
            let controller = CameraController()
            controller.setData(title_: title_, aspectRatioX_: aspect_ratio_x, aspectRatioY_: aspect_ratio_y)
            controller.setPromise(promise: resolve)
            controller.modalPresentationStyle = .fullScreen
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(controller, animated: true, completion: nil)
        }
      
    }
    
    @objc
    func openGallery(_ title_:String, aspect_ratio_x: Float, aspect_ratio_y: Float, resolve : @escaping  RCTPromiseResolveBlock,reject : @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async{
            if #available(iOS 14, *) {
                let controller = Gallery()
                controller.setData(title_: title_, aspectRatioX_: aspect_ratio_x, aspectRatioY_: aspect_ratio_y)
                controller.setPromise(promise: resolve)
                controller.modalPresentationStyle = .overCurrentContext
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(controller, animated: true, completion: nil)
            } else {
                let controller = GallerySingleImage()
                    controller.setData(title_: title_, aspectRatioX_: aspect_ratio_x, aspectRatioY_: aspect_ratio_y)
                    controller.setPromise(promise: resolve)
                controller.modalPresentationStyle = .overCurrentContext
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(controller, animated: true, completion: nil)
            }
           
            
        }
      
    }
    
    @objc
    func editPhoto(_ title_:String,image_:String, aspect_ratio_x: Float, aspect_ratio_y: Float, resolve : @escaping  RCTPromiseResolveBlock,reject : @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async{
            let controller = EditPhoto()
            print("karim "+image_)
            controller.setData(title_: title_, aspectRatioX_: aspect_ratio_x, aspectRatioY_: aspect_ratio_y, fileName: URL(string: "file://"+image_)!, from: "gallery")
            controller.setPromise(promise: resolve)
            controller.modalPresentationStyle = .fullScreen
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(controller, animated: true, completion: nil)
        }
      
    }
}
