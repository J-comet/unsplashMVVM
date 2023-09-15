//
//  Shopping.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/15.
//

import Foundation

struct Shopping: Hashable {
    let id = UUID().uuidString
    let content: String
    var isSelected: Bool
}
