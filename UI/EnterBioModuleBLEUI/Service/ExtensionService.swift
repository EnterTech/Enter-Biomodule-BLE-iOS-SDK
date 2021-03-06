//
//  ExtensionService.swift
//  EnterBioModuleBLEUI
//
//  Created by Enter on 2019/10/23.
//  Copyright © 2019 EnterTech. All rights reserved.
//

import UIKit

/// 所有的 Error
public enum EnterError: Error {
    case timeout
    case invalid(message: String)
    case busy
}

extension UIColor {
    static func colorFromInt(r:Int, g:Int, b:Int, alpha:CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
    
}

extension UIColor {
    /// hex to UIColor FFFFFF  -> .white
    /// - Parameter hexColor: hexString like A0B0C0
    static func colorWithHex(hexColor: String) -> UIColor {
        
        var cString = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // String should be 6
        if cString.count < 6 {
            return .black
            
        }
        
        if cString.hasPrefix("0X") {
            cString.removeFirst(2)
        }
        if cString.hasPrefix("#") {
            cString.removeFirst(1)
        }
        
        if cString.count != 6 {return .black}
        
        // Separate r g b Substrings
        let rStartIndex = cString.index(cString.startIndex, offsetBy: 0)
        let rEndIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = String(cString[rStartIndex..<rEndIndex])
        
        let gStartIndex = cString.index(cString.startIndex, offsetBy: 2)
        let gEndIndex = cString.index(cString.startIndex, offsetBy: 4)
        let gString = String(cString[gStartIndex..<gEndIndex])
        
        let bStartIndex = cString.index(cString.startIndex, offsetBy: 4)
        let bEndIndex = cString.index(cString.startIndex, offsetBy: 6)
        let bString = String(cString[bStartIndex..<bEndIndex])
        
        // Scan values
        let rValue = UInt32(rString, radix: 16)
        let gValue = UInt32(gString, radix: 16)
        let bValue = UInt32(bString, radix: 16)
        
        if let r = rValue, let g = gValue, let b = bValue {
            return UIColor(red: CGFloat(r)/255.0
                , green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
        } else  {
            return .black
        }
        
    }
}


extension UIImage {
    static func loadImage(name: String, any: AnyClass) -> UIImage? {
        return UIImage(named: name, in: Bundle(for: any ), compatibleWith: nil)
        //return UIImage(named: name, in: Bundle(identifier: "org.cocoapods.EnterBioModuleBLEUI"), compatibleWith: nil)
        
    }
}

extension UIImage {
    /// GIF
    class func resolveGifImage(gif: String, any: AnyClass) -> [UIImage]{
        var images:[UIImage] = []
        let gifPath = Bundle.init(for: any).path(forResource: gif, ofType: "gif")
        //let gifPath = Bundle.init(identifier: "org.cocoapods.EnterBioModuleBLEUI")?.path(forResource: gif, ofType: "gif")
        if gifPath != nil{
            if let gifData = try? Data(contentsOf: URL.init(fileURLWithPath: gifPath!)){
                let gifDataSource = CGImageSourceCreateWithData(gifData as CFData, nil)
                let gifcount = CGImageSourceGetCount(gifDataSource!)
                for i in 0...gifcount - 1{
                    let imageRef = CGImageSourceCreateImageAtIndex(gifDataSource!, i, nil)
                    let image = UIImage(cgImage: imageRef!)
                    images.append(image)
                }
            }
        }
        return images
    }
}
