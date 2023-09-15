//
//  User.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/15.
//

import Foundation

// class 로 모델을 만들었을 때 UUID 에러

class User: Hashable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    // class 는 참조타임인데 어떻게 고유하게할지 설정
    func hash(into hasher: inout Hasher) {
        // id 기준으로 판별하겠다
        hasher.combine(id)
    }
    
    // Hashable 프로토콜을 사용해 고유값을 보장해주도록 함  - DiffableDataSource 를 사용할 때
    let name: String
    let age: Int
    let id = UUID().uuidString  // 유니크한 String 값으로 해결 -> Fatal: supplied item identifiers are not unique. Duplicate identifiers 오류 = 구조체의 내용이 모두 똑같을 떄 발생하는 런타임 오류
    
    var introduce: String {
        return "\(name), \(age)살"
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


//struct User: Hashable {
//
//    // Hashable 프로토콜을 사용해 고유값을 보장해주도록 함  - DiffableDataSource 를 사용할 때
//    let name: String
//    let age: Int
//    let id = UUID().uuidString  // 유니크한 String 값으로 해결 -> Fatal: supplied item identifiers are not unique. Duplicate identifiers 오류 = 구조체의 내용이 모두 똑같을 떄 발생하는 런타임 오류
//
//    var introduce: String {
//        return "\(name), \(age)살"
//    }
//
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//}
