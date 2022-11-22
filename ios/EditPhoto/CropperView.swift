//
//  CropperView.swift
//  ImageCropper
//
//  Created by MacBook Pro on 11/4/22.
//

import UIKit

class CropperView: UIView {

    var cropArea:CGRect!
    var once=true;
    var hasImage=false
    var area = 0
    var startPoint:CGPoint!
    var old_y:CGFloat!
    var old_x:CGFloat!
    var old_width:CGFloat!
    var color:UIColor!
    var aspect_ratio_x=4.0
    var aspect_ratio_y=3.0

    //views
    var topView:UIView!
    var bottomView:UIView!
    var leftView:UIView!
    var rightView:UIView!

    var minx_miny:UIView!
    var minx_maxy:UIView!
    var maxx_maxy:UIView!
    var maxx_miny:UIView!

    var top_side:UIView!
    var bottom_side:UIView!
    var left_side:UIView!
    var right_side:UIView!

    var grid_vertical_1:UIView!
    var grid_vertical_2:UIView!
    var grid_horizontal_1:UIView!
    var grid_horizontal_2:UIView!
    
    var all_rect:CGRect!
    var centerView:UIView!
    
    var image_:UIImageView!
    var image_view:UIView!
    
    var zoom_out:UIView!
    var zoom_out_image:UIImageView!
    
    var offset_height:CGFloat!
    var offset_width:CGFloat!
    
    var min_width:CGFloat=100
    var all_aspect_ratio:CGFloat=0.0
    var inside_image_height:Double=0.0
    var inside_image_width:Double=0.0
    
