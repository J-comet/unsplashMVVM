//
//  PhotoViewModel.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/12.
//

import Foundation

class PhotoViewModel {
    
    var list = Observable(Photo(total: 0, total_pages: 0, results: []))
    
    func fetchPhoto(text: String) {
        DispatchQueue.main.async {
            APIService.shared.searchPhoto(query: text) { photo in
                guard let photo else { return }
                self.list.value = photo
            }
        }
    }
    
    var rowCount: Int {
        return list.value.results?.count ?? 0
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PhotoResult {
        return list.value.results![indexPath.row]
    }
    
}
