//
//  RandomPhotoViewModel.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/18.
//

import Foundation

class RandomPhotoViewModel {
    
    private let repository = RandomPhotoRepository()
    
    var randomPhoto: Observable<PhotoResult?> = Observable(nil)
    
    func getRandomPhoto() {
        repository.random { [weak self] response in
            self?.randomPhoto.value = response
        }
    }
}
