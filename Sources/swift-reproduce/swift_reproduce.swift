

struct Thing<T> {

    public static func capture(_ thunk: () -> T) -> Thing<T> {
        .init() // does not matter how implemented
    }
    public static func captureA(_ thunk: @autoclosure () -> T) -> Thing<T> {
        .init() // does not matter how implemented
    }
    public static func captureE(_ thunk: @escaping () -> T) -> Thing<T> {
        .init() // does not matter how implemented
    }
    public static func captureAE(_ thunk: @autoclosure @escaping () -> T) -> Thing<T> {
        .init() // does not matter how implemented
    }
}

struct Reproduce {

    public static func captureGenericFuncA<T>(_ thunk: @autoclosure () -> T) -> Thing<T> {
        .init()
    }

    func compiles() {
        var number = 1

        let t = Thing<Int>.capture {
            number
        } // ok, just a sanity check
        let t2 = Thing<Int>.captureE {
            number
        } // ok, just a sanity check

        let t3 = Thing<Int>.captureA(number) // ok

        let t4 = Self.captureGenericFuncA(number) // ok
        let t5 = Self.captureGenericFuncA { number } // ok, works fine
    }

    func doesNotCompile() {
        var number = 1

        let t = Thing<Int>.captureA {
            number
        }
        // cannot convert value of type '@lvalue Int' to closure result type 'Int'
        //        }
        //        ^

        let t2 = Thing<Int>.captureAE {
            number
        }
        // cannot convert value of type '@lvalue Int' to closure result type 'Int'
        //        }
        //        ^
    }
}
