//
//  Font.swift
//  FootMark
//
//  Created by 박신영 on 3/21/24.
//

import UIKit

extension UIFont {
    static func pretendard(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "Pretendard"
        
        var weightString: String
        switch weight {
        case .black:
            weightString = "Black"
        case .bold:
            weightString = "Bold"
        case .heavy:
            weightString = "ExtraBold"
        case .ultraLight:
            weightString = "ExtraLight"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "SemiBold"
        case .thin:
            weightString = "Thin"
        default:
            weightString = "Regular"
        }
        
        let font = UIFont(name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
        return font
    }
   
   static func viga(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
       let familyName = "Viga"
       
       var weightString: String
       switch weight {
       case .black:
           weightString = "Regular"
       default:
           weightString = "Regular"
       }
       
       let font = UIFont(name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
       return font
   }
}

extension UILabel {
    func setPretendardFont(text: String, size fontSize: CGFloat, weight: UIFont.Weight, letterSpacing: CGFloat) {
        self.font = UIFont.pretendard(size: fontSize, weight: weight)
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.7
    }
   
   func setVigaFont(text: String, size fontSize: CGFloat, weight: UIFont.Weight, letterSpacing: CGFloat) {
      self.font = UIFont.viga(size: fontSize, weight: .black)
      let attributedString = NSMutableAttributedString(string: text)
      attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
      self.attributedText = attributedString
      self.adjustsFontSizeToFitWidth = true
      self.minimumScaleFactor = 0.7
   }
}
