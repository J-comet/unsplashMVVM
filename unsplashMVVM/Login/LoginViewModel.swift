//
//  LoginViewModel.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/12.
//

import Foundation

class LoginViewModel {
    
    var id = Observable("a@a.com")
    var pw = Observable("1234")
    
    var isValid = Observable(false)
    
    func checkValidation() {
        if id.value.count >= 6 && pw.value.count >= 4 {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
    func signIn(completionHandler: @escaping () -> Void) {
        // 서버에서 받은 데이터 처리
//        ex) id
        UserDefaults.standard.set(id.value, forKey: "id")
        completionHandler()
    }
}
