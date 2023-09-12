//
//  SampleViewModel.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/12.
//

import Foundation

class SampleViewModel {
    
    var userList = [
        User(name: "상어", age: 10),
        User(name: "고래", age: 20),
        User(name: "금붕어", age: 30),
        User(name: "장어", age: 40)
    ]
    
    var numberOfInSection: Int {
        return userList.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> User {
        return userList[indexPath.row]
    }
    
}
