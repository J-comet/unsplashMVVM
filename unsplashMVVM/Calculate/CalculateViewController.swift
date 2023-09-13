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
    
    let viewModel = CalculateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = Person("오리")
        person.name = "근두운"
        person.name = "삼장법사"
        person.introduce(Int.random(in: 1...10)) {
            print("소개완료")
            self.view.backgroundColor = [UIColor.orange, UIColor.red, UIColor.link].randomElement()!
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            person.name = "감"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            person.name = "감자튀김"
        }
        
        firstTextField.text = viewModel.firstNumber.value
        secondTextField.text = viewModel.secondNumber.value
    }
}
