//: Playground - noun: a place where people can play

import UIKit

func insertionSort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    guard array.count > 1 else { return array }
    var array = array
    for x in 1..<array.count {
        var y = x
        let temp = array[y]
        while y > 0 && isOrderedBefore(temp, array[y - 1]) {
            array[y] = array[y - 1]
            y -= 1
        }
        array[y] = temp
    }
    return array
}

let list = [10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26]
insertionSort(list, <)
