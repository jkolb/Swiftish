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

public struct Vector2<T: Vectorable> : Equatable, CustomStringConvertible {
    public static var xAxis: Vector2<T> {
        return Vector2<T>(1, 0)
    }
    
    public static var yAxis: Vector2<T> {
        return Vector2<T>(0, 1)
    }
    
    public var x: T
    public var y: T
    
    public init() {
        self.init(0, 0)
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
    
    public var minimum: T {
        return min(x, y)
    }
    
    public var maximum: T {
        return max(x, y)
    }
    
    public var description: String {
        return "{\(x), \(y)}"
    }

    // MARK: - Equatable

    public static func ==(a: Vector2<T>, b: Vector2<T>) -> Bool {
        return a.x == b.x && a.y == b.y
    }

    // MARK: - Addition

    public static func +(a: Vector2<T>, b: T) -> Vector2<T> {
        let x: T = a.x + b
        let y: T = a.y + b
        
        return Vector2<T>(x, y)
    }

    public static func +(a: T, b: Vector2<T>) -> Vector2<T> {
        let x: T = a + b.x
        let y: T = a + b.y
        
        return Vector2<T>(x, y)
    }

    public static func +(a: Vector2<T>, b: Vector2<T>) -> Vector2<T> {
        let x: T = a.x + b.x
        let y: T = a.y + b.y
        
        return Vector2<T>(x, y)
    }

    // MARK: - Subtraction

    public static func -(a: Vector2<T>, b: T) -> Vector2<T> {
        let x: T = a.x - b
        let y: T = a.y - b
        
        return Vector2<T>(x, y)
    }

    public static func -(a: T, b: Vector2<T>) -> Vector2<T> {
        let x: T = a - b.x
        let y: T = a - b.y
        
        return Vector2<T>(x, y)
    }

    public static func -(a: Vector2<T>, b: Vector2<T>) -> Vector2<T> {
        let x: T = a.x - b.x
        let y: T = a.y - b.y
        
        return Vector2<T>(x, y)
    }

    // MARK: - Multiplication

    public static func *(a: Vector2<T>, b: T) -> Vector2<T> {
        let x: T = a.x * b
        let y: T = a.y * b
        
        return Vector2<T>(x, y)
    }

    public static func *(a: T, b: Vector2<T>) -> Vector2<T> {
        let x: T = a * b.x
        let y: T = a * b.y
        
        return Vector2<T>(x, y)
    }

    public static func *(a: Vector2<T>, b: Vector2<T>) -> Vector2<T> {
        let x: T = a.x * b.x
        let y: T = a.y * b.y
        
        return Vector2<T>(x, y)
    }

    // MARK: - Division

    public static func /(a: Vector2<T>, b: T) -> Vector2<T> {
        let x: T = a.x / b
        let y: T = a.y / b
        
        return Vector2<T>(x, y)
    }

    public static func /(a: T, b: Vector2<T>) -> Vector2<T> {
        let x: T = a / b.x
        let y: T = a / b.y
        
        return Vector2<T>(x, y)
    }

    public static func /(a: Vector2<T>, b: Vector2<T>) -> Vector2<T> {
        let x: T = a.x / b.x
        let y: T = a.y / b.y
        
        return Vector2<T>(x, y)
    }

    // MARK: - Negation
    
    public static prefix func -(v: Vector2<T>) -> Vector2<T> {
        let x: T = -v.x
        let y: T = -v.y
        
        return Vector2<T>(x, y)
    }
    
    public static prefix func +(v: Vector2<T>) -> Vector2<T> {
        let x: T = +v.x
        let y: T = +v.y
        
        return Vector2<T>(x, y)
    }
    
    // MARK: Approximately Equal
    
    public static func approx(_ a: Vector2<T>, _ b: Vector2<T>, epsilon: T) -> Bool {
        let delta: Vector2<T> = b - a
        let magnitude: Vector2<T> = Vector2<T>.abs(delta)
        
        return magnitude.x <= epsilon && magnitude.y <= epsilon
    }
    
    // MARK: Absolute Value
    
    public static func abs(_ a: Vector2<T>) -> Vector2<T> {
        let x: T = Swift.abs(a.x)
        let y: T = Swift.abs(a.y)
        
        return Vector2<T>(x, y)
    }
    
    // MARK: - Sum
    
    public static func sum(_ a: Vector2<T>) -> T {
        return a.x + a.y
    }
    
    // MARK: - Geometric
    
    public static func length(_ a: Vector2<T>) -> T {
        return length2(a).squareRoot()
    }
    
    public static func length2(_ a: Vector2<T>) -> T {
        let a2: Vector2<T> = a * a
        
        return sum(a2)
    }
    
    public static func normalize(_ a: Vector2<T>) -> Vector2<T> {
        return a / length(a)
    }
    
    public static func distance(_ a: Vector2<T>, _ b: Vector2<T>) -> T {
        return distance2(a, b).squareRoot()
    }
    
    public static func distance2(_ a: Vector2<T>, _ b: Vector2<T>) -> T {
        let difference: Vector2<T> = b - a
        let difference2: Vector2<T> = difference * difference
        
        return sum(difference2)
    }
    
    public static func dot(_ a: Vector2<T>, _ b: Vector2<T>) -> T {
        let ab: Vector2<T> = a * b
        
        return sum(ab)
    }
    
    // Trigonometry
    
    public static func cos(_ a: Vector2<T>) -> Vector2<T> {
        let x: T = T.cos(a.x)
        let y: T = T.cos(a.y)
        
        return Vector2<T>(x, y)
    }
    
    public static func sin(_ a: Vector2<T>) -> Vector2<T> {
        let x: T = T.sin(a.x)
        let y: T = T.sin(a.y)
        
        return Vector2<T>(x, y)
    }
}
