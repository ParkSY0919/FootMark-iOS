//
//  KingFisher.swift
//  FootMark
//
//  Created by 박신영 on 6/18/24.
//

import UIKit
import Kingfisher

class KingFisher {
   func loadProfileImage(url: String, image: UIImageView) {
      guard !url.isEmpty, let imageURL = URL(string: url) else {
         image.backgroundColor = .red
         image.removeFromSuperview()
         return
      }
      image.kf.indicatorType = .none
      image.kf.setImage(
         with: imageURL,
         placeholder: nil,
         options: [
            .forceTransition,
            .cacheOriginalImage,
            .scaleFactor(UIScreen.main.scale),
            
         ],
         completionHandler: nil
      )
      image.alpha = 1.0
   }
}
