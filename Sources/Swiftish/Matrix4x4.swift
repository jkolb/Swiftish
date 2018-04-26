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

public struct Matrix4x4<T: Vectorable> : Equatable, CustomStringConvertible {
    fileprivate var col0: Vector4<T>
    fileprivate var col1: Vector4<T>
    fileprivate var col2: Vector4<T>
    fileprivate var col3: Vector4<T>
    
    fileprivate var row0: Vector4<T> {
        return Vector4<T>(col0.x, col1.x, col2.x, col3.x)
    }
    
    fileprivate var row1: Vector4<T> {
        return Vector4<T>(col0.y, col1.y, col2.y, col3.y)
    }
    
    fileprivate var row2: Vector4<T> {
        return Vector4<T>(col0.z, col1.z, col2.z, col3.z)
    }
    
    fileprivate var row3: Vector4<T> {
        return Vector4<T>(col0.w, col1.w, col2.w, col3.w)
    }
    
    public init() {
        self.init(
            Vector4<T>(1, 0, 0, 0),
            Vector4<T>(0, 1, 0, 0),
            Vector4<T>(0, 0, 1, 0),
            Vector4<T>(0, 0, 0, 1)
        )
    }
    
    public init(_ v: T) {
        self.init(
            Vector4<T>(v, 0, 0, 0),
            Vector4<T>(0, v, 0, 0),
            Vector4<T>(0, 0, v, 0),
            Vector4<T>(0, 0, 0, v)
        )
    }
    
    public init(_ d: Vector4<T>) {
        self.init(
            Vector4<T>(d.x, 0, 0, 0),
            Vector4<T>(0, d.y, 0, 0),
            Vector4<T>(0, 0, d.z, 0),
            Vector4<T>(0, 0, 0, d.w)
        )
    }

    public init(_ m: Matrix3x3<T>) {
        self.init(
            Vector4<T>(m[0]),
            Vector4<T>(m[1]),
            Vector4<T>(m[2]),
            Vector4<T>(Vector3<T>(), 1)
        )
    }
    
    public init(
        _ x0: T, _ y0: T, _ z0: T, _ w0: T,
        _ x1: T, _ y1: T, _ z1: T, _ w1: T,
        _ x2: T, _ y2: T, _ z2: T, _ w2: T,
        _ x3: T, _ y3: T, _ z3: T, _ w3: T
        )
    {
        self.init(
            Vector4<T>(x0, x1, x2, x3),
            Vector4<T>(y0, y1, y2, y3),
            Vector4<T>(z0, z1, z2, z3),
            Vector4<T>(w0, w1, w2, w3)
        )
    }
    
    public init(_ rows: [[T]]) {
        precondition(rows.count == 4 && rows[0].count == 4 && rows[1].count == 4 && rows[2].count == 4 && rows[3].count == 4)
        self.init(
            Vector4<T>(rows[0][0], rows[1][0], rows[2][0], rows[3][0]),
            Vector4<T>(rows[0][1], rows[1][1], rows[2][1], rows[3][1]),
            Vector4<T>(rows[0][2], rows[1][2], rows[2][2], rows[3][2]),
            Vector4<T>(rows[0][3], rows[1][3], rows[2][3], rows[3][3])
        )
    }
    
    public init(
        _ col0: Vector4<T>,
        _ col1: Vector4<T>,
        _ col2: Vector4<T>,
        _ col3: Vector4<T>
        )
    {
        self.col0 = col0
        self.col1 = col1
        self.col2 = col2
        self.col3 = col3
    }
    
    public subscript(index: Int) -> Vector4<T> {
        get {
            switch index {
            case 0:
                return col0
            case 1:
                return col1
            case 2:
                return col2
            case 3:
                return col3
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
            case 3:
                col3 = newValue
            default:
                fatalError("Index out of range")
            }
        }
    }
    
    public func col(_ index: Int) -> Vector4<T> {
        return self[index]
    }
    
    public func row(_ index: Int) -> Vector4<T> {
        switch index {
        case 0:
            return row0
        case 1:
            return row1
        case 2:
            return row2
        case 3:
            return row3
        default:
            fatalError("Index out of range")
        }
    }
    
