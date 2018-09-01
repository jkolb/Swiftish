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

public struct Matrix3x3<T: Vectorable> : Hashable, CustomStringConvertible {
    fileprivate var col0: Vector3<T>
    fileprivate var col1: Vector3<T>
    fileprivate var col2: Vector3<T>
    
    fileprivate var row0: Vector3<T> {
        return Vector3<T>(col0.x, col1.x, col2.x)
    }
    
    fileprivate var row1: Vector3<T> {
        return Vector3<T>(col0.y, col1.y, col2.y)
    }
    
    fileprivate var row2: Vector3<T> {
        return Vector3<T>(col0.z, col1.z, col2.z)
    }
    
    public init() {
        self.init(
            Vector3<T>(1, 0, 0),
            Vector3<T>(0, 1, 0),
            Vector3<T>(0, 0, 1)
        )
    }
    
    public init(_ v: T) {
        self.init(
            Vector3<T>(v, 0, 0),
            Vector3<T>(0, v, 0),
            Vector3<T>(0, 0, v)
        )
    }
    
    public init(_ d: Vector3<T>) {
        self.init(
            Vector3<T>(d.x, 0, 0),
            Vector3<T>(0, d.y, 0),
            Vector3<T>(0, 0, d.z)
        )
    }
    
    public init(_ m: Matrix2x2<T>) {
        self.init(
            Vector3<T>(m[0]),
            Vector3<T>(m[1]),
            Vector3<T>(Vector2<T>(), 1)
        )
    }
    
    public init(
        _ x0: T, _ y0: T, _ z0: T,
        _ x1: T, _ y1: T, _ z1: T,
        _ x2: T, _ y2: T, _ z2: T
        )
    {
        self.init(
            Vector3<T>(x0, x1, x2),
            Vector3<T>(y0, y1, y2),
            Vector3<T>(z0, z1, z2)
        )
    }
    
    public init(_ rows: [[T]]) {
        precondition(rows.count == 3 && rows[0].count == 3 && rows[1].count == 3 && rows[2].count == 3)
        self.init(
            Vector3<T>(rows[0][0], rows[1][0], rows[2][0]),
            Vector3<T>(rows[0][1], rows[1][1], rows[2][1]),
            Vector3<T>(rows[0][2], rows[1][2], rows[2][2])
        )
    }
    
    public init(
        _ col0: Vector3<T>,
        _ col1: Vector3<T>,
        _ col2: Vector3<T>
        )
    {
        self.col0 = col0
        self.col1 = col1
        self.col2 = col2
    }
    
    public subscript(index: Int) -> Vector3<T> {
        get {
            switch index {
            case 0:
                return col0
            case 1:
                return col1
            case 2:
                return col2
            default:
                fatalError("Index out of range")
            }
        }
        
        set {
            switch index {
            case 0:
                col0 = newValue
            case 1:
                col1 = newValue
            case 2:
                col2 = newValue
            default:
                fatalError("Index out of range")
            }
        }
    }
    
    public func col(_ index: Int) -> Vector3<T> {
        return self[index]
    }
    
    public func row(_ index: Int) -> Vector3<T> {
        switch index {
        case 0:
            return row0
        case 1:
            return row1
        case 2:
            return row2
        default:
            fatalError("Index out of range")
        }
    }
    
    public var transpose: Matrix3x3<T> {
        return Matrix3x3<T>(row0, row1, row2)
    }

    public var description: String {
        return "{\n\t\(row0),\n\t\(row1),\n\t\(row2)}"
    }

    // MARK: - Addition

