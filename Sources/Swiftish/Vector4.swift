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

public struct Vector4<T: Vectorable> : Hashable, CustomStringConvertible {
    public var x: T
    public var y: T
    public var z: T
    public var w: T
    
    @_transparent public var r: T {
        return x
    }
    
    @_transparent public var g: T {
        return y
    }
    
    @_transparent public var b: T {
        return z
    }
    
    @_transparent public var a: T {
        return w
    }

    public init() {
        self.init(0, 0, 0, 0)
    }
    
    public init(_ v: T) {
        self.init(v, v, v, v)
    }
    
    public init(_ v: Vector3<T>, _ c: T = 0) {
        self.init(v.x, v.y, v.z, c)
    }

    public init(_ x: T, _ y: T, _ z: T, _ w: T) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public var components: [T] {
        get {
            return [x, y, z, w]
        }
        
        set {
            precondition(newValue.count == 4)
            x = newValue[0]
            y = newValue[1]
            z = newValue[2]
            w = newValue[3]
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
            case 3:
                return w
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
            case 3:
                w = newValue
            default:
                fatalError("Index out of range")
            }
        }
    }
    
    public var minimum: T {
        return min(min(min(x, y), z), w)
    }
    
    public var maximum: T {
        return min(max(max(x, y), z), w)
    }

    public var description: String {
        return "{\(x), \(y), \(z), \(w)}"
    }

    // MARK: - Addition

    public static func +(a: Vector4<T>, b: T) -> Vector4<T> {
        let x: T = a.x + b
        let y: T = a.y + b
        let z: T = a.z + b
        let w: T = a.w + b
        
        return Vector4<T>(x, y, z, w)
    }

    public static func +(a: T, b: Vector4<T>) -> Vector4<T> {
        let x: T = a + b.x
        let y: T = a + b.y
        let z: T = a + b.z
        let w: T = a + b.w
        
        return Vector4<T>(x, y, z, w)
    }

    public static func +(a: Vector4<T>, b: Vector4<T>) -> Vector4<T> {
        let x: T = a.x + b.x
        let y: T = a.y + b.y
        let z: T = a.z + b.z
        let w: T = a.w + b.w
        
        return Vector4<T>(x, y, z, w)
    }

    // MARK: - Subtraction

    public static func -(a: Vector4<T>, b: T) -> Vector4<T> {
        let x: T = a.x - b
        let y: T = a.y - b
        let z: T = a.z - b
        let w: T = a.w - b
        
        return Vector4<T>(x, y, z, w)
    }

    public static func -(a: T, b: Vector4<T>) -> Vector4<T> {
        let x: T = a - b.x
        let y: T = a - b.y
        let z: T = a - b.z
        let w: T = a - b.w
        
        return Vector4<T>(x, y, z, w)
    }

    public static func -(a: Vector4<T>, b: Vector4<T>) -> Vector4<T> {
        let x: T = a.x - b.x
        let y: T = a.y - b.y
        let z: T = a.z - b.z
        let w: T = a.w - b.w
        
        return Vector4<T>(x, y, z, w)
    }

    // MARK: - Multiplication

    public static func *(a: Vector4<T>, b: T) -> Vector4<T> {
        return Vector4<T>(
            a.x * b,
            a.y * b,
            a.z * b,
            a.w * b
        )
    }

    public static func *(a: T, b: Vector4<T>) -> Vector4<T> {
        let x: T = a * b.x
        let y: T = a * b.y
        let z: T = a * b.z
        let w: T = a * b.w
        
        return Vector4<T>(x, y, z, w)
    }

    public static func *(a: Vector4<T>, b: Vector4<T>) -> Vector4<T> {
        let x: T = a.x * b.x
        let y: T = a.y * b.y
        let z: T = a.z * b.z
        let w: T = a.w * b.w
        
        return Vector4<T>(x, y, z, w)
    }

    // MARK: - Division

    public static func /(a: Vector4<T>, b: T) -> Vector4<T> {
        let x: T = a.x / b
        let y: T = a.y / b
        let z: T = a.z / b
        let w: T = a.w / b
        
        return Vector4<T>(x, y, z, w)
    }

    public static func /(a: T, b: Vector4<T>) -> Vector4<T> {
        let x: T = a / b.x
        let y: T = a / b.y
        let z: T = a / b.z
        let w: T = a / b.w
        
        return Vector4<T>(x, y, z, w)
    }

    public static func /(a: Vector4<T>, b: Vector4<T>) -> Vector4<T> {
        let x: T = a.x / b.x
        let y: T = a.y / b.y
        let z: T = a.z / b.z
        let w: T = a.w / b.w
        
        return Vector4<T>(x, y, z, w)
    }

    // MARK: - Negation
    
    public static prefix func -(v: Vector4<T>) -> Vector4<T> {
        let x: T = -v.x
        let y: T = -v.y
        let z: T = -v.z
        let w: T = -v.w
        
        return Vector4<T>(x, y, z, w)
    }
    
    public static prefix func +(v: Vector4<T>) -> Vector4<T> {
        let x: T = +v.x
        let y: T = +v.y
        let z: T = +v.z
        let w: T = +v.w
        
        return Vector4<T>(x, y, z, w)
    }
    
    // MARK: Approximately Equal
    
    public static func approx(_ a: Vector4<T>, _ b: Vector4<T>, epsilon: T) -> Bool {
        let delta: Vector4<T> = b - a
        let magnitude: Vector4<T> = abs(delta)
        
        return magnitude.x <= epsilon && magnitude.y <= epsilon && magnitude.z <= epsilon && magnitude.w <= epsilon
    }
    
    // MARK: Absolute Value
    
    public static func abs(_ a: Vector4<T>) -> Vector4<T> {
        let x: T = Swift.abs(a.x)
        let y: T = Swift.abs(a.y)
        let z: T = Swift.abs(a.z)
        let w: T = Swift.abs(a.w)
        
        return Vector4<T>(x, y, z, w)
    }
    
    // MARK: - Sum
    
    public static func sum(_ a: Vector4<T>) -> T {
        return a.x + a.y + a.z + a.w
    }
    
    // MARK: - Geometric
    
    public static func length(_ a: Vector4<T>) -> T {
        return Vector4<T>.length2(a).squareRoot()
    }
    
    public static func length2(_ a: Vector4<T>) -> T {
        let a2: Vector4<T> = a * a
        
        return Vector4<T>.sum(a2)
    }
    
    public static func normalize(_ a: Vector4<T>) -> Vector4<T> {
        return a / Vector4<T>.length(a)
    }
    
    public static func distance(_ a: Vector4<T>, _ b: Vector4<T>) -> T {
        return Vector4<T>.distance2(a, b).squareRoot()
    }
    
    public static func distance2(_ a: Vector4<T>, _ b: Vector4<T>) -> T {
        let difference: Vector4<T> = b - a
        let difference2: Vector4<T> = difference * difference
        
        return Vector4<T>.sum(difference2)
    }
    
    public static func dot(_ a: Vector4<T>, _ b: Vector4<T>) -> T {
        let ab: Vector4<T> = a * b
        
        return Vector4<T>.sum(ab)
    }
    
    // Trigonometry
    
    public static func cos(_ a: Vector4<T>) -> Vector4<T> {
        let x: T = T.cos(a.x)
        let y: T = T.cos(a.y)
        let z: T = T.cos(a.z)
        let w: T = T.cos(a.w)
        
        return Vector4<T>(x, y, z, w)
    }
    
    public static func sin(_ a: Vector4<T>) -> Vector4<T> {
        let x: T = T.sin(a.x)
        let y: T = T.sin(a.y)
        let z: T = T.sin(a.z)
        let w: T = T.sin(a.w)
        
        return Vector4<T>(x, y, z, w)
    }
}