    public var transpose: Matrix4x4<T> {
        return Matrix4x4<T>(row0, row1, row2, row3)
    }

    public var description: String {
        return "{\n\t\(row0),\n\t\(row1),\n\t\(row2),\n\t\(row3)}"
    }

    // MARK: - Equatable

    public static func ==(a: Matrix4x4<T>, b: Matrix4x4<T>) -> Bool {
        return a.col0 == b.col0 && a.col1 == b.col1 && a.col2 == b.col2 && a.col3 == b.col3
    }

    // MARK: - Addition

    public static func +(a: Matrix4x4<T>, b: T) -> Matrix4x4<T> {
        let col0: Vector4<T> = a.col0 + b
        let col1: Vector4<T> = a.col1 + b
        let col2: Vector4<T> = a.col2 + b
        let col3: Vector4<T> = a.col3 + b
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    public static func +(a: T, b: Matrix4x4<T>) -> Matrix4x4<T> {
        let col0: Vector4<T> = a + b.col0
        let col1: Vector4<T> = a + b.col1
        let col2: Vector4<T> = a + b.col2
        let col3: Vector4<T> = a + b.col3
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    public static func +(a: Matrix4x4<T>, b: Matrix4x4<T>) -> Matrix4x4<T> {
        let col0: Vector4<T> = a.col0 + b.col0
        let col1: Vector4<T> = a.col1 + b.col1
        let col2: Vector4<T> = a.col2 + b.col2
        let col3: Vector4<T> = a.col3 + b.col3
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    // MARK: - Subtraction

    public static func -(a: Matrix4x4<T>, b: T) -> Matrix4x4<T> {
        let col0: Vector4<T> = a.col0 - b
        let col1: Vector4<T> = a.col1 - b
        let col2: Vector4<T> = a.col2 - b
        let col3: Vector4<T> = a.col3 - b
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    public static func -(a: T, b: Matrix4x4<T>) -> Matrix4x4<T> {
        let col0: Vector4<T> = a - b.col0
        let col1: Vector4<T> = a - b.col1
        let col2: Vector4<T> = a - b.col2
        let col3: Vector4<T> = a - b.col3
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    public static func -(a: Matrix4x4<T>, b: Matrix4x4<T>) -> Matrix4x4<T> {
        let col0: Vector4<T> = a.col0 - b.col0
        let col1: Vector4<T> = a.col1 - b.col1
        let col2: Vector4<T> = a.col2 - b.col2
        let col3: Vector4<T> = a.col3 - b.col3
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    // MARK: - Multiplication

    public static func *(a: Matrix4x4<T>, b: T) -> Matrix4x4<T> {
        let col0: Vector4<T> = a.col0 * b
        let col1: Vector4<T> = a.col1 * b
        let col2: Vector4<T> = a.col2 * b
        let col3: Vector4<T> = a.col3 * b
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    public static func *(a: T, b: Matrix4x4<T>) -> Matrix4x4<T> {
        let col0: Vector4<T> = a * b.col0
        let col1: Vector4<T> = a * b.col1
        let col2: Vector4<T> = a * b.col2
        let col3: Vector4<T> = a * b.col3
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    public static func *(m: Matrix4x4<T>, v: Vector4<T>) -> Vector4<T> {
        let v0 = Vector4<T>(v.x)
        let v1 = Vector4<T>(v.y)
        let mul0: Vector4<T> = m.col0 * v0
        let mul1: Vector4<T> = m.col1 * v1
        let add0: Vector4<T> = mul0 + mul1
        let v2 = Vector4<T>(v.z)
        let v3 = Vector4<T>(v.w)
        let mul2: Vector4<T> = m.col2 * v2
        let mul3: Vector4<T> = m.col3 * v3
        let add1: Vector4<T> = mul2 + mul3
        let add2: Vector4<T> = add0 + add1
        
        return add2
    }

    public static func *(v: Vector4<T>, m: Matrix4x4<T>) -> Vector4<T> {
        let v0 = Vector4<T>(v.x)
        let v1 = Vector4<T>(v.y)
        let mul0: Vector4<T> = m.row0 * v0
        let mul1: Vector4<T> = m.row1 * v1
        let add0: Vector4<T> = mul0 + mul1
        let v2 = Vector4<T>(v.z)
        let v3 = Vector4<T>(v.w)
        let mul2: Vector4<T> = m.row2 * v2
        let mul3: Vector4<T> = m.row3 * v3
        let add1: Vector4<T> = mul2 + mul3
        let add2: Vector4<T> = add0 + add1
        
        return add2
    }

    public static func *(m1: Matrix4x4<T>, m2: Matrix4x4<T>) -> Matrix4x4<T> {
        let a0: Vector4<T> = m1.col0
        let a1: Vector4<T> = m1.col1
        let a2: Vector4<T> = m1.col2
        let a3: Vector4<T> = m1.col3
        
        let b0: Vector4<T> = m2.col0
        let b1: Vector4<T> = m2.col1
        let b2: Vector4<T> = m2.col2
        let b3: Vector4<T> = m2.col3
        
        let a0b0x: Vector4<T> = a0 * b0.x
        let a1b0y: Vector4<T> = a1 * b0.y
        let a2b0z: Vector4<T> = a2 * b0.z
        let a3b0w: Vector4<T> = a3 * b0.w
        
        let a0b1x: Vector4<T> = a0 * b1.x
        let a1b1y: Vector4<T> = a1 * b1.y
        let a2b1z: Vector4<T> = a2 * b1.z
        let a3b1w: Vector4<T> = a3 * b1.w
        
        let a0b2x: Vector4<T> = a0 * b2.x
        let a1b2y: Vector4<T> = a1 * b2.y
        let a2b2z: Vector4<T> = a2 * b2.z
        let a3b2w: Vector4<T> = a3 * b2.w
        
        let a0b3x: Vector4<T> = a0 * b3.x
        let a1b3y: Vector4<T> = a1 * b3.y
        let a2b3z: Vector4<T> = a2 * b3.z
        let a3b3w: Vector4<T> = a3 * b3.w
        
        let col0: Vector4<T> = a0b0x + a1b0y + a2b0z + a3b0w
        let col1: Vector4<T> = a0b1x + a1b1y + a2b1z + a3b1w
        let col2: Vector4<T> = a0b2x + a1b2y + a2b2z + a3b2w
        let col3: Vector4<T> = a0b3x + a1b3y + a2b3z + a3b3w
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    // MARK: - Division

    public static func /(a: Matrix4x4<T>, b: T) -> Matrix4x4<T> {
        let col0: Vector4<T> = a.col0 / b
        let col1: Vector4<T> = a.col1 / b
        let col2: Vector4<T> = a.col2 / b
        let col3: Vector4<T> = a.col3 / b
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    public static func /(a: T, b: Matrix4x4<T>) -> Matrix4x4<T> {
        let col0: Vector4<T> = a / b.col0
        let col1: Vector4<T> = a / b.col1
        let col2: Vector4<T> = a / b.col2
        let col3: Vector4<T> = a / b.col3
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }

    // MARK: - Division
    
    public static func /(m: Matrix4x4<T>, v: Vector4<T>) -> Vector4<T> {
        return Matrix4x4<T>.invert(m) * v
    }
    
    public static func /(v: Vector4<T>, m: Matrix4x4<T>) -> Vector4<T> {
        return v * Matrix4x4<T>.invert(m)
    }
    
    public static func /(m1: Matrix4x4<T>, m2: Matrix4x4<T>) -> Matrix4x4<T> {
        return m1 * Matrix4x4<T>.invert(m2)
    }
    
    // MARK: - Negation
    
    public static prefix func -(m: Matrix4x4<T>) -> Matrix4x4<T> {
        let col0: Vector4<T> = -m.col0
        let col1: Vector4<T> = -m.col1
        let col2: Vector4<T> = -m.col2
        let col3: Vector4<T> = -m.col3
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }
    
    public static prefix func +(m: Matrix4x4<T>) -> Matrix4x4<T> {
        let col0: Vector4<T> = +m.col0
        let col1: Vector4<T> = +m.col1
        let col2: Vector4<T> = +m.col2
        let col3: Vector4<T> = +m.col3
        
        return Matrix4x4<T>(col0, col1, col2, col3)
    }
    
    // MARK: Approximately Equal
    
    public static func approx(_ a: Matrix4x4<T>, _ b: Matrix4x4<T>, epsilon: T) -> Bool {
        let col0: Bool = Vector4<T>.approx(a.col0, b.col0, epsilon: epsilon)
        let col1: Bool = Vector4<T>.approx(a.col1, b.col1, epsilon: epsilon)
        let col2: Bool = Vector4<T>.approx(a.col2, b.col2, epsilon: epsilon)
        let col3: Bool = Vector4<T>.approx(a.col3, b.col3, epsilon: epsilon)
        
        return col0 && col1 && col2 && col3
    }
    
    // MARK: - Inverse
    
    public static func invert(_ m: Matrix4x4<T>) -> Matrix4x4<T> {
        let m00: T = m.col0.x
        let m10: T = m.col1.x
        let m20: T = m.col2.x
        let m30: T = m.col3.x
        let m01: T = m.col0.y
        let m11: T = m.col1.y
        let m21: T = m.col2.y
        let m31: T = m.col3.y
        let m02: T = m.col0.z
        let m12: T = m.col1.z
        let m22: T = m.col2.z
        let m32: T = m.col3.z
        let m03: T = m.col0.w
        let m13: T = m.col1.w
        let m23: T = m.col2.w
        let m33: T = m.col3.w
        
        let c00: T = m22 * m33 - m32 * m23
        let c02: T = m12 * m33 - m32 * m13
        let c03: T = m12 * m23 - m22 * m13
        
        let c04: T = m21 * m33 - m31 * m23
        let c06: T = m11 * m33 - m31 * m13
        let c07: T = m11 * m23 - m21 * m13
        
        let c08: T = m21 * m32 - m31 * m22
        let c10: T = m11 * m32 - m31 * m12
        let c11: T = m11 * m22 - m21 * m12
        
        let c12: T = m20 * m33 - m30 * m23
        let c14: T = m10 * m33 - m30 * m13
        let c15: T = m10 * m23 - m20 * m13
        
        let c16: T = m20 * m32 - m30 * m22
        let c18: T = m10 * m32 - m30 * m12
        let c19: T = m10 * m22 - m20 * m12
        
        let c20: T = m20 * m31 - m30 * m21
        let c22: T = m10 * m31 - m30 * m11
        let c23: T = m10 * m21 - m20 * m11
        
        let f0 = Vector4<T>(c00, c00, c02, c03)
        let f1 = Vector4<T>(c04, c04, c06, c07)
        let f2 = Vector4<T>(c08, c08, c10, c11)
        let f3 = Vector4<T>(c12, c12, c14, c15)
        let f4 = Vector4<T>(c16, c16, c18, c19)
        let f5 = Vector4<T>(c20, c20, c22, c23)
        
        let v0 = Vector4<T>(m10, m00, m00, m00)
        let v1 = Vector4<T>(m11, m01, m01, m01)
        let v2 = Vector4<T>(m12, m02, m02, m02)
        let v3 = Vector4<T>(m13, m03, m03, m03)
        
        let i0: Vector4<T> = v1 * f0 - v2 * f1 + v3 * f2
        let i1: Vector4<T> = v0 * f0 - v2 * f3 + v3 * f4
        let i2: Vector4<T> = v0 * f1 - v1 * f3 + v3 * f5
        let i3: Vector4<T> = v0 * f2 - v1 * f4 + v2 * f5
        
        let sA = Vector4<T>(+1, -1, +1, -1)
        let sB = Vector4<T>(-1, +1, -1, +1)
        
        let col0: Vector4<T> = i0 * sA
        let col1: Vector4<T> = i1 * sB
        let col2: Vector4<T> = i2 * sA
        let col3: Vector4<T> = i3 * sB
        
        let iM = Matrix4x4<T>(col0, col1, col2, col3)
        
        let d: T = Vector4<T>.sum(m.col0 * iM.row0)
        let oneOverDeterminant = 1 / d
        
        return iM * oneOverDeterminant
    }
}
