//
// Copyright (c) 2015 Justin Kolb - https://github.com/jkolb/Swiftish
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

// Dot product Alt + 8 = •
infix operator • {
    associativity left
    precedence 160
}

// Cross product
infix operator × {
    associativity left
    precedence 170
}

public struct Vector2<T: Arithmetic> : Equatable {
    public let x, y: T
    
    public init() {
        self.x = T.zero
        self.y = T.zero
    }
    
    public init(_ v: T) {
        self.x = v
        self.y = v
    }
    
    public init(_ x: T, _ y: T) {
        self.x = x
        self.y = y
    }
    
    public var s: T { return x }
    public var t: T { return y }
    
    public var u: T { return x }
    public var v: T { return y }
    
    public var r: T { return x }
    public var g: T { return y }
    
    public var components: [T] {
        return [x, y]
    }
    
    public subscript(index: Int) -> T {
        switch index {
        case 0:
            return x
        case 1:
            return y
        default:
            fatalError("Index out of range")
        }
    }
}

public struct Vector3<T: Arithmetic> : Equatable {
    public let x, y, z: T
    
    public init() {
        self.x = T.zero
        self.y = T.zero
        self.z = T.zero
    }

    public init(_ v: T) {
        self.x = v
        self.y = v
        self.z = v
    }
    
    public init(_ x: T, _ y: T, _ z: T) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public var s: T { return x }
    public var t: T { return y }
    public var p: T { return z }
    
    public var u: T { return x }
    public var v: T { return y }
    public var w: T { return z }

    public var r: T { return x }
    public var g: T { return y }
    public var b: T { return z }
    
    public var components: [T] {
        return [x, y, z]
    }
    
    public subscript(index: Int) -> T {
        switch index {
        case 0:
            return x
        case 1:
            return y
        case 2:
            return z
        default:
            fatalError("Index out of range")
        }
    }
}

public struct Vector4<T: Arithmetic> : Equatable {
    public let x, y, z, w: T
    
    public init() {
        self.x = T.zero
        self.y = T.zero
        self.z = T.zero
        self.w = T.zero
    }

    public init(_ v: T) {
        self.x = v
        self.y = v
        self.z = v
        self.w = v
    }
    
    public init(_ x: T, _ y: T, _ z: T, _ w: T) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public var s: T { return x }
    public var t: T { return y }
    public var p: T { return z }
    public var q: T { return w }
    
    public var r: T { return x }
    public var g: T { return y }
    public var b: T { return z }
    public var a: T { return w }

    public var components: [T] {
        return [x, y, z, w]
    }
    
    public subscript(index: Int) -> T {
        switch index {
        case 0:
            return x
        case 1:
            return y
        case 2:
            return z
        case 3:
            return w
        default:
            fatalError("Index out of range")
        }
    }
}

// MARK: - Scalar Addition

public func +<T: Arithmetic>(lhs: Vector2<T>, rhs: T) -> Vector2<T> {
    return Vector2(
        lhs.x + rhs,
        lhs.y + rhs
    )
}

public func +<T: Arithmetic>(lhs: T, rhs: Vector2<T>) -> Vector2<T> {
    return Vector2(
        lhs + rhs.x,
        lhs + rhs.y
    )
}

public func +<T: Arithmetic>(lhs: Vector3<T>, rhs: T) -> Vector3<T> {
    return Vector3(
        lhs.x + rhs,
        lhs.y + rhs,
        lhs.z + rhs
    )
}

public func +<T: Arithmetic>(lhs: T, rhs: Vector3<T>) -> Vector3<T> {
    return Vector3(
        lhs + rhs.x,
        lhs + rhs.y,
        lhs + rhs.z
    )
}

public func +<T: Arithmetic>(lhs: Vector4<T>, rhs: T) -> Vector4<T> {
    return Vector4(
        lhs.x + rhs,
        lhs.y + rhs,
        lhs.z + rhs,
        lhs.w + rhs
    )
}

public func +<T: Arithmetic>(lhs: T, rhs: Vector4<T>) -> Vector4<T> {
    return Vector4(
        lhs + rhs.x,
        lhs + rhs.y,
        lhs + rhs.z,
        lhs + rhs.w
    )
}

// MARK: - Addition

