/*
 The MIT License (MIT)
 
 Copyright (c) 2015-2017 Justin Kolb
 
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

public struct IntVector3<T: FixedWidthInteger> : Hashable, CustomStringConvertible {
    public static var xAxis: IntVector3<T> {
        return IntVector3<T>(1, 0, 0)
    }
    
    public static var yAxis: IntVector3<T> {
        return IntVector3<T>(0, 1, 0)
    }
    
    public static var zAxis: IntVector3<T> {
        return IntVector3<T>(0, 0, 1)
    }
    
    public var x: T
    public var y: T
    public var z: T
    
    @_transparent public var width: T {
        return x
    }
    
    @_transparent public var height: T {
        return y
    }
    
    @_transparent public var depth: T {
        return z
    }
    
    @_transparent public var r: T {
        return x
    }
    
    @_transparent public var g: T {
        return y
    }
    
    @_transparent public var b: T {
        return z
    }

    public init() {
        self.init(0, 0, 0)
    }
    
    public init(_ v: T) {
        self.init(v, v, v)
    }
    
    public init(_ v: IntVector2<T>, _ c: T = 0) {
        self.init(v.x, v.y, c)
    }
    
    public init(_ vf: Vector3<Float>) {
        self.init(T(vf.x), T(vf.y), T(vf.z))
    }
    
    public init(_ vf: Vector3<Double>) {
        self.init(T(vf.x), T(vf.y), T(vf.z))
    }
    
    public init<I: FixedWidthInteger>(_ v: IntVector3<I>) {
        self.init(T(v.x), T(v.y), T(v.z))
    }

    public init(_ x: T, _ y: T, _ z: T) {
        self.x = x
        self.y = y
        self.z = z
    }

    public var components: [T] {
        get {
            return [x, y, z]
        }
        
        set {
            precondition(newValue.count == 3)
            x = newValue[0]
            y = newValue[1]
            z = newValue[2]
        }
    }
    
    public subscript(index: Int) -> T {
        get {
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
        
        set {
            switch index {
            case 0:
                x = newValue
            case 1:
                y = newValue
            case 2:
                z = newValue
            default:
                fatalError("Index out of range")
            }
        }
    }
    
    public var minimum: T {
        return min(min(x, y), z)
    }
    
    public var maximum: T {
        return max(max(x, y), z)
    }
    
    public var description: String {
        return "{\(x), \(y), \(z)}"
    }
    
    // MARK: - Addition
    
    public static func +(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x + b
        let y: T = a.y + b
        let z: T = a.z + b
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func +(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a + b.x
        let y: T = a + b.y
        let z: T = a + b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func +(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x + b.x
        let y: T = a.y + b.y
        let z: T = a.z + b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    // MARK: - Subtraction
    
    public static func -(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x - b
        let y: T = a.y - b
        let z: T = a.z - b
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func -(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a - b.x
        let y: T = a - b.y
        let z: T = a - b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func -(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x - b.x
        let y: T = a.y - b.y
        let z: T = a.z - b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    // MARK: - Multiplication
    
    public static func *(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x * b
        let y: T = a.y * b
        let z: T = a.z * b
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func *(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a * b.x
        let y: T = a * b.y
        let z: T = a * b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func *(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x * b.x
        let y: T = a.y * b.y
        let z: T = a.z * b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    // MARK: - Division
    
    public static func /(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x / b
        let y: T = a.y / b
        let z: T = a.z / b
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func /(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a / b.x
        let y: T = a / b.y
        let z: T = a / b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func /(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x / b.x
        let y: T = a.y / b.y
        let z: T = a.z / b.z
        
        return IntVector3<T>(x, y, z)
    }

    // MARK: - Modulo
    
    public static func %(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x % b
        let y: T = a.y % b
        let z: T = a.z % b
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func %(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a % b.x
        let y: T = a % b.y
        let z: T = a % b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func %(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x % b.x
        let y: T = a.y % b.y
        let z: T = a.z % b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func dot(_ a: IntVector3<T>, _ b: IntVector3<T>) -> T {
        let ab: IntVector3<T> = a * b
        
        return sum(ab)
    }
    
    // MARK: - Sum
    
    public static func sum(_ a: IntVector3<T>) -> T {
        return a.x + a.y + a.z
    }
    
    // MARK: - Geometric
    
    public static func length2(_ a: IntVector3<T>) -> T {
        let a2: IntVector3<T> = a * a
        
        return sum(a2)
    }
    
    public static func distance2(_ a: IntVector3<T>, _ b: IntVector3<T>) -> T {
        let difference: IntVector3<T> = b - a
        let difference2: IntVector3<T> = difference * difference
        
        return sum(difference2)
    }
    
    public static func cross(_ a: IntVector3<T>, _ b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.y * b.z - b.y * a.z
        let y: T = a.z * b.x - b.z * a.x
        let z: T = a.x * b.y - b.x * a.y
        
        return IntVector3<T>(x, y, z)
    }
    
    // MARK: - Bitwise
    
    public static func >>(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x >> b
        let y: T = a.y >> b
        let z: T = a.z >> b

        return IntVector3<T>(x, y, z)
    }
    
    public static func >>(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a >> b.x
        let y: T = a >> b.y
        let z: T = a >> b.z

        return IntVector3<T>(x, y, z)
    }
    
    public static func >>(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x >> b.x
        let y: T = a.y >> b.y
        let z: T = a.z >> b.z

        return IntVector3<T>(x, y, z)
    }
    
    public static func <<(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x << b
        let y: T = a.y << b
        let z: T = a.z << b

        return IntVector3<T>(x, y, z)
    }
    
    public static func <<(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a << b.x
        let y: T = a << b.y
        let z: T = a << b.z

        return IntVector3<T>(x, y, z)
    }
    
    public static func <<(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x << b.x
        let y: T = a.y << b.y
        let z: T = a.z << b.z

        return IntVector3<T>(x, y, z)
    }

    // MARK: - Underflow & Overflow
    
    public static func &+(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x &+ b
        let y: T = a.y &+ b
        let z: T = a.z &+ b
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &+(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a &+ b.x
        let y: T = a &+ b.y
        let z: T = a &+ b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &+(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x &+ b.x
        let y: T = a.y &+ b.y
        let z: T = a.z &+ b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &-(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x &- b
        let y: T = a.y &- b
        let z: T = a.z &- b
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &-(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a &- b.x
        let y: T = a &- b.y
        let z: T = a &- b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &-(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x &- b.x
        let y: T = a.y &- b.y
        let z: T = a.z &- b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &*(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x &* b
        let y: T = a.y &* b
        let z: T = a.z &* b
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &*(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a &* b.x
        let y: T = a &* b.y
        let z: T = a &* b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &*(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x &* b.x
        let y: T = a.y &* b.y
        let z: T = a.z &* b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &>>(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x &>> b
        let y: T = a.y &>> b
        let z: T = a.z &>> b
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &>>(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a &>> b.x
        let y: T = a &>> b.y
        let z: T = a &>> b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &>>(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x &>> b.x
        let y: T = a.y &>> b.y
        let z: T = a.z &>> b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &<<(a: IntVector3<T>, b: T) -> IntVector3<T> {
        let x: T = a.x &<< b
        let y: T = a.y &<< b
        let z: T = a.z &<< b
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &<<(a: T, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a &<< b.x
        let y: T = a &<< b.y
        let z: T = a &<< b.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static func &<<(a: IntVector3<T>, b: IntVector3<T>) -> IntVector3<T> {
        let x: T = a.x &<< b.x
        let y: T = a.y &<< b.y
        let z: T = a.z &<< b.z
        
        return IntVector3<T>(x, y, z)
    }
}

extension IntVector3 where T : SignedInteger {
    // MARK: - Negation
    
    public static prefix func -(v: IntVector3<T>) -> IntVector3<T> {
        let x: T = -v.x
        let y: T = -v.y
        let z: T = -v.z
        
        return IntVector3<T>(x, y, z)
    }
    
    public static prefix func +(v: IntVector3<T>) -> IntVector3<T> {
        let x: T = +v.x
        let y: T = +v.y
        let z: T = +v.z
        
        return IntVector3<T>(x, y, z)
    }
    
    // MARK: Absolute Value
    
    public static func abs(_ a: IntVector3<T>) -> IntVector3<T> {
        let x: T = Swift.abs(a.x)
        let y: T = Swift.abs(a.y)
        let z: T = Swift.abs(a.z)
        
        return IntVector3<T>(x, y, z)
    }
}
