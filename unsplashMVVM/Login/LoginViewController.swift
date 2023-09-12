//
//  LoginViewController.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 단방향데이터바인딩
//        let sample = Observable(value: "none")
//        sample.bind { text in
//            print("bind", text)
//        }
//        
//        sample.value = "고래밥"
//        sample.value = "고래밥11"
//        sample.value = "고래밥22"
//        sample.value = "고래밥33"
//        sample.value = "고래밥44"
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc func loginButtonClicked() {
        guard let id = idTextField.text else { return }
        guard let pw = pwTextField.text else { return }
        
        if id.count >= 6 && pw == "1234" {
            print("로그인 성공")
        } else {
            print("로그인 실패")
        }
    }

}