    var min_y:CGFloat = 0
    var max_y:CGFloat = 0
    var min_x:CGFloat = 0
    var max_x:CGFloat = 0
    override func draw(_ rect: CGRect) {
        all_rect=rect
      if(once){
        
        
        color=UIColor.green;
        all_aspect_ratio=CGFloat(aspect_ratio_y/aspect_ratio_x)
        var width=rect.width*0.7;
        if(rect.width>rect.height){
            width = rect.height
            print(rect)
        }
        
        image_view=UIView(frame: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        
        image_=UIImageView(frame: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        image_.contentMode = .scaleAspectFit
        
        let zoom_out_height=all_rect.width * CGFloat(aspect_ratio_y/aspect_ratio_x)
        zoom_out=UIView(frame: CGRect(x: 0, y: all_rect.height/2 - zoom_out_height/2, width: all_rect.width, height: zoom_out_height))
        zoom_out.backgroundColor = .white
        
        zoom_out_image=UIImageView(frame: CGRect(x: 0, y: 0, width: zoom_out.frame.width, height: zoom_out.frame.height))
        zoom_out_image.contentMode = .scaleAspectFit
        zoom_out.addSubview(zoom_out_image)
        zoom_out.isHidden=true
        
        
        image_view.addSubview(image_)
        image_view.addSubview(zoom_out)
        addSubview(image_view)
        
        let height=width*CGFloat(aspect_ratio_y/aspect_ratio_x)
        cropArea=CGRect(x: width*0.2, y: rect.height/2 - height/2, width: width, height: height)
        once=false

        topView=UIView()
        topView.backgroundColor=UIColor.init(_colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.7)
        
        bottomView=UIView()
        bottomView.backgroundColor=UIColor.init(_colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.7)
        
        
        leftView=UIView()
        leftView.backgroundColor=UIColor.init(_colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.7)
        
        rightView=UIView()
        rightView.backgroundColor=UIColor.init(_colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.7)
        
        addSubview(topView)
        addSubview(bottomView)
        addSubview(leftView)
        addSubview(rightView)
        
        //grid
        
        top_side=UIView()
        top_side.backgroundColor=color
        bottom_side=UIView()
        bottom_side.backgroundColor=color
        
        left_side=UIView()
        left_side.backgroundColor=color
        
        right_side=UIView()
        right_side.backgroundColor=color
        
        minx_miny=UIView()
        minx_miny.backgroundColor=color
        minx_miny.cornerRadius=10
        minx_maxy=UIView()
        minx_maxy.backgroundColor=color
        minx_maxy.cornerRadius=10
        maxx_miny=UIView()
        maxx_miny.backgroundColor=color
        maxx_miny.cornerRadius=10
        maxx_maxy=UIView()
        maxx_maxy.backgroundColor=color
        maxx_maxy.cornerRadius=10
        
        
        grid_vertical_1=UIView()
        grid_vertical_1.backgroundColor = color
        
        grid_vertical_2=UIView()
        grid_vertical_2.backgroundColor = color
        
        grid_horizontal_1 = UIView()
        grid_horizontal_1.backgroundColor = color
        
        grid_horizontal_2 = UIView()
        grid_horizontal_2.backgroundColor = color
        
        
        
        centerView=UIView(frame: cropArea)
        //centerView.backgroundColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 0.4)
        
        
        addSubview(centerView)
        addSubview(top_side)
        addSubview(bottom_side)
        addSubview(left_side)
        addSubview(right_side)
        
        addSubview(minx_miny)
        addSubview(minx_maxy)
        addSubview(maxx_miny)
        addSubview(maxx_maxy)
        
        addSubview(grid_vertical_1)
        addSubview(grid_vertical_2)
        addSubview(grid_horizontal_1)
        addSubview(grid_horizontal_2)
      }
    
        centerView.frame = cropArea
      topView.frame = CGRect(x: 0, y: 0, width: rect.width, height: cropArea.minY)
      bottomView.frame = CGRect(x: 0, y: cropArea.maxY, width: rect.width, height: rect.height-cropArea.maxY)
      leftView.frame = CGRect(x: 0, y: cropArea.minY, width: cropArea.minX, height: cropArea.maxY - cropArea.minY)
      rightView.frame = CGRect(x: cropArea.maxX, y: cropArea.minY, width: rect.width - cropArea.maxX, height: cropArea.maxY - cropArea.minY)

      top_side.frame = CGRect(x: cropArea.minX, y: cropArea.minY-1, width: cropArea.maxX - cropArea.minX, height: 2)
      bottom_side.frame = CGRect(x: cropArea.minX, y: cropArea.maxY-1, width: cropArea.maxX - cropArea.minX, height: 2)
      left_side.frame = CGRect(x: cropArea.minX - 1, y: cropArea.minY, width: 2, height: cropArea.maxY - cropArea.minY)
      right_side.frame = CGRect(x: cropArea.maxX - 1, y: cropArea.minY, width: 2, height: cropArea.maxY - cropArea.minY)
      
      minx_miny.frame = CGRect(x: cropArea.minX-10,y: cropArea.minY-10,width: 20,height: 20)
      minx_maxy.frame = CGRect(x: cropArea.minX-10,y: cropArea.maxY-10,width: 20,height: 20)
      maxx_miny.frame = CGRect(x: cropArea.maxX-10,y: cropArea.minY-10,width: 20,height: 20)
      maxx_maxy.frame = CGRect(x: cropArea.maxX-10,y: cropArea.maxY-10,width: 20,height: 20)

        grid_vertical_1.frame = CGRect(x: cropArea.minX + ((cropArea.maxX - cropArea.minX) * 0.33) - 0.5, y: cropArea.minY, width: 1, height: cropArea.maxY - cropArea.minY)
        grid_vertical_2.frame = CGRect(x: cropArea.minX + ((cropArea.maxX - cropArea.minX) * 0.66) - 0.5, y: cropArea.minY, width: 1, height: cropArea.maxY - cropArea.minY)
        grid_horizontal_1.frame = CGRect(x: cropArea.minX, y: cropArea.minY + ((cropArea.maxY - cropArea.minY) * 0.33) - 0.5, width: cropArea.maxX - cropArea.minX, height: 1)
        grid_horizontal_2.frame = CGRect(x: cropArea.minX, y: cropArea.minY + ((cropArea.maxY - cropArea.minY) * 0.66) - 0.5, width: cropArea.maxX - cropArea.minX, height: 1)
      
        
    }
    open func zoomOut(){
        zoom_out.isHidden=false
        image_.isHidden=true
    }
    open func getCropView()->UIView{
        return centerView
    }
    open func getCroppedArea()->CGRect{
        return cropArea
    }
    
    open func setImage(image:UIImage){
        image_.image=image
        zoom_out_image.image=image
        
        
       setMargins()
    }
    open func getCroppedImage()->UIImage{
       return image_view.snapshot(of: cropArea)
        
    }
    
    open func setAspectRatio(aspect_ratio_x:Float,aspect_ratio_y:Float){
        self.aspect_ratio_x=Double(aspect_ratio_x)
        self.aspect_ratio_y=Double(aspect_ratio_y)
       setMargins()
    }
    func setMargins(){
        let imageViewHeight = image_.bounds.height
        let imageViewWidth = image_.bounds.width
        let imageSize = image_.image!.size
        inside_image_height = Double(min(imageSize.height * (imageViewWidth / imageSize.width), imageViewHeight))
        inside_image_width = Double(min(imageSize.width * (imageViewHeight / imageSize.height), imageViewWidth))
        
        
        print(inside_image_width)
        print(all_rect.width)
        
        min_y=(all_rect.height - CGFloat(inside_image_height)) / 2
        max_y = min_y + CGFloat(inside_image_height)
        
        min_x=(all_rect.width - CGFloat(inside_image_width)) / 2
        max_x = min_x + CGFloat(inside_image_width)
        
        var width=all_rect.width*0.7;
        if(all_rect.width>all_rect.height){
            width = all_rect.height
            //print(rect)
        }
        let height=width*CGFloat(aspect_ratio_y/aspect_ratio_x)
        cropArea=CGRect(x: width*0.2, y: all_rect.height/2 - height/2, width: width, height: height)
        
        setNeedsDisplay()
       
    }
    open func rotateRight(){
      let newImage = image_.image!.rotate(radians: .pi/2)
      image_.image=newImage
      
      let newImage2 = zoom_out_image.image!.rotate(radians: .pi/2)
      zoom_out_image.image=newImage2
      //zoom_out_image.transform = zoom_out_image.transform.rotated(by: .pi/2)
      //zoom_out_image.contentMode = .scaleAspectFit
        setMargins()
    }
    
    open func rotateLeft(){
      let newImage = image_.image!.rotate(radians: -.pi/2)
      image_.image=newImage
      
      let newImage2 = zoom_out_image.image!.rotate(radians: -.pi/2)
      zoom_out_image.image=newImage2
      //zoom_out_image.contentMode = .scaleAspectFit
        setMargins()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      startPoint=touches.first!.location(in: self)
      
      let rect_minX_minY=CGRect(x: cropArea.minX-10,y: cropArea.minY-10,width: 20,height: 20)
      let rect_maxX_minY=CGRect(x: cropArea.maxX-10,y: cropArea.minY-10,width: 20,height: 20)
      let rect_maxX_maxY=CGRect(x: cropArea.maxX-10,y: cropArea.maxY-10,width: 20,height: 20)
      let rect_minX_maxY=CGRect(x: cropArea.minX-10,y: cropArea.maxY-10,width: 20,height: 20)
      
        let side_top=CGRect(x: cropArea.minX+10,y: cropArea.minY-10,width: cropArea.maxX - cropArea.minX - 20,height: 20)
        let side_bottom=CGRect(x: cropArea.minX+10,y: cropArea.maxY-10,width: cropArea.maxX - cropArea.minX - 20,height: 20)
        let side_left=CGRect(x: cropArea.minX-10, y: cropArea.minY+10, width: 20, height: cropArea.maxY - cropArea.minX - 20)
        let side_right=CGRect(x: cropArea.maxX-10, y: cropArea.minY+10, width: 20, height: cropArea.maxY - cropArea.minX - 20)
        
      let rect_all=CGRect(x: cropArea.minX,y: cropArea.minY,width: cropArea.maxX - cropArea.minX,height: cropArea.maxY - cropArea.minY)
      
      
      if(rect_minX_minY.contains(startPoint)){
        area = 1
      }else if(rect_maxX_minY.contains(startPoint)){
        area = 2
      }else if(rect_minX_maxY.contains(startPoint)){
        area = 3
      }else if(rect_maxX_maxY.contains(startPoint)){
        area = 4
      }else if(side_top.contains(startPoint)){
        area = 5
      }else if(side_right.contains(startPoint)){
        area = 6
      }else if(side_bottom.contains(startPoint)){
        area = 7
      }else if(side_left.contains(startPoint)){
        area = 8
      }else if(rect_all.contains(startPoint)){
        area = 9
        offset_height=cropArea.maxY - startPoint.y
        offset_width=cropArea.maxX - startPoint.x
      }
      
      print(area)
      
      
      old_x=cropArea.origin.x
      old_y=cropArea.origin.y
      old_width=cropArea.width
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      let point = touches.first!.location(in: self)
      
      let y=point.y - startPoint.y
      let x=point.x - startPoint.x
      
      let area_6_expression = old_y - x/2 + (old_width + x)
      let area_8_expression = old_y + x/2 + (old_width - x)
        
        if(area == 1 && old_width-x > min_width &&
            (old_y+x * CGFloat(aspect_ratio_y/aspect_ratio_x)>min_y) &&
            old_x+x > min_x){
          cropArea.origin.x=old_x+x
          cropArea.origin.y=old_y+x * CGFloat(aspect_ratio_y/aspect_ratio_x)
          cropArea.size.width=old_width-x
          cropArea.size.height = CGFloat(Double((old_width!-x)) * aspect_ratio_y/aspect_ratio_x)
          setNeedsDisplay()
          
        }else if(area == 2 && old_width+x > min_width &&
                    old_y-x * CGFloat(aspect_ratio_y/aspect_ratio_x)>min_y &&
                    cropArea.minX + old_width + x < max_x){
          cropArea.origin.y=old_y-x * CGFloat(aspect_ratio_y/aspect_ratio_x)
          cropArea.size.width=old_width+x
          cropArea.size.height = CGFloat(Double((old_width!+x)) * aspect_ratio_y/aspect_ratio_x)
          setNeedsDisplay()
        }else if(area == 3 && old_width-x > min_width &&
                    (cropArea.minY+((old_width - x) * all_aspect_ratio)) < max_y &&
                    old_x + x > min_x){
          cropArea.origin.x=old_x+x
          cropArea.size.width=old_width-x
          cropArea.size.height = CGFloat(Double((old_width!-x)) * aspect_ratio_y/aspect_ratio_x)
          setNeedsDisplay()
        }else if(area == 4 && old_width+x > min_width &&
                    (cropArea.minY+((old_width + x) * all_aspect_ratio)) < max_y &&
                    cropArea.minX + old_width + x < max_x){
          cropArea.size.width=old_width+x
          cropArea.size.height = CGFloat(Double((old_width!+x)) * aspect_ratio_y/aspect_ratio_x)
          print(cropArea.width)
          setNeedsDisplay()
        }else if(area == 5 && old_width-y > min_width &&
                    (old_x + y / 2)>min_x &&  (old_x + (y / 2) + old_width - y) < max_x && (old_y + y * CGFloat(aspect_ratio_y / aspect_ratio_x))>min_y){
          cropArea.origin.y=old_y+y * CGFloat(aspect_ratio_y/aspect_ratio_x)
          cropArea.origin.x=(old_x+y/2)
          cropArea.size.width=old_width-y
          cropArea.size.height = CGFloat(Double((old_width!-y)) * aspect_ratio_y/aspect_ratio_x)
          setNeedsDisplay()
        }else if(area == 6 && old_width+x > min_width &&
                    (old_y - x / 2) > min_y && area_6_expression * all_aspect_ratio < max_y){
          cropArea.origin.y=old_y-x/2
          cropArea.size.width=old_width+x
          cropArea.size.height = CGFloat(Double((old_width!+x)) * aspect_ratio_y/aspect_ratio_x)
          //cropArea.origin.x=(old_x-y/2)
          
          setNeedsDisplay()
        }else if(area == 7 && old_width+y > min_width &&
                    (old_x - y / 2)>min_x &&  (old_x - (y / 2) + old_width + y) < max_x && (old_y + old_width+y * all_aspect_ratio)<max_y){
          //cropArea.origin.y=old_y+y
          cropArea.origin.x=(old_x-y/2)
          cropArea.size.width=old_width+y
          cropArea.size.height = CGFloat((old_width!+y) * all_aspect_ratio)
          setNeedsDisplay()
        }else if(area == 8 && old_width-x > min_width &&
                    (old_y + x / 2) > min_y && area_8_expression * all_aspect_ratio < max_y){
          cropArea.origin.y=old_y+x/2
          cropArea.origin.x=old_x+x
          cropArea.size.width=old_width-x
          cropArea.size.height = CGFloat(Double((old_width!-x)) * aspect_ratio_y/aspect_ratio_x)
          
          setNeedsDisplay()
        }else if(area == 9){
          if(old_x+x>0 && offset_width + point.x<all_rect.width){
              cropArea.origin.x=old_x+x
              setNeedsDisplay()
          }
          if(old_y+y > min_y && offset_height + point.y < max_y){
              cropArea.origin.y=old_y+y
              setNeedsDisplay()
          }
       }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        area=0
    }
    

}
