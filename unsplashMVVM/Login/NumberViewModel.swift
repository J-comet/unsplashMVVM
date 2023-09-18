//
//  NumberViewModel.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/18.
//

import Foundation

class NumberViewModel {
    
    var number: Observable<String?> = Observable(nil)               // numberTextField 에 넣을 값
    var result = Observable("값을 입력해주세요")                        // resultLabel 에 넣을 값
    
    func convertNumber() {
        guard let text = number.value else {
            result.value = "값을 입력해주세요"
            return
        }
        
        guard let textToNumber = Int(text) else {
            result.value = "100만원 이하의 숫자를 입력해주세요"
            return
        }
        
        guard textToNumber > 0 , textToNumber <= 1000000 else {
            result.value = "환전 범주는 100만원 이하 입니다"
            return
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let decimalNum = numberFormatter.string(for: textToNumber * 1327)!
        
        result.value = "환전 금액은 \(decimalNum) 입니다"
        print(result.value)
    }
}
