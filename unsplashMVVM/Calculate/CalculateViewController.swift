//
//  CalculateViewController.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/13.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    
    let viewModel = CalculateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        firstTextField.keyboardType = .numberPad
        secondTextField.keyboardType = .numberPad
        
        viewModel.firstNumber.bind { number in
            self.firstTextField.text = number
            print("firstTextField changed \(number)")
        }
        
        viewModel.secondNumber.bind { number in
            self.secondTextField.text = number
            print("secondTextField changed \(number)")
        }
        
        viewModel.resultText.bind { result in
            self.resultLabel.text = result
        }
        
        viewModel.tempText.bind { test in
            self.tempLabel.text = test
        }
        
        firstTextField.addTarget(self, action: #selector(changedTextField), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(changedTextField), for: .editingChanged)
    }
    
    @objc func changedTextField(_ sender: UITextField) {
        switch sender {
        case firstTextField:
            viewModel.firstNumber.value = sender.text
            viewModel.calculate()
            viewModel.presentNumberFormat()
        case secondTextField:
            viewModel.secondNumber.value = sender.text
            viewModel.calculate()
        default: print("error")
        }
        print(#function)
    }
}
