//
//  NumberViewController.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/18.
//

import UIKit

class NumberViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var numberTextField: UITextField!
    
    let viewModel = NumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.numberOfLines = 0
        bindData()
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
    }
    
    private func bindData() {
        viewModel.number.bind { [weak self] value in
            self?.numberTextField.text = value
        }
  
        viewModel.result.bind { [weak self] value in
            self?.resultLabel.text = value
        }
    }
    
    @objc func numberTextFieldChanged() {
        viewModel.number.value = numberTextField.text
        viewModel.convertNumber()
    }
}
