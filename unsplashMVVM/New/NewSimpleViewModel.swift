//
//  NewSimpleViewModel.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/18.
//

import Foundation

class NewSimpleViewModel {
    
    var userList: Observable<[User]> = Observable([])
    
    func append() {
        userList.value = [
            User(name: "상어", age: 20),
            User(name: "상어", age: 20),
            User(name: "고래", age: 20),
            User(name: "금붕어", age: 30),
            User(name: "장어", age: 40)
        ]
    }
    
    func remove() {
        userList.value = []
    }
    
    func removeUser(index: Int) {
        userList.value.remove(at: index)
    }
    
    func insertUser(name: String) {
        let user = User(name: name, age: Int.random(in: 10...30))
        userList.value.insert(user, at: 0)
    }
    
    var userList2: Observable<[User]> = Observable(
        [
            User(name: "상어2", age: 20),
            User(name: "상어2", age: 20),
            User(name: "고래2", age: 20),
            User(name: "금붕어2", age: 30),
            User(name: "장어2", age: 40)
        ]
    )
    
}
