//
//  Observable.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/12.
//

import Foundation

class Observable {
    
    private var listener: ((Int) -> Void)?
    
    // 값이 변경되었을 때 alert 을 띄우거나 변경내용을 레이블에 적용하거나 화면전환 or 네트워크 통신을 하고 싶다면?
    var value: Int {
        didSet {
            listener?(value)
        }
    }
    
    init(value: Int) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (Int) -> Void) {
        print(#function)
        closure(value)
        listener = closure
    }
    
    
    
}
