//
//  UIImage++.swift
//  FootMark
//
//  Created by 박신영 on 3/21/24.
//

import UIKit

extension UIImage {
    var scaledToSafeUploadSize: UIImage? {
        let maxImageSideLength: CGFloat = 480
        let largerSide: CGFloat = max(size.width, size.height)
        let ratioScale: CGFloat = largerSide > maxImageSideLength ? largerSide / maxImageSideLength : 1
        let newImageSize = CGSize(width: size.width / ratioScale, height: size.height / ratioScale)
        
        return image(scaledTo: newImageSize)
    }
    
    private func image(scaledTo size: CGSize) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    static func systemIcon(name: String, tintColor: UIColor = .black, weight: UIImage.SymbolWeight = .regular) -> UIImage? {
           let configuration = UIImage.SymbolConfiguration(weight: weight)
           guard let image = UIImage(systemName: name, withConfiguration: configuration) else { return nil }
           return image.withTintColor(tintColor, renderingMode: .alwaysOriginal)
       }
}
