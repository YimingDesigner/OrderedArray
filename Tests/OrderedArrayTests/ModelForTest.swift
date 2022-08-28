//
//  ModelForTest.swift
//  
//
//  Created by Yiming Liu on 8/28/22.
//

import Foundation

class Student: Comparable, ObservableObject {
    let id = UUID()
    
    @Published var name: String
    @Published var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    static func < (lhs: Student, rhs: Student) -> Bool {
        if lhs.age == rhs.age {
            return (lhs.name < rhs.name) ? true : false
        } else {
            return (lhs.age < rhs.age) ? true : false
        }
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id ? true : false
    }
    
}
