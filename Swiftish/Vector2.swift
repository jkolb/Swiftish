/*
 The MIT License (MIT)
 
 Copyright (c) 2016 Justin Kolb
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

public struct Vector2<T: Vectorable> : Equatable, CustomStringConvertible {
    public var x: T
    public var y: T
    
    public init() {
        self.init(T.zero, T.zero)
    }
    
    public init(_ v: T) {
        self.init(v, v)
    }
    
    public init(_ x: T, _ y: T) {
        self.x = x
        self.y = y
    }
    
    public var components: [T] {
        get {
            return [x, y]
        }
        
        set {
            precondition(newValue.count == 2)
            x = newValue[0]
            y = newValue[1]
        }
    }
    
    public subscript(index: Int) -> T {
        get {
            switch index {
            case 0:
                return x
            case 1:
                return y
            default:
                fatalError("Index out of range")
            }
        }
        
        set {
            switch index {
            case 0:
                x = newValue
            case 1:
                y = newValue
            default:
                fatalError("Index out of range")
            }
        }
    }
    
    public var description: String {
        return "{\(x), \(y)}"
    }
}

// MARK: - Equatable

public func ==<T: Vectorable>(va: Vector2<T>, _ vb: Vector2<T>) -> Bool {
    return va.x == vb.x && va.y == vb.y
}

// MARK: - Addition

public func +<T: Vectorable>(a: Vector2<T>, b: T) -> Vector2<T> {
    let x: T = a.x + b
    let y: T = a.y + b
    
    return Vector2<T>(x, y)
}

public func +<T: Vectorable>(a: T, b: Vector2<T>) -> Vector2<T> {
    let x: T = a + b.x
    let y: T = a + b.y
    
    return Vector2<T>(x, y)
}

public func +<T: Vectorable>(a: Vector2<T>, b: Vector2<T>) -> Vector2<T> {
    let x: T = a.x + b.x
    let y: T = a.y + b.y
    
    return Vector2<T>(x, y)
}

// MARK: - Subtraction

public func -<T: Vectorable>(a: Vector2<T>, b: T) -> Vector2<T> {
    let x: T = a.x - b
    let y: T = a.y - b
    
    return Vector2<T>(x, y)
}

public func -<T: Vectorable>(a: T, b: Vector2<T>) -> Vector2<T> {
    let x: T = a - b.x
    let y: T = a - b.y
    
    return Vector2<T>(x, y)
}

public func -<T: Vectorable>(a: Vector2<T>, b: Vector2<T>) -> Vector2<T> {
    let x: T = a.x - b.x
    let y: T = a.y - b.y
    
    return Vector2<T>(x, y)
}

// MARK: - Multiplication

public func *<T: Vectorable>(a: Vector2<T>, b: T) -> Vector2<T> {
    let x: T = a.x * b
    let y: T = a.y * b
    
    return Vector2<T>(x, y)
}

public func *<T: Vectorable>(a: T, b: Vector2<T>) -> Vector2<T> {
    let x: T = a * b.x
    let y: T = a * b.y
    
    return Vector2<T>(x, y)
}

public func *<T: Vectorable>(a: Vector2<T>, b: Vector2<T>) -> Vector2<T> {
    let x: T = a.x * b.x
    let y: T = a.y * b.y
    
    return Vector2<T>(x, y)
}

// MARK: - Division

public func /<T: Vectorable>(a: Vector2<T>, b: T) -> Vector2<T> {
    let x: T = a.x / b
    let y: T = a.y / b
    
    return Vector2<T>(x, y)
}

public func /<T: Vectorable>(a: T, b: Vector2<T>) -> Vector2<T> {
    let x: T = a / b.x
    let y: T = a / b.y
    
    return Vector2<T>(x, y)
}

public func /<T: Vectorable>(a: Vector2<T>, b: Vector2<T>) -> Vector2<T> {
    let x: T = a.x / b.x
    let y: T = a.y / b.y
    
    return Vector2<T>(x, y)
}

// MARK: - Negation

public prefix func -<T: SignedVectorable>(v: Vector2<T>) -> Vector2<T> {
    let x: T = -v.x
    let y: T = -v.y
    
    return Vector2<T>(x, y)
}

public prefix func +<T: SignedVectorable>(v: Vector2<T>) -> Vector2<T> {
    let x: T = +v.x
    let y: T = +v.y
    
    return Vector2<T>(x, y)
}

// MARK: - Sum

public func sum<T: Vectorable>(_ vector: Vector2<T>) -> T {
    return vector.x + vector.y
}

// MARK: - Geometric

public func length<T: FloatingPointVectorable>(_ vector: Vector2<T>) -> T {
    return length2(vector).squareRoot()
}

public func length2<T: Vectorable>(_ vector: Vector2<T>) -> T {
    return sum(vector * vector)
}

public func normalize<T: FloatingPointVectorable>(_ vector: Vector2<T>) -> Vector2<T> {
    return vector / length(vector)
}

public func distance<T: FloatingPointVectorable>(_ va: Vector2<T>, _ vb: Vector2<T>) -> T {
    return distance2(va, vb).squareRoot()
}

public func distance2<T: Vectorable>(_ va: Vector2<T>, _ vb: Vector2<T>) -> T {
    let difference: Vector2<T> = vb - va
    let difference2: Vector2<T> = difference * difference
    return sum(difference2)
}

public func dot<T: Vectorable>(_ va: Vector2<T>, _ vb: Vector2<T>) -> T {
    return sum(va * vb)
}