public func +<T: Arithmetic>(lhs: Vector2<T>, rhs: Vector2<T>) -> Vector2<T> {
    return Vector2(
        lhs.x + rhs.x,
        lhs.y + rhs.y
    )
}

public func +<T: Arithmetic>(lhs: Vector3<T>, rhs: Vector3<T>) -> Vector3<T> {
    return Vector3(
        lhs.x + rhs.x,
        lhs.y + rhs.y,
        lhs.z + rhs.z
    )
}

public func +<T: Arithmetic>(lhs: Vector4<T>, rhs: Vector4<T>) -> Vector4<T> {
    return Vector4(
        lhs.x + rhs.x,
        lhs.y + rhs.y,
        lhs.z + rhs.z,
        lhs.w + rhs.w
    )
}

// MARK: - Scalar Subtraction

public func -<T: Arithmetic>(lhs: Vector2<T>, rhs: T) -> Vector2<T> {
    return Vector2(
        lhs.x - rhs,
        lhs.y - rhs
    )
}

public func -<T: Arithmetic>(lhs: T, rhs: Vector2<T>) -> Vector2<T> {
    return Vector2(
        lhs - rhs.x,
        lhs - rhs.y
    )
}

public func -<T: Arithmetic>(lhs: Vector3<T>, rhs: T) -> Vector3<T> {
    return Vector3(
        lhs.x - rhs,
        lhs.y - rhs,
        lhs.z - rhs
    )
}

public func -<T: Arithmetic>(lhs: T, rhs: Vector3<T>) -> Vector3<T> {
    return Vector3(
        lhs - rhs.x,
        lhs - rhs.y,
        lhs - rhs.z
    )
}

public func -<T: Arithmetic>(lhs: Vector4<T>, rhs: T) -> Vector4<T> {
    return Vector4(
        lhs.x - rhs,
        lhs.y - rhs,
        lhs.z - rhs,
        lhs.w - rhs
    )
}

public func -<T: Arithmetic>(lhs: T, rhs: Vector4<T>) -> Vector4<T> {
    return Vector4(
        lhs - rhs.x,
        lhs - rhs.y,
        lhs - rhs.z,
        lhs - rhs.w
    )
}

// MARK: - Subtraction

public func -<T: Arithmetic>(lhs: Vector2<T>, rhs: Vector2<T>) -> Vector2<T> {
    return Vector2(
        lhs.x - rhs.x,
        lhs.y - rhs.y
    )
}

public func -<T: Arithmetic>(lhs: Vector3<T>, rhs: Vector3<T>) -> Vector3<T> {
    return Vector3(
        lhs.x - rhs.x,
        lhs.y - rhs.y,
        lhs.z - rhs.z
    )
}

public func -<T: Arithmetic>(lhs: Vector4<T>, rhs: Vector4<T>) -> Vector4<T> {
    return Vector4(
        lhs.x - rhs.x,
        lhs.y - rhs.y,
        lhs.z - rhs.z,
        lhs.w - rhs.w
    )
}

// MARK: - Scalar Multiplication

public func *<T: Arithmetic>(lhs: Vector2<T>, rhs: T) -> Vector2<T> {
    return Vector2(
        lhs.x * rhs,
        lhs.y * rhs
    )
}

public func *<T: Arithmetic>(lhs: Vector3<T>, rhs: T) -> Vector3<T> {
    return Vector3(
        lhs.x * rhs,
        lhs.y * rhs,
        lhs.z * rhs
    )
}

public func *<T: Arithmetic>(lhs: Vector4<T>, rhs: T) -> Vector4<T> {
    return Vector4(
        lhs.x * rhs,
        lhs.y * rhs,
        lhs.z * rhs,
        lhs.w * rhs
    )
}

public func *<T: Arithmetic>(lhs: T, rhs: Vector2<T>) -> Vector2<T> {
    return Vector2(
        lhs * rhs.x,
        lhs * rhs.y
    )
}

public func *<T: Arithmetic>(lhs: T, rhs: Vector3<T>) -> Vector3<T> {
    return Vector3(
        lhs * rhs.x,
        lhs * rhs.y,
        lhs * rhs.z
    )
}

public func *<T: Arithmetic>(lhs: T, rhs: Vector4<T>) -> Vector4<T> {
    return Vector4(
        lhs * rhs.x,
        lhs * rhs.y,
        lhs * rhs.z,
        lhs * rhs.w
    )
}

// MARK: - Multiplication

