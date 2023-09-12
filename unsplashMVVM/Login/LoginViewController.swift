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
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        viewModel.id.bind { text in
            self.idTextField.text = text
        }
        viewModel.pw.bind { text in
            self.pwTextField.text = text
        }
        viewModel.isValid.bind { isValid in
            self.loginButton.isEnabled = isValid
            self.loginButton.backgroundColor = isValid ? .green : .lightGray
        }
        
        // editingChanged - 텍스트필드 변경때마다 호출하도록
        idTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc func textFieldChanged(_ sender: UITextField) {
        switch sender {
        case idTextField:
            print("ID", sender.text!)
            viewModel.id.value = sender.text ?? ""
            viewModel.checkValidation()
        case pwTextField:
            print("PW", sender.text!)
            viewModel.pw.value = sender.text ?? ""
            viewModel.checkValidation()
        default: print("11")
        }
        
    }
    
    @objc func loginButtonClicked() {
        // 로그인 유효성 검사를 뷰모델에서 관리중
        // 유효성 검사실패시 버튼 클릭이 안되도록 설정되어있음
        viewModel.signIn {
            print("로그인 성공!!! / Alert 띄우거나 화면 이동 시키기")
        }
    }

}
