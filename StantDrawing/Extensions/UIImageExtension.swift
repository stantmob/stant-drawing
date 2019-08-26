//
//  UIImageExtension.swift
//  Pods-MyFirstDrawing
//
//  Created by Alexandre on 26/08/19.
//

import UIKit

extension UIImage {
    
    public static func createBy(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return UIImage() }
        return UIImage(cgImage: cgImage)
    }
    
}
