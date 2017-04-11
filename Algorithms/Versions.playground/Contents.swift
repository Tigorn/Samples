//: Playground - noun: a place where people can play

import Foundation

extension String {
    
//    func compare(_ other: String) -> ComparisonResult {
//        let lhs = self.components(separatedBy: ".").map { Int($0) }
//        let rhs = other.components(separatedBy: ".").map { Int($0) }
//        for (index, (v1, v2)) in zip(lhs, rhs).enumerated() {
//            guard let v1 = v1, let v2 = v2 else { break }
//            if v1 > v2 {
//                return .orderedDescending
//            } else if v1 < v2 {
//                return .orderedAscending
//            }
//        }
//        return .orderedSame
//    }
    
    func compare(_ other: String) -> ComparisonResult {
        let lhs = self.components(separatedBy: ".").flatMap { Int($0) }
        let rhs = other.components(separatedBy: ".").flatMap { Int($0) }
        for i in 0..<max(lhs.count, rhs.count) {
            let v1 = lhs.count > i ? lhs[i] : 0
            let v2 = rhs.count > i ? rhs[i] : 0
            if v1 > v2 {
                return .orderedDescending
            } else if v1 < v2 {
                return .orderedAscending
            }
        }
        return .orderedSame
    }
    
}

let v1 = "1.0.0"
let v2 = "0.1"
let v3 = "1.0.0.1"

v1.compare(v2) == .orderedDescending
v1.compare(v3) == .orderedAscending
v1.compare(v1) == .orderedSame
