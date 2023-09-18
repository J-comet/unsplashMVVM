//
//  RandomPhotoRepository.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/18.
//

import Foundation

class RandomPhotoRepository {
    
    func random(
        completionHandler: @escaping (_ response: PhotoResult?) -> Void
    ) {
        APIService.shared.randomPhoto { photo in
            completionHandler(photo)
        }
    }
}
