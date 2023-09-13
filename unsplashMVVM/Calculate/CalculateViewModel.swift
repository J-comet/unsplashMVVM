//
//  CalculateViewModel.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/13.
//

import Foundation

class CalculateViewModel {
    
    var firstNumber: TestObservable<String?> = TestObservable("")
    
    var secondNumber: TestObservable<String?> = TestObservable("")
    
    var resultText: TestObservable<String?> = TestObservable("")
    
    var tempText = TestObservable("테스트를 위한 텍스트")
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    func presentNumberFormat() {
        guard let first = firstNumber.value, let firstConvertNumber = Int(first) else {
            tempText.value = "숫자로 변환할 수 없는 문자에요"
            return
        }
        tempText.value = format(for: firstConvertNumber)
    }
    
    func calculate() {
        guard let first = firstNumber.value, let firstConvertNumber = Int(first) else {
            resultText.value = "첫번째 입력값 오류가 발생했어요"
            return
        }
        
        guard let second = secondNumber.value, let secondConvertNumber = Int(second) else {
            resultText.value = "두번째 입력값 오류가 발생했어요"
            return
        }
        resultText.value = "결과는 \(firstConvertNumber + secondConvertNumber) 입니다"
    }
}

