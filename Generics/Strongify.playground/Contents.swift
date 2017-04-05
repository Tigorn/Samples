//: Playground - noun: a place where people can play

import Foundation

func strongify<Context: AnyObject, Arguments>(_ context: Context?, closure: @escaping (Context, Arguments) -> Void) -> (Arguments) -> Void {
    return { [weak context] arguments in
        guard let strongContext = context else { return }
        closure(strongContext, arguments)
    }
}

class Object<T> {
    let value: T
    var closure: (() -> Void)?
    init(_ value: T) {
        self.value = value
    }
    deinit {
        print("deinit")
    }
}

var object: Object? = Object("1")
var object2: Object? = Object("2")

object?.closure = strongify(object2) { instance, arguments in
    print(instance.value)
    instance.closure = strongify(object) { instance, arguments in
        print(instance.value)
    }
}

object?.closure?()
object2?.closure?()

object = nil
object2 = nil