public func *<T: Arithmetic>(lhs: Vector2<T>, rhs: Vector2<T>) -> Vector2<T> {
    return Vector2(
        lhs.x * rhs.x,
        lhs.y * rhs.y
    )
}

public func *<T: Arithmetic>(lhs: Vector3<T>, rhs: Vector3<T>) -> Vector3<T> {
    return Vector3(
        lhs.x * rhs.x,
        lhs.y * rhs.y,
        lhs.z * rhs.z
    )
}

public func *<T: Arithmetic>(lhs: Vector4<T>, rhs: Vector4<T>) -> Vector4<T> {
    return Vector4(
        lhs.x * rhs.x,
        lhs.y * rhs.y,
        lhs.z * rhs.z,
        lhs.w * rhs.w
    )
}

// MARK: - Scalar Division

public func /<T: Arithmetic>(lhs: Vector2<T>, rhs: T) -> Vector2<T> {
    return Vector2(
        lhs.x / rhs,
        lhs.y / rhs
    )
}

public func /<T: Arithmetic>(lhs: Vector3<T>, rhs: T) -> Vector3<T> {
    return Vector3(
        lhs.x / rhs,
        lhs.y / rhs,
        lhs.z / rhs
    )
}

public func /<T: Arithmetic>(lhs: Vector4<T>, rhs: T) -> Vector4<T> {
    return Vector4(
        lhs.x / rhs,
        lhs.y / rhs,
        lhs.z / rhs,
        lhs.w / rhs
    )
}

public func /<T: Arithmetic>(lhs: T, rhs: Vector2<T>) -> Vector2<T> {
    return Vector2(
        lhs / rhs.x,
        lhs / rhs.y
    )
}

public func /<T: Arithmetic>(lhs: T, rhs: Vector3<T>) -> Vector3<T> {
    return Vector3(
        lhs / rhs.x,
        lhs / rhs.y,
        lhs / rhs.z
    )
}

public func /<T: Arithmetic>(lhs: T, rhs: Vector4<T>) -> Vector4<T> {
    return Vector4(
        lhs / rhs.x,
        lhs / rhs.y,
        lhs / rhs.z,
        lhs / rhs.w
    )
}

// MARK: - Division

public func /<T: Arithmetic>(lhs: Vector2<T>, rhs: Vector2<T>) -> Vector2<T> {
    return Vector2(
        lhs.x / rhs.x,
        lhs.y / rhs.y
    )
}

public func /<T: Arithmetic>(lhs: Vector3<T>, rhs: Vector3<T>) -> Vector3<T> {
    return Vector3(
        lhs.x / rhs.x,
        lhs.y / rhs.y,
        lhs.z / rhs.z
    )
}

public func /<T: Arithmetic>(lhs: Vector4<T>, rhs: Vector4<T>) -> Vector4<T> {
    return Vector4(
        lhs.x / rhs.x,
        lhs.y / rhs.y,
        lhs.z / rhs.z,
        lhs.w / rhs.w
    )
}

// MARK: - Negation

public prefix func -<T: SignedArithmetic>(lhs: Vector2<T>) -> Vector2<T> {
    return Vector2(
        -lhs.x,
        -lhs.y
    )
}

public prefix func -<T: SignedArithmetic>(lhs: Vector3<T>) -> Vector3<T> {
    return Vector3(
        -lhs.x,
        -lhs.y,
        -lhs.z
    )
}

public prefix func -<T: SignedArithmetic>(lhs: Vector4<T>) -> Vector4<T> {
    return Vector4(
        -lhs.x,
        -lhs.y,
        -lhs.z,
        -lhs.w
    )
}

public prefix func +<T: SignedArithmetic>(lhs: Vector2<T>) -> Vector2<T> {
    return Vector2(
        +lhs.x,
        +lhs.y
    )
}

public prefix func +<T: SignedArithmetic>(lhs: Vector3<T>) -> Vector3<T> {
    return Vector3(
        +lhs.x,
        +lhs.y,
        +lhs.z
    )
}

public prefix func +<T: SignedArithmetic>(lhs: Vector4<T>) -> Vector4<T> {
    return Vector4(
        +lhs.x,
        +lhs.y,
        +lhs.z,
        +lhs.w
    )
}

// MARK: - Sum

public func sum<T: Arithmetic>(vector: Vector2<T>) -> T {
    return vector.x + vector.y
}

