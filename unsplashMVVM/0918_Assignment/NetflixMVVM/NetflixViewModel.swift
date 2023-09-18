//
//  NetflixViewModel.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/18.
//

import Foundation

class NetflixViewModel {
    
    var email: Observable<String?> = Observable("")
    var password: Observable<String?> = Observable("")
    var nickname: Observable<String?> = Observable("")
    var location: Observable<String?> = Observable("")
    var code: Observable<String?> = Observable("")
    
    var isEmailValid: Observable<Bool> = Observable(false)
    var isPasswordValid: Observable<Bool> = Observable(false)
    var isNicknameValid: Observable<Bool> = Observable(false)
    var isLocationValid: Observable<Bool> = Observable(false)
    var isCodeValid: Observable<Bool> = Observable(false)
    
    var isValid: Observable<Bool> = Observable(false)
 
    func checkEmailValidation(chkEmail: String?) {
        email.value = chkEmail
        guard let chkEmail else {
            isEmailValid.value = false
            return
        }
        
        if chkEmail.isEmpty {
            isEmailValid.value = false
        } else {
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            guard let _ = chkEmail.range(of: regex, options: .regularExpression) else {
                isEmailValid.value = false
                return
            }
            isEmailValid.value = true
        }
    }
    
    func checkPasswordValidation(chkPw: String?) {
        password.value = chkPw
        guard let chkPw else {
            isPasswordValid.value = false
            return
        }
        
        if chkPw.isEmpty {
            isPasswordValid.value = false
        } else {
            let regex = "^[a-z0-9A-Z]{6,10}$"
            guard let _ = chkPw.range(of: regex, options: .regularExpression) else {
                isPasswordValid.value = false
                return
            }
            isPasswordValid.value = true
        }
    }
    
    func checkNicknameValidation(chkNickname: String?) {
        nickname.value = chkNickname
        guard let chkNickname else {
            isNicknameValid.value = false
            return
        }
        
        if chkNickname.isEmpty {
            isNicknameValid.value = false
        } else {
            let regex = "^[0-9a-zA-Z]*$"
            guard let _ = chkNickname.range(of: regex, options: .regularExpression) else {
                isNicknameValid.value = false
                return
            }
            isNicknameValid.value = true
        }
    }
    
    func checkLocationValidation(chkLocation: String?) {
        location.value = chkLocation
        guard let chkLocation else {
            isLocationValid.value = false
            return
        }
        
        if chkLocation.isEmpty {
            isLocationValid.value = false
        } else {
            let regex = "^[가-힣]*$"
            guard let _ = chkLocation.range(of: regex, options: .regularExpression) else {
                isLocationValid.value = false
                return
            }
            isLocationValid.value = true
        }
    }
    
    func checkCodeValidation(chkCode: String?) {
        code.value = chkCode
        guard let chkCode else {
            isCodeValid.value = false
            return
        }
        
        if chkCode.isEmpty {
            isCodeValid.value = false
        } else {
            let regex = "^[0-9]{6}$"
            guard let _ = chkCode.range(of: regex, options: .regularExpression) else {
                isCodeValid.value = false
                return
            }
            isCodeValid.value = true
        }
    }
    
    func checkAllValidation() {
        isValid.value = isEmailValid.value && isPasswordValid.value && isNicknameValid.value && isLocationValid.value && isCodeValid.value
    }
}
