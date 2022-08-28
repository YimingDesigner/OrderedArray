//
//  File.swift
//  
//
//  Created by Yiming Liu on 8/27/22.
//

import Foundation

extension Array where Element: Comparable {
    
    mutating func insertOrderly(_ newElement: Element) {
        if self.isEmpty {
            self.append(newElement)
        } else {
            for (index, element) in self.enumerated() {
                if newElement < element {
                    self.insert(newElement, at: index)
                    return
                }
            }
            self.append(newElement)
        }
    }
}