    public static func +(a: Matrix3x3<T>, b: T) -> Matrix3x3<T> {
        let col0: Vector3<T> = a.col0 + b
        let col1: Vector3<T> = a.col1 + b
        let col2: Vector3<T> = a.col2 + b
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    public static func +(a: T, b: Matrix3x3<T>) -> Matrix3x3<T> {
        let col0: Vector3<T> = a + b.col0
        let col1: Vector3<T> = a + b.col1
        let col2: Vector3<T> = a + b.col2
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    public static func +(a: Matrix3x3<T>, b: Matrix3x3<T>) -> Matrix3x3<T> {
        let col0: Vector3<T> = a.col0 + b.col0
        let col1: Vector3<T> = a.col1 + b.col1
        let col2: Vector3<T> = a.col2 + b.col2
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    // MARK: - Subtraction

    public static func -(a: Matrix3x3<T>, b: T) -> Matrix3x3<T> {
        let col0: Vector3<T> = a.col0 - b
        let col1: Vector3<T> = a.col1 - b
        let col2: Vector3<T> = a.col2 - b
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    public static func -(a: T, b: Matrix3x3<T>) -> Matrix3x3<T> {
        let col0: Vector3<T> = a - b.col0
        let col1: Vector3<T> = a - b.col1
        let col2: Vector3<T> = a - b.col2
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    public static func -(a: Matrix3x3<T>, b: Matrix3x3<T>) -> Matrix3x3<T> {
        let col0: Vector3<T> = a.col0 - b.col0
        let col1: Vector3<T> = a.col1 - b.col1
        let col2: Vector3<T> = a.col2 - b.col2
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    // MARK: - Multiplication

    public static func *(a: Matrix3x3<T>, b: T) -> Matrix3x3<T> {
        let col0: Vector3<T> = a.col0 * b
        let col1: Vector3<T> = a.col1 * b
        let col2: Vector3<T> = a.col2 * b
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    public static func *(a: T, b: Matrix3x3<T>) -> Matrix3x3<T> {
        let col0: Vector3<T> = a * b.col0
        let col1: Vector3<T> = a * b.col1
        let col2: Vector3<T> = a * b.col2
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    public static func *(m: Matrix3x3<T>, v: Vector3<T>) -> Vector3<T> {
        let x: T = m.col0.x * v.x + m.col1.x * v.y + m.col2.x * v.z
        let y: T = m.col0.y * v.x + m.col1.y * v.y + m.col2.y * v.z
        let z: T = m.col0.z * v.x + m.col1.z * v.y + m.col2.z * v.z
        
        return Vector3<T>(x, y, z)
    }

    public static func *(v: Vector3<T>, m: Matrix3x3<T>) -> Vector3<T> {
        let x: T = m.col0.x * v.x + m.col0.y * v.y + m.col0.z * v.z
        let y: T = m.col1.x * v.x + m.col1.y * v.y + m.col1.z * v.z
        let z: T = m.col2.x * v.x + m.col2.y * v.y + m.col2.z * v.z
        
        return Vector3<T>(x, y, z)
    }

    public static func *(m1: Matrix3x3<T>, m2: Matrix3x3<T>) -> Matrix3x3<T> {
        let a00: T = m1.col0.x
        let a01: T = m1.col0.y
        let a02: T = m1.col0.z
        let a10: T = m1.col1.x
        let a11: T = m1.col1.y
        let a12: T = m1.col1.z
        let a20: T = m1.col2.x
        let a21: T = m1.col2.y
        let a22: T = m1.col2.z
        
        let b00: T = m2.col0.x
        let b01: T = m2.col0.y
        let b02: T = m2.col0.z
        let b10: T = m2.col1.x
        let b11: T = m2.col1.y
        let b12: T = m2.col1.z
        let b20: T = m2.col2.x
        let b21: T = m2.col2.y
        let b22: T = m2.col2.z
        
        let x0: T = a00 * b00 + a10 * b01 + a20 * b02
        let y0: T = a01 * b00 + a11 * b01 + a21 * b02
        let z0: T = a02 * b00 + a12 * b01 + a22 * b02
        let x1: T = a00 * b10 + a10 * b11 + a20 * b12
        let y1: T = a01 * b10 + a11 * b11 + a21 * b12
        let z1: T = a02 * b10 + a12 * b11 + a22 * b12
        let x2: T = a00 * b20 + a10 * b21 + a20 * b22
        let y2: T = a01 * b20 + a11 * b21 + a21 * b22
        let z2: T = a02 * b20 + a12 * b21 + a22 * b22
        
        let col0 = Vector3<T>(x0, y0, z0)
        let col1 = Vector3<T>(x1, y1, z1)
        let col2 = Vector3<T>(x2, y2, z2)
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    // MARK: - Division

    public static func /(a: Matrix3x3<T>, b: T) -> Matrix3x3<T> {
        let col0: Vector3<T> = a.col0 / b
        let col1: Vector3<T> = a.col1 / b
        let col2: Vector3<T> = a.col2 / b
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    public static func /(a: T, b: Matrix3x3<T>) -> Matrix3x3<T> {
        let col0: Vector3<T> = a / b.col0
        let col1: Vector3<T> = a / b.col1
        let col2: Vector3<T> = a / b.col2
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    // MARK: - Division
    
    public static func /(m: Matrix3x3<T>, v: Vector3<T>) -> Vector3<T> {
        return Matrix3x3<T>.invert(m) * v
    }
    
    public static func /(v: Vector3<T>, m: Matrix3x3<T>) -> Vector3<T> {
        return v * Matrix3x3<T>.invert(m)
    }
    
    public static func /(m1: Matrix3x3<T>, m2: Matrix3x3<T>) -> Matrix3x3<T> {
        return m1 * Matrix3x3<T>.invert(m2)
    }
    
    // MARK: - Negation
    
    public static prefix func -(m: Matrix3x3<T>) -> Matrix3x3<T> {
        let col0: Vector3<T> = -m.col0
        let col1: Vector3<T> = -m.col1
        let col2: Vector3<T> = -m.col2
        
        return Matrix3x3<T>(col0, col1, col2)
    }
    
    public static prefix func +(m: Matrix3x3<T>) -> Matrix3x3<T> {
        let col0: Vector3<T> = +m.col0
        let col1: Vector3<T> = +m.col1
        let col2: Vector3<T> = +m.col2
        
        return Matrix3x3<T>(col0, col1, col2)
    }
    
    // MARK: Approximately Equal
    
    public static func approx(_ a: Matrix3x3<T>, _ b: Matrix3x3<T>, epsilon: T) -> Bool {
        let col0: Bool = Vector3<T>.approx(a.col0, b.col0, epsilon: epsilon)
        let col1: Bool = Vector3<T>.approx(a.col1, b.col1, epsilon: epsilon)
        let col2: Bool = Vector3<T>.approx(a.col2, b.col2, epsilon: epsilon)
        
        return col0 && col1 && col2
    }
    
    // MARK: - Inverse
    
    public static func invert(_ m: Matrix3x3<T>) -> Matrix3x3<T> {
        let m00: T = m.col0.x
        let m10: T = m.col1.x
        let m20: T = m.col2.x
        let m01: T = m.col0.y
        let m11: T = m.col1.y
        let m21: T = m.col2.y
        let m02: T = m.col0.z
        let m12: T = m.col1.z
        let m22: T = m.col2.z
        
        let a: T = +(m00 * (m11 * m22 - m21 * m12))
        let b: T = -(m10 * (m01 * m22 - m21 * m02))
        let c: T = +(m20 * (m01 * m12 - m11 * m02))
        
        let oneOverDeterminant = 1 / (a + b + c)
        
        let x0: T = +(m11 * m22 - m21 * m12) * oneOverDeterminant
        let y0: T = -(m10 * m22 - m20 * m12) * oneOverDeterminant
        let z0: T = +(m10 * m21 - m20 * m11) * oneOverDeterminant
        let x1: T = -(m01 * m22 - m21 * m02) * oneOverDeterminant
        let y1: T = +(m00 * m22 - m20 * m02) * oneOverDeterminant
        let z1: T = -(m00 * m21 - m20 * m01) * oneOverDeterminant
        let x2: T = +(m01 * m12 - m11 * m02) * oneOverDeterminant
        let y2: T = -(m00 * m12 - m10 * m02) * oneOverDeterminant
        let z2: T = +(m00 * m11 - m10 * m01) * oneOverDeterminant
        
        let col0 = Vector3<T>(x0, y0, z0)
        let col1 = Vector3<T>(x1, y1, z1)
        let col2 = Vector3<T>(x2, y2, z2)
        
        return Matrix3x3<T>(col0, col1, col2)
    }
}
