//: Playground - noun: a place where people can play

import UIKit

func search<T: Comparable>(_ array: [T], _ key: T, range: Range<Int>) -> Int? {
    guard range.upperBound > range.lowerBound else { return nil }
    let index = range.lowerBound + (range.upperBound - range.lowerBound) / 2
    if array[index] > key {
        return search(array, key, range: range.lowerBound..<index)
    } else if array[index] < key {
        return search(array, key, range: (index + 1)..<range.upperBound)
    } else {
        return index
    }
}

let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
let sorted = numbers.sorted()
search(sorted, 19, range: 0..<sorted.count)
