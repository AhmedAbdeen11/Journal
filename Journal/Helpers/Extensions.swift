//
//  Extensions.swift
//  Animo mApps
//
//  Created by Mac on 8/28/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

extension UIImageView
{
    func createCircularImage()
    {
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.clipsToBounds = true;
    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
extension UIImage{
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
}

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        let imageCache = NSCache<AnyObject, AnyObject>()
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension UIView {
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 3
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func circularDots() {
        self.layer.cornerRadius = 4
    }
    
    func addBorder(color: UIColor, width: CGFloat, cornerRadius: CGFloat){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
      }
    
    func makeFabButton(){
        self.layer.cornerRadius = 24
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

extension MDCButton {
    
    func styleMDC(color: UIColor, title: String){
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 25
        self.isUppercaseTitle = false
        self.setTitleFont(UIFont(name: "Helvetica Neue", size: 18)!, for: .normal)
    }
    
}

extension UIButton {
    
    func style(color: UIColor, title: String){
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 25
        self.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
    }
    
}

extension MDCOutlinedTextField {
    func style(title: String){
        self.label.text = title
        self.setOutlineColor(UIColor.white, for: .editing)
        self.setOutlineColor(UIColor.white, for: .normal)
        self.setTextColor(UIColor.white, for: .editing)
        self.setFloatingLabelColor(UIColor.white, for: .editing)
        self.setTextColor(UIColor.white, for: .normal)
        self.setFloatingLabelColor(UIColor.white, for: .normal)
        self.setNormalLabelColor(UIColor.white, for: .editing)
        self.setNormalLabelColor(UIColor.white, for: .normal)
        self.layer.backgroundColor = UIColor.white.withAlphaComponent(0.1).cgColor
        self.font = UIFont(name: "Helvetica Neue", size: 15)
    }
}

extension MDCFilledTextField {
    
    func style(title: String){
        self.setFilledBackgroundColor(UIColor.white.withAlphaComponent(0.1), for: .normal)
        self.setFilledBackgroundColor(UIColor.white.withAlphaComponent(0.1), for: .editing)
        self.label.text = title
        self.setFloatingLabelColor(UIColor(rgb: 0xECF1F7), for: .normal)
        self.setFloatingLabelColor(UIColor(rgb: 0xECF1F7), for: .editing)
        self.setFloatingLabelColor(UIColor(rgb: 0xECF1F7), for: .disabled)
        self.setNormalLabelColor(UIColor(rgb: 0xECF1F7), for: .normal)
        self.setTextColor(UIColor(rgb: 0xECF1F7), for: .editing)
        self.setTextColor(UIColor.white, for: .normal)
        self.setUnderlineColor(UIColor.white.withAlphaComponent(0), for: .normal)
        self.setUnderlineColor(UIColor.white.withAlphaComponent(0), for: .editing)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 7.5
        self.layer.borderColor = UIColor.white.cgColor
        self.font = UIFont(name: "Helvetica Neue", size: 15)
    }
    
    func style2(title: String){
        self.setFilledBackgroundColor(UIColor.white.withAlphaComponent(0.1), for: .normal)
        self.setFilledBackgroundColor(UIColor.white.withAlphaComponent(0.1), for: .editing)
        self.label.text = title
        self.setFloatingLabelColor(UIColor(rgb: 0x94A0BA), for: .normal)
        self.setFloatingLabelColor(UIColor(rgb: 0x94A0BA), for: .editing)
        self.setFloatingLabelColor(UIColor(rgb: 0x94A0BA), for: .disabled)
        self.setNormalLabelColor(UIColor(rgb: 0x94A0BA), for: .normal)
        self.setTextColor(UIColor.black, for: .editing)
        self.setTextColor(UIColor.black, for: .normal)
        self.setUnderlineColor(UIColor.white.withAlphaComponent(0), for: .normal)
        self.setUnderlineColor(UIColor.white.withAlphaComponent(0), for: .editing)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 7.5
        self.layer.borderColor = UIColor(rgb: 0x94A0BA).cgColor
        self.font = UIFont(name: "Helvetica Neue", size: 15)
    }
    
}

extension UIButton {
    func btnBackStyle(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 18
    }
}
