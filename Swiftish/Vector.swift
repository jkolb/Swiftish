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

import Darwin

// MARK: - Vector2

public struct Vector2D : Equatable, CustomStringConvertible {
    public let x, y: Float
    
    public init() {
        self.x = 0
        self.y = 0
    }
    
    public init(_ v: Float) {
        self.x = v
        self.y = v
    }
    
    public init(_ x: Float, _ y: Float) {
        self.x = x
        self.y = y
    }
    
    public init(_ v: Vector3D) {
        self.x = v.x
        self.y = v.y
    }
    
    public init(_ v: Vector4D) {
        self.x = v.x
        self.y = v.y
    }
    
    public var s: Float { return x }
    public var t: Float { return y }
    
    public var u: Float { return x }
    public var v: Float { return y }
    
    public var r: Float { return x }
    public var g: Float { return y }
    
    public var components: [Float] {
        return [x, y]
    }
    
    public subscript(index: Int) -> Float {
        switch index {
        case 0:
            return x
        case 1:
            return y
        default:
            fatalError("Index out of range")
        }
    }
    
    public var description: String {
        return "{\(x), \(y)}"
    }
}

// MARK: - Vector3

public struct Vector3D : Equatable, CustomStringConvertible {
    public let x, y, z: Float
    
    public init() {
        self.x = 0
        self.y = 0
        self.z = 0
    }

    public init(_ v: Float) {
        self.x = v
        self.y = v
        self.z = v
    }
    
    public init(_ x: Float, _ y: Float, _ z: Float) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public init(_ v: Vector2D, _ z: Float) {
        self.x = v.x
        self.y = v.y
        self.z = z
    }
    
    public init(_ x: Float, _ v: Vector2D) {
        self.x = x
        self.y = v.x
        self.z = v.y
    }
    
    public init(_ v: Vector4D) {
        self.x = v.x
        self.y = v.y
        self.z = v.z
    }
    
    public var s: Float { return x }
    public var t: Float { return y }
    public var p: Float { return z }
    
    public var u: Float { return x }
    public var v: Float { return y }
    public var w: Float { return z }

    public var r: Float { return x }
    public var g: Float { return y }
    public var b: Float { return z }
    
    public var components: [Float] {
        return [x, y, z]
    }
    
    public subscript(index: Int) -> Float {
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
    
    public var description: String {
        return "{\(x), \(y), \(z)}"
    }
}

// MARK: - Vector4

public struct Vector4D : Equatable, CustomStringConvertible {
    public let x, y, z, w: Float
    
    public init() {
        self.x = 0
        self.y = 0
        self.z = 0
        self.w = 0
    }

    public init(_ v: Float) {
        self.x = v
        self.y = v
        self.z = v
        self.w = v
    }
    
    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public init(_ v: Vector2D, _ z: Float, _ w: Float) {
        self.x = v.x
        self.y = v.y
        self.z = z
        self.w = w
    }
    
    public init(_ x: Float, _ v: Vector2D, _ w: Float) {
        self.x = x
        self.y = v.x
        self.z = v.y
        self.w = w
    }
    
    public init(_ x: Float, _ y: Float, _ v: Vector2D) {
        self.x = x
        self.y = y
        self.z = v.x
        self.w = v.y
    }
    
    public init(_ v: Vector3D, _ w: Float) {
        self.x = v.x
        self.y = v.y
        self.z = v.z
        self.w = w
    }
    
    public init(_ x: Float, _ v: Vector3D) {
        self.x = x
        self.y = v.x
        self.z = v.y
        self.w = v.z
    }
    
    public init(_ v1: Vector2D, _ v2: Vector2D) {
        self.x = v1.x
        self.y = v1.y
        self.z = v2.x
        self.w = v2.y
    }
    
    public var s: Float { return x }
    public var t: Float { return y }
    public var p: Float { return z }
    public var q: Float { return w }
    
    public var r: Float { return x }
    public var g: Float { return y }
    public var b: Float { return z }
    public var a: Float { return w }

    public var components: [Float] {
        return [x, y, z, w]
    }
    
