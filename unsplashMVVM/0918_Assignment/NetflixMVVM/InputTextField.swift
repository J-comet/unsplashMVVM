//
//  InputTextField.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/18.
//

import UIKit

class InputTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadView() {
        layer.cornerRadius = 8
        backgroundColor = .systemGray4
        clipsToBounds = true
        textAlignment = .center
    }
}
