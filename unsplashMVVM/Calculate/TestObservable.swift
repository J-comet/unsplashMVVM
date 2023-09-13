//
//  TestObservable.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/13.
//

import Foundation

class TestObservable<T> {
    
    var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(sample: @escaping (T) -> Void) {
        sample(value)
        listener = sample
    }
}