    public subscript(index: Int) -> Float {
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
    
    public var description: String {
        return "{\(x), \(y), \(z), \(w)}"
    }
}

// MARK: - Scalar Addition

public func +(lhs: Vector2D, rhs: Float) -> Vector2D {
    return Vector2D(
        lhs.x + rhs,
        lhs.y + rhs
    )
}

public func +(lhs: Float, rhs: Vector2D) -> Vector2D {
    return Vector2D(
        lhs + rhs.x,
        lhs + rhs.y
    )
}

public func +(lhs: Vector3D, rhs: Float) -> Vector3D {
    return Vector3D(
        lhs.x + rhs,
        lhs.y + rhs,
        lhs.z + rhs
    )
}

public func +(lhs: Float, rhs: Vector3D) -> Vector3D {
    return Vector3D(
        lhs + rhs.x,
        lhs + rhs.y,
        lhs + rhs.z
    )
}

public func +(lhs: Vector4D, rhs: Float) -> Vector4D {
    return Vector4D(
        lhs.x + rhs,
        lhs.y + rhs,
        lhs.z + rhs,
        lhs.w + rhs
    )
}

public func +(lhs: Float, rhs: Vector4D) -> Vector4D {
    return Vector4D(
        lhs + rhs.x,
        lhs + rhs.y,
        lhs + rhs.z,
        lhs + rhs.w
    )
}

// MARK: - Addition

public func +(lhs: Vector2D, rhs: Vector2D) -> Vector2D {
    return Vector2D(
        lhs.x + rhs.x,
        lhs.y + rhs.y
    )
}

public func +(lhs: Vector3D, rhs: Vector3D) -> Vector3D {
    return Vector3D(
        lhs.x + rhs.x,
        lhs.y + rhs.y,
        lhs.z + rhs.z
    )
}

public func +(lhs: Vector4D, rhs: Vector4D) -> Vector4D {
    return Vector4D(
        lhs.x + rhs.x,
        lhs.y + rhs.y,
        lhs.z + rhs.z,
        lhs.w + rhs.w
    )
}

// MARK: - Scalar Subtraction

public func -(lhs: Vector2D, rhs: Float) -> Vector2D {
    return Vector2D(
        lhs.x - rhs,
        lhs.y - rhs
    )
}

public func -(lhs: Float, rhs: Vector2D) -> Vector2D {
    return Vector2D(
        lhs - rhs.x,
        lhs - rhs.y
    )
}

public func -(lhs: Vector3D, rhs: Float) -> Vector3D {
    return Vector3D(
        lhs.x - rhs,
        lhs.y - rhs,
        lhs.z - rhs
    )
}

public func -(lhs: Float, rhs: Vector3D) -> Vector3D {
    return Vector3D(
        lhs - rhs.x,
        lhs - rhs.y,
        lhs - rhs.z
    )
}

public func -(lhs: Vector4D, rhs: Float) -> Vector4D {
    return Vector4D(
        lhs.x - rhs,
        lhs.y - rhs,
        lhs.z - rhs,
        lhs.w - rhs
    )
}

public func -(lhs: Float, rhs: Vector4D) -> Vector4D {
    return Vector4D(
        lhs - rhs.x,
        lhs - rhs.y,
        lhs - rhs.z,
        lhs - rhs.w
    )
}

// MARK: - Subtraction

public func -(lhs: Vector2D, rhs: Vector2D) -> Vector2D {
    return Vector2D(
        lhs.x - rhs.x,
        lhs.y - rhs.y
    )
}

public func -(lhs: Vector3D, rhs: Vector3D) -> Vector3D {
    return Vector3D(
        lhs.x - rhs.x,
        lhs.y - rhs.y,
        lhs.z - rhs.z
    )
}

public func -(lhs: Vector4D, rhs: Vector4D) -> Vector4D {
    return Vector4D(
        lhs.x - rhs.x,
        lhs.y - rhs.y,
        lhs.z - rhs.z,
        lhs.w - rhs.w
    )
}

// MARK: - Scalar Multiplication

public func *(lhs: Vector2D, rhs: Float) -> Vector2D {
    return Vector2D(
        lhs.x * rhs,
        lhs.y * rhs
    )
}

public func *(lhs: Vector3D, rhs: Float) -> Vector3D {
    return Vector3D(
        lhs.x * rhs,
        lhs.y * rhs,
        lhs.z * rhs
    )
}

public func *(lhs: Vector4D, rhs: Float) -> Vector4D {
    return Vector4D(
        lhs.x * rhs,
        lhs.y * rhs,
        lhs.z * rhs,
        lhs.w * rhs
    )
}

public func *(lhs: Float, rhs: Vector2D) -> Vector2D {
    return Vector2D(
        lhs * rhs.x,
        lhs * rhs.y
    )
}

public func *(lhs: Float, rhs: Vector3D) -> Vector3D {
    return Vector3D(
        lhs * rhs.x,
        lhs * rhs.y,
        lhs * rhs.z
    )
}

public func *(lhs: Float, rhs: Vector4D) -> Vector4D {
    return Vector4D(
        lhs * rhs.x,
        lhs * rhs.y,
        lhs * rhs.z,
        lhs * rhs.w
    )
}

// MARK: - Multiplication

public func *(lhs: Vector2D, rhs: Vector2D) -> Vector2D {
    return Vector2D(
        lhs.x * rhs.x,
        lhs.y * rhs.y
    )
}

public func *(lhs: Vector3D, rhs: Vector3D) -> Vector3D {
    return Vector3D(
        lhs.x * rhs.x,
        lhs.y * rhs.y,
        lhs.z * rhs.z
    )
}

public func *(lhs: Vector4D, rhs: Vector4D) -> Vector4D {
    return Vector4D(
        lhs.x * rhs.x,
        lhs.y * rhs.y,
        lhs.z * rhs.z,
        lhs.w * rhs.w
    )
}

// MARK: - Scalar Division

public func /(lhs: Vector2D, rhs: Float) -> Vector2D {
    return Vector2D(
        lhs.x / rhs,
        lhs.y / rhs
    )
}

public func /(lhs: Vector3D, rhs: Float) -> Vector3D {
    return Vector3D(
        lhs.x / rhs,
        lhs.y / rhs,
        lhs.z / rhs
    )
}

public func /(lhs: Vector4D, rhs: Float) -> Vector4D {
    return Vector4D(
        lhs.x / rhs,
        lhs.y / rhs,
        lhs.z / rhs,
        lhs.w / rhs
    )
}

public func /(lhs: Float, rhs: Vector2D) -> Vector2D {
    return Vector2D(
        lhs / rhs.x,
        lhs / rhs.y
    )
}

public func /(lhs: Float, rhs: Vector3D) -> Vector3D {
    return Vector3D(
        lhs / rhs.x,
        lhs / rhs.y,
        lhs / rhs.z
    )
}

public func /(lhs: Float, rhs: Vector4D) -> Vector4D {
    return Vector4D(
        lhs / rhs.x,
        lhs / rhs.y,
        lhs / rhs.z,
        lhs / rhs.w
    )
}

// MARK: - Division

public func /(lhs: Vector2D, rhs: Vector2D) -> Vector2D {
    return Vector2D(
        lhs.x / rhs.x,
        lhs.y / rhs.y
    )
}

public func /(lhs: Vector3D, rhs: Vector3D) -> Vector3D {
    return Vector3D(
        lhs.x / rhs.x,
        lhs.y / rhs.y,
        lhs.z / rhs.z
    )
}

public func /(lhs: Vector4D, rhs: Vector4D) -> Vector4D {
    return Vector4D(
        lhs.x / rhs.x,
        lhs.y / rhs.y,
        lhs.z / rhs.z,
        lhs.w / rhs.w
    )
}

// MARK: - Negation

public prefix func -(v: Vector2D) -> Vector2D {
    return Vector2D(
        -v.x,
        -v.y
    )
}

public prefix func -(v: Vector3D) -> Vector3D {
    return Vector3D(
        -v.x,
        -v.y,
        -v.z
    )
}

public prefix func -(v: Vector4D) -> Vector4D {
    return Vector4D(
        -v.x,
        -v.y,
        -v.z,
        -v.w
    )
}

public prefix func +(v: Vector2D) -> Vector2D {
    return v
}

public prefix func +(v: Vector3D) -> Vector3D {
    return v
}

public prefix func +(v: Vector4D) -> Vector4D {
    return v
}

// MARK: - Component Sum

public func sum(vector: Vector2D) -> Float {
    return vector.x + vector.y
}

public func sum(vector: Vector3D) -> Float {
    return vector.x + vector.y + vector.z
}

public func sum(vector: Vector4D) -> Float {
    return vector.x + vector.y + vector.z + vector.w
}

// MARK: - Length Squared

public func length2(vector: Vector2D) -> Float {
    return sum(vector * vector)
}

public func length2(vector: Vector3D) -> Float {
    return sum(vector * vector)
}

public func length2(vector: Vector4D) -> Float {
    return sum(vector * vector)
}

// MARK: - Length

public func length(vector: Vector2D) -> Float {
    return sqrt(length2(vector))
}

public func length(vector: Vector3D) -> Float {
    return sqrt(length2(vector))
}

public func length(vector: Vector4D) -> Float {
    return sqrt(length2(vector))
}

// MARK: - Normalization

public func normalize(vector: Vector2D) -> Vector2D {
    return vector / length(vector)
}

public func normalize(vector: Vector3D) -> Vector3D {
    return vector / length(vector)
}

public func normalize(vector: Vector4D) -> Vector4D {
    return vector / length(vector)
}

// MARK: - Distance Squared

public func distance2(va: Vector2D, _ vb: Vector2D) -> Float {
    let difference = vb - va
    return sum(difference * difference)
}

public func distance2(va: Vector3D, _ vb: Vector3D) -> Float {
    let difference = vb - va
    return sum(difference * difference)
}

public func distance2(va: Vector4D, _ vb: Vector4D) -> Float {
    let difference = vb - va
    return sum(difference * difference)
}

// MARK: - Distance

public func distance(va: Vector2D, _ vb: Vector2D) -> Float {
    return sqrt(distance2(va, vb))
}

public func distance(va: Vector3D, _ vb: Vector3D) -> Float {
    return sqrt(distance2(va, vb))
}

public func distance(va: Vector4D, _ vb: Vector4D) -> Float {
    return sqrt(distance2(va, vb))
}

// MARK: - Cross Product

public func cross(va: Vector3D, _ vb: Vector3D) -> Vector3D {
    return Vector3D(
        va.y * vb.z - vb.y * va.z,
        va.z * vb.x - vb.z * va.x,
        va.x * vb.y - vb.x * va.y
    )
}

// MARK: - Dot Product

public func dot(va: Vector2D, _ vb: Vector2D) -> Float {
    return sum(va * vb)
}

public func dot(va: Vector3D, _ vb: Vector3D) -> Float {
    return sum(va * vb)
}

public func dot(va: Vector4D, _ vb: Vector4D) -> Float {
    return sum(va * vb)
}

// MARK: - Equatable

public func ==(va: Vector2D, vb: Vector2D) -> Bool {
    return va.x == vb.x && va.y == vb.y
}

public func ==(va: Vector3D, vb: Vector3D) -> Bool {
    return va.x == vb.x && va.y == vb.y && va.z == vb.z
}

public func ==(va: Vector4D, vb: Vector4D) -> Bool {
    return va.x == vb.x && va.y == vb.y && va.z == vb.z && va.w == vb.w
}

// MARK: - Approximately Equal

public func approx(va: Vector2D, _ vb: Vector2D, epsilon: Float = 1e-6) -> Bool {
    let dX = va.x.distanceTo(vb.x)
    let dY = va.y.distanceTo(vb.y)
    let aX = abs(dX) <= epsilon
    let aY = abs(dY) <= epsilon
    return aX && aY
}

public func approx(va: Vector3D, _ vb: Vector3D, epsilon: Float = 1e-6) -> Bool {
    let dX = va.x.distanceTo(vb.x)
    let dY = va.y.distanceTo(vb.y)
    let dZ = va.z.distanceTo(vb.z)
    let aX = abs(dX) <= epsilon
    let aY = abs(dY) <= epsilon
    let aZ = abs(dZ) <= epsilon
    return aX && aY && aZ
}

public func approx(va: Vector4D, _ vb: Vector4D, epsilon: Float = 1e-6) -> Bool {
    let dX = va.x.distanceTo(vb.x)
    let dY = va.y.distanceTo(vb.y)
    let dZ = va.z.distanceTo(vb.z)
    let dW = va.w.distanceTo(vb.w)
    let aX = abs(dX) <= epsilon
    let aY = abs(dY) <= epsilon
    let aZ = abs(dZ) <= epsilon
    let aW = abs(dW) <= epsilon
    return aX && aY && aZ && aW
}

// MARK: - Cosine

public func cos(v: Vector2D) -> Vector2D {
    return Vector2D(
        cos(v.x),
        cos(v.y)
    )
}

public func cos(v: Vector3D) -> Vector3D {
    return Vector3D(
        cos(v.x),
        cos(v.y),
        cos(v.z)
    )
}

public func cos(v: Vector4D) -> Vector4D {
    return Vector4D(
        cos(v.x),
        cos(v.y),
        cos(v.z),
        cos(v.w)
    )
}

// MARK: - Sine

public func sin(v: Vector2D) -> Vector2D {
    return Vector2D(
        sin(v.x),
        sin(v.y)
    )
}

public func sin(v: Vector3D) -> Vector3D {
    return Vector3D(
        sin(v.x),
        sin(v.y),
        sin(v.z)
    )
}

public func sin(v: Vector4D) -> Vector4D {
    return Vector4D(
        sin(v.x),
        sin(v.y),
        sin(v.z),
        sin(v.w)
    )
}
