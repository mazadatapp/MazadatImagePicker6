import Foundation
import UIKit

extension UIView {

  @IBInspectable var cornerRadius: CGFloat {

   get{
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
        layer.masksToBounds = newValue > 0
    }
  }

  @IBInspectable var borderWidth: CGFloat {
    get {
        return layer.borderWidth
    }
    set {
        layer.borderWidth = newValue
    }
  }

  @IBInspectable var borderColor: UIColor? {
    get {
        return UIColor(cgColor: layer.borderColor!)
    }
    set {
        layer.borderColor = newValue?.cgColor
    }
  }
    
    func asImage(bounds:CGRect) -> UIImage {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        }
    
    func snapshot(of rect: CGRect? = nil, afterScreenUpdates: Bool = true) -> UIImage {
        return UIGraphicsImageRenderer(bounds: rect!).image { _ in
                drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
            
            }
        
        
    }
    
    func snapshot(of rect: CGRect? = nil) -> UIImage {
            
            let renderer = UIGraphicsImageRenderer(bounds: rect!)
                    return renderer.image { (context) in
                        self.layer.render(in: context.cgContext)
                    }
        }
    
    
    
   
}
