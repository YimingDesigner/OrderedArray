import XCTest
@testable import OrderedArray

final class OrderedArrayTests: XCTestCase {
    
    var orderedArray = OrderedArray<Student>()
    
    let students = [
        Student(name: "Yiming Liu", age: 19),
        Student(name: "Shin Zhong", age: 19),
        Student(name: "Malina Weissman", age: 20)
    ]
    
    func testAdd() {
        
        let properStudents = [
            students[1],
            students[0],
            students[2]
        ]
        
        Task {
            for student in students {
                await self.orderedArray.add(student)
            }
            
            XCTAssertEqual(orderedArray.array, properStudents)
        }
        
    }
    
    func testReorder() {
        
        let properStudents = [
            students[2],
            students[1],
            students[0]
        ]
        
        Task {
            for student in students {
                await self.orderedArray.add(student)
            }
            
            students[2].age = 17
            
            XCTAssertEqual(orderedArray.array, properStudents)
        }
        
    }
    
}
