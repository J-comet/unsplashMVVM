//
//  NetflixViewContorller.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/18.
//

import UIKit
import SnapKit

class NetflixViewContorller: UIViewController {
    
    private let titleLabel = {
        let view = UILabel()
        view.text = "NETFLIX"
        view.font = .monospacedSystemFont(ofSize: 30, weight: .black)
        view.textColor = .systemRed
        return view
    }()
    
    private let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .equalSpacing
        return view
    }()
    
    private let emailTextField = {
        let view = InputTextField()
        view.placeholder = "이메일"
        return view
    }()
    
    private let checkEmailLabel = {
        let view = UILabel()
        view.text = "정확한 이메일을 입력해주세요"
        view.textColor = .white
        view.isHidden = true
        view.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        return view
    }()
    
    private let pwTextField = {
        let view = InputTextField()
        view.placeholder = "비밀번호"
        return view
    }()
    
    private let checkPasswordLabel = {
        let view = UILabel()
        view.text = "영어,숫자로 6~10자 입력해주세요"
        view.textColor = .white
        view.isHidden = true
        view.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        return view
    }()
    
    private let nicknameTextField = {
        let view = InputTextField()
        view.placeholder = "닉네임"
        return view
    }()
    
    private let checkNicknameLabel = {
        let view = UILabel()
        view.text = "영어,숫자로만 입력해주세요"
        view.textColor = .white
        view.isHidden = true
        view.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        return view
    }()
    
    private let locationTextField = {
        let view = InputTextField()
        view.placeholder = "위치"
        return view
    }()
    
    private let checkLocationLabel = {
        let view = UILabel()
        view.text = "한글로 입력해주세요"
        view.textColor = .white
        view.isHidden = true
        view.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        return view
    }()
    
    private let codeTextField = {
        let view = InputTextField()
        view.placeholder = "추천 코드"
        return view
    }()
    
    private let checkCodeLabel = {
        let view = UILabel()
        view.text = "숫자 6자리를 입력해주세요"
        view.textColor = .white
        view.isHidden = true
        view.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        return view
    }()
    
    private let signupButton = {
        let view = UIButton()
        var attString = AttributedString("회원가입")
        attString.font = .systemFont(ofSize: 14, weight: .medium)
        attString.foregroundColor = .white
        var config = UIButton.Configuration.filled()
        config.attributedTitle = attString
        config.baseBackgroundColor = .lightGray
        view.configuration = config
        view.isEnabled = false
        return view
    }()
    
    private let viewModel = NetflixViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindData()
        emailTextField.addTarget(self, action: #selector(textFieldChanged(_ :)), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(textFieldChanged(_ :)), for: .editingChanged)
        nicknameTextField.addTarget(self, action: #selector(textFieldChanged(_ :)), for: .editingChanged)
        locationTextField.addTarget(self, action: #selector(textFieldChanged(_ :)), for: .editingChanged)
        codeTextField.addTarget(self, action: #selector(textFieldChanged(_ :)), for: .editingChanged)
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
    }
    
    private func bindData() {
        viewModel.email.bind { [weak self] email in
            self?.emailTextField.text = email
        }
        
        viewModel.isEmailValid.bind { [weak self] isValid in
            self?.checkEmailLabel.isHidden = isValid
        }
        
        viewModel.password.bind { [weak self] password in
            self?.pwTextField.text = password
        }
        
        viewModel.isPasswordValid.bind { [weak self] isValid in
            self?.checkPasswordLabel.isHidden = isValid
        }
        
        viewModel.nickname.bind { [weak self] nickname in
            self?.nicknameTextField.text = nickname
        }
        
        viewModel.isNicknameValid.bind { [weak self] isValid in
            self?.checkNicknameLabel.isHidden = isValid
        }
    
        viewModel.location.bind { [weak self] location in
            self?.locationTextField.text = location
        }
        
        viewModel.isLocationValid.bind { [weak self] isValid in
            self?.checkLocationLabel.isHidden = isValid
        }
        
        viewModel.code.bind { [weak self] code in
            self?.codeTextField.text = code
        }
        
        viewModel.isCodeValid.bind { [weak self] isValid in
            self?.checkCodeLabel.isHidden = isValid
        }
        
        viewModel.isValid.bind { [weak self] isValid in
            print("모든 유효성 검사 = \(isValid)")
            self?.signupButton.isEnabled = isValid
            var attString = AttributedString("회원가입")
            attString.font = .systemFont(ofSize: 14, weight: .medium)
            attString.foregroundColor = .white
            var config = UIButton.Configuration.filled()
            config.attributedTitle = attString
            config.baseBackgroundColor = isValid ? .systemBlue : .lightGray
            self?.signupButton.configuration = config
        }
    }
    
    @objc func signupButtonClicked() {
        print("회원가입 성공")
    }
    
    @objc func textFieldChanged(_ sender: UITextField) {
        switch sender {
        case emailTextField:
            viewModel.checkEmailValidation(chkEmail: emailTextField.text)
            viewModel.checkAllValidation()
        case pwTextField:
            viewModel.checkPasswordValidation(chkPw: pwTextField.text)
            viewModel.checkAllValidation()
        case nicknameTextField:
            viewModel.checkNicknameValidation(chkNickname: nicknameTextField.text)
            viewModel.checkAllValidation()
        case locationTextField:
            viewModel.checkLocationValidation(chkLocation: locationTextField.text)
            viewModel.checkAllValidation()
        case codeTextField:
            viewModel.checkCodeValidation(chkCode: codeTextField.text)
            viewModel.checkAllValidation()
        default:
            print("error")
        }
    }
    
    private func configureView() {
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        signupButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(checkEmailLabel)
        stackView.addArrangedSubview(pwTextField)
        stackView.addArrangedSubview(checkPasswordLabel)
        stackView.addArrangedSubview(nicknameTextField)
        stackView.addArrangedSubview(checkNicknameLabel)
        stackView.addArrangedSubview(locationTextField)
        stackView.addArrangedSubview(checkLocationLabel)
        stackView.addArrangedSubview(codeTextField)
        stackView.addArrangedSubview(checkCodeLabel)
        stackView.addArrangedSubview(signupButton)
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