public func sum<T: Arithmetic>(vector: Vector3<T>) -> T {
    return vector.x + vector.y + vector.z
}

public func sum<T: Arithmetic>(vector: Vector4<T>) -> T {
    return vector.x + vector.y + vector.z + vector.w
}

// MARK: - Length Squared

public func length2<T: Arithmetic>(vector: Vector2<T>) -> T {
    return sum(vector * vector)
}

public func length2<T: Arithmetic>(vector: Vector3<T>) -> T {
    return sum(vector * vector)
}

public func length2<T: Arithmetic>(vector: Vector4<T>) -> T {
    return sum(vector * vector)
}

// MARK: - Length

public func length<T: RealArithmetic>(vector: Vector2<T>) -> T {
    return √length2(vector)
}

public func length<T: RealArithmetic>(vector: Vector3<T>) -> T {
    return √length2(vector)
}

public func length<T: RealArithmetic>(vector: Vector4<T>) -> T {
    return √length2(vector)
}

// MARK: - Normalization

public func normalize<T: RealArithmetic>(vector: Vector2<T>) -> Vector2<T> {
    return vector / length(vector)
}

public func normalize<T: RealArithmetic>(vector: Vector3<T>) -> Vector3<T> {
    return vector / length(vector)
}

public func normalize<T: RealArithmetic>(vector: Vector4<T>) -> Vector4<T> {
    return vector / length(vector)
}

// MARK: - Distance Squared

public func distance2<T: Arithmetic>(va: Vector2<T>, vb: Vector2<T>) -> T {
    let difference = vb - va
    return sum(difference * difference)
}

public func distance2<T: Arithmetic>(va: Vector3<T>, vb: Vector3<T>) -> T {
    let difference = vb - va
    return sum(difference * difference)
}

public func distance2<T: Arithmetic>(va: Vector4<T>, vb: Vector4<T>) -> T {
    let difference = vb - va
    return sum(difference * difference)
}

// MARK: Distance

public func distance<T: RealArithmetic>(va: Vector2<T>, vb: Vector2<T>) -> T {
    return √distance2(va, vb)
}

public func distance<T: RealArithmetic>(va: Vector3<T>, vb: Vector3<T>) -> T {
    return √distance2(va, vb)
}

public func distance<T: RealArithmetic>(va: Vector4<T>, vb: Vector4<T>) -> T {
    return √distance2(va, vb)
}

// MARK: Cross Product

public func ×<T: Arithmetic>(va: Vector3<T>, vb: Vector3<T>) -> Vector3<T> {
    return cross(va, vb)
}

public func cross<T: Arithmetic>(va: Vector3<T>, vb: Vector3<T>) -> Vector3<T> {
    return Vector3(
        va.y * vb.z - vb.y * va.z,
        va.z * vb.x - vb.z * va.x,
        va.x * vb.y - vb.x * va.y
    )
}

// MARK: Dot Product

public func •<T: Arithmetic>(va: Vector2<T>, vb: Vector2<T>) -> T {
    return dot(va, vb)
}

public func dot<T: Arithmetic>(va: Vector2<T>, vb: Vector2<T>) -> T {
    return sum(va * vb)
}

public func •<T: Arithmetic>(va: Vector3<T>, vb: Vector3<T>) -> T {
    return dot(va, vb)
}

public func dot<T: Arithmetic>(va: Vector3<T>, vb: Vector3<T>) -> T {
    return sum(va * vb)
}

public func •<T: Arithmetic>(va: Vector4<T>, vb: Vector4<T>) -> T {
    return dot(va, vb)
}

public func dot<T: Arithmetic>(va: Vector4<T>, vb: Vector4<T>) -> T {
    return sum(va * vb)
}

// MARK: Equatable

public func ==<T: Arithmetic>(va: Vector2<T>, vb: Vector2<T>) -> Bool {
    return va.x == vb.x && va.y == vb.y
}

public func ==<T: Arithmetic>(va: Vector3<T>, vb: Vector3<T>) -> Bool {
    return va.x == vb.x && va.y == vb.y && va.z == vb.z
}

public func ==<T: Arithmetic>(va: Vector4<T>, vb: Vector4<T>) -> Bool {
    return va.x == vb.x && va.y == vb.y && va.z == vb.z && va.w == vb.w
}