extension Vector4 where T == Float {
    public init(_ vf: IntVector4<UInt8>) {
        self.init(Float(vf.x), Float(vf.y), Float(vf.z), Float(vf.w))
    }
    
    public init(_ vf: IntVector4<Int8>) {
        self.init(Float(vf.x), Float(vf.y), Float(vf.z), Float(vf.w))
    }
    
    public init(_ vf: IntVector4<UInt16>) {
        self.init(Float(vf.x), Float(vf.y), Float(vf.z), Float(vf.w))
    }
    
    public init(_ vf: IntVector4<Int16>) {
        self.init(Float(vf.x), Float(vf.y), Float(vf.z), Float(vf.w))
    }
    
    public init(_ vf: IntVector4<UInt32>) {
        self.init(Float(vf.x), Float(vf.y), Float(vf.z), Float(vf.w))
    }
    
    public init(_ vf: IntVector4<Int32>) {
        self.init(Float(vf.x), Float(vf.y), Float(vf.z), Float(vf.w))
    }
    
    public init(_ vf: IntVector4<UInt64>) {
        self.init(Float(vf.x), Float(vf.y), Float(vf.z), Float(vf.w))
    }
    
    public init(_ vf: IntVector4<Int64>) {
        self.init(Float(vf.x), Float(vf.y), Float(vf.z), Float(vf.w))
    }
    
    public init(_ vf: IntVector4<UInt>) {
        self.init(Float(vf.x), Float(vf.y), Float(vf.z), Float(vf.w))
    }
    
    public init(_ vf: IntVector4<Int>) {
        self.init(Float(vf.x), Float(vf.y), Float(vf.z), Float(vf.w))
    }
}

extension Vector4 where T == Double {
    public init(_ vf: IntVector4<UInt8>) {
        self.init(Double(vf.x), Double(vf.y), Double(vf.z), Double(vf.w))
    }
    
    public init(_ vf: IntVector4<Int8>) {
        self.init(Double(vf.x), Double(vf.y), Double(vf.z), Double(vf.w))
    }
    
    public init(_ vf: IntVector4<UInt16>) {
        self.init(Double(vf.x), Double(vf.y), Double(vf.z), Double(vf.w))
    }
    
    public init(_ vf: IntVector4<Int16>) {
        self.init(Double(vf.x), Double(vf.y), Double(vf.z), Double(vf.w))
    }
    
    public init(_ vf: IntVector4<UInt32>) {
        self.init(Double(vf.x), Double(vf.y), Double(vf.z), Double(vf.w))
    }
    
    public init(_ vf: IntVector4<Int32>) {
        self.init(Double(vf.x), Double(vf.y), Double(vf.z), Double(vf.w))
    }
    
    public init(_ vf: IntVector4<UInt64>) {
        self.init(Double(vf.x), Double(vf.y), Double(vf.z), Double(vf.w))
    }
    
    public init(_ vf: IntVector4<Int64>) {
        self.init(Double(vf.x), Double(vf.y), Double(vf.z), Double(vf.w))
    }
    
    public init(_ vf: IntVector4<UInt>) {
        self.init(Double(vf.x), Double(vf.y), Double(vf.z), Double(vf.w))
    }
    
    public init(_ vf: IntVector4<Int>) {
        self.init(Double(vf.x), Double(vf.y), Double(vf.z), Double(vf.w))
    }
}
