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

// MARK: - Matrix2x2

public struct Matrix2x2 : Equatable, CustomStringConvertible {
    public typealias ColType = Vector2D
    public typealias RowType = Vector2D
    
    private let col0, col1: ColType
    
    private var row0: RowType {
        return Vector2D(col0.x, col1.x)
    }
    
    private var row1: RowType {
        return Vector2D(col0.y, col1.y)
    }
    
    public init() {
        self.col0 = ColType(1, 0)
        self.col1 = ColType(0, 1)
    }
    
    public init(_ v: Float) {
        self.col0 = ColType(v, 0)
        self.col1 = ColType(0, v)
    }
    
    public init(
        _ col0: ColType,
        _ col1: ColType
        )
    {
        self.col0 = col0
        self.col1 = col1
    }
    
    public init(
        _ x0: Float, _ y0: Float,
        _ x1: Float, _ y1: Float
        )
    {
        self.col0 = ColType(x0, y0)
        self.col1 = ColType(x1, y1)
    }
    
    public subscript(index: Int) -> ColType {
        switch index {
        case 0:
            return col0
        case 1:
            return col1
        default:
            fatalError("Index out of range")
        }
    }
    
    public func col(index: Int) -> ColType {
        return self[index]
    }
    
    public func row(index: Int) -> RowType {
        switch index {
        case 0:
            return row0
        case 1:
            return row1
        default:
            fatalError("Index out of range")
        }
    }
    
    public var description: String {
        return "{\(col0), \(col1)}"
    }
}

// MARK: - Matrix3x3

public struct Matrix3x3 : CustomStringConvertible {
    public typealias ColType = Vector3D
    public typealias RowType = Vector3D

    private let col0, col1, col2: ColType
    
    private var row0: RowType {
        return Vector3D(col0.x, col1.x, col2.x)
    }
    
    private var row1: RowType {
        return Vector3D(col0.y, col1.y, col2.y)
    }
    
    private var row2: RowType {
        return Vector3D(col0.z, col1.z, col2.z)
    }
    
    public init() {
        self.col0 = ColType(1, 0, 0)
        self.col1 = ColType(0, 1, 0)
        self.col2 = ColType(0, 0, 1)
    }
    
    public init(_ v: Float) {
        self.col0 = ColType(v, 0, 0)
        self.col1 = ColType(0, v, 0)
        self.col2 = ColType(0, 0, v)
    }
    
    public init(
        _ col0: ColType,
        _ col1: ColType,
        _ col2: ColType
        )
    {
        self.col0 = col0
        self.col1 = col1
        self.col2 = col2
    }
    
    public init(
        _ x0: Float, _ y0: Float, _ z0: Float,
        _ x1: Float, _ y1: Float, _ z1: Float,
        _ x2: Float, _ y2: Float, _ z2: Float
        )
    {
        self.col0 = ColType(x0, y0, z0)
        self.col1 = ColType(x1, y1, z1)
        self.col2 = ColType(x2, y2, z2)
    }
    
    public subscript(index: Int) -> ColType {
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
    
    public func col(index: Int) -> ColType {
        return self[index]
    }
    
    public func row(index: Int) -> RowType {
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
    
    public var description: String {
        return "{\(col0), \(col1), \(col2)}"
    }
}

// MARK: - Matrix4x4

public struct Matrix4x4 : CustomStringConvertible {
    public typealias ColType = Vector4D
    public typealias RowType = Vector4D

    private let col0, col1, col2, col3: ColType
    
    private var row0: RowType {
        return Vector4D(col0.x, col1.x, col2.x, col3.x)
    }
    
    private var row1: RowType {
        return Vector4D(col0.y, col1.y, col2.y, col3.y)
    }
    
    private var row2: RowType {
        return Vector4D(col0.z, col1.z, col2.z, col3.z)
    }
    
    private var row3: RowType {
        return Vector4D(col0.w, col1.w, col2.w, col3.w)
    }
    
    public init() {
        self.col0 = ColType(1, 0, 0, 0)
        self.col1 = ColType(0, 1, 0, 0)
        self.col2 = ColType(0, 0, 1, 0)
        self.col3 = ColType(0, 0, 0, 1)
    }
    
    public init(_ v: Float) {
        self.col0 = ColType(v, 0, 0, 0)
        self.col1 = ColType(0, v, 0, 0)
        self.col2 = ColType(0, 0, v, 0)
        self.col3 = ColType(0, 0, 0, v)
    }
    
    public init(
        _ col0: ColType,
        _ col1: ColType,
        _ col2: ColType,
        _ col3: ColType
        )
    {
        self.col0 = col0
        self.col1 = col1
        self.col2 = col2
        self.col3 = col3
    }
    
    public init(
        _ x0: Float, _ y0: Float, _ z0: Float, _ w0: Float,
        _ x1: Float, _ y1: Float, _ z1: Float, _ w1: Float,
        _ x2: Float, _ y2: Float, _ z2: Float, _ w2: Float,
        _ x3: Float, _ y3: Float, _ z3: Float, _ w3: Float
        )
    {
        self.col0 = ColType(x0, y0, z0, w0)
        self.col1 = ColType(x1, y1, z1, w1)
        self.col2 = ColType(x2, y2, z2, w2)
        self.col3 = ColType(x3, y3, z3, w3)
    }
    
    public init(_ m: Matrix3x3) {
        self.col0 = ColType(m.col0, 0)
        self.col1 = ColType(m.col1, 0)
        self.col2 = ColType(m.col2, 0)
        self.col3 = ColType(0, 0, 0, 1)
    }
    
    public subscript(index: Int) -> ColType {
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
    
    public func col(index: Int) -> ColType {
        return self[index]
    }
    
    public func row(index: Int) -> RowType {
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
    
    public var description: String {
        return "{\(col0), \(col1), \(col2), \(col3)}"
    }
}

// MARK: - Scalar Addition

public func +(lhs: Matrix2x2, rhs: Float) -> Matrix2x2 {
    return Matrix2x2(
        lhs.col0 + rhs,
        lhs.col1 + rhs
    )
}

public func +(lhs: Float, rhs: Matrix2x2) -> Matrix2x2 {
    return Matrix2x2(
        lhs + rhs.col0,
        lhs + rhs.col1
    )
}

public func +(lhs: Matrix3x3, rhs: Float) -> Matrix3x3 {
    return Matrix3x3(
        lhs.col0 + rhs,
        lhs.col1 + rhs,
        lhs.col2 + rhs
    )
}

public func +(lhs: Float, rhs: Matrix3x3) -> Matrix3x3 {
    return Matrix3x3(
        lhs + rhs.col0,
        lhs + rhs.col1,
        lhs + rhs.col2
    )
}

public func +(lhs: Matrix4x4, rhs: Float) -> Matrix4x4 {
    return Matrix4x4(
        lhs.col0 + rhs,
        lhs.col1 + rhs,
        lhs.col2 + rhs,
        lhs.col3 + rhs
    )
}

public func +(lhs: Float, rhs: Matrix4x4) -> Matrix4x4 {
    return Matrix4x4(
        lhs + rhs.col0,
        lhs + rhs.col1,
        lhs + rhs.col2,
        lhs + rhs.col3
    )
}

// MARK: - Addition

public func +(lhs: Matrix2x2, rhs: Matrix2x2) -> Matrix2x2 {
    return Matrix2x2(
        lhs.col0 + rhs.col0,
        lhs.col1 + rhs.col1
    )
}

public func +(lhs: Matrix3x3, rhs: Matrix3x3) -> Matrix3x3 {
    return Matrix3x3(
        lhs.col0 + rhs.col0,
        lhs.col1 + rhs.col1,
        lhs.col2 + rhs.col2
    )
}

public func +(lhs: Matrix4x4, rhs: Matrix4x4) -> Matrix4x4 {
    return Matrix4x4(
        lhs.col0 + rhs.col0,
        lhs.col1 + rhs.col1,
        lhs.col2 + rhs.col2,
        lhs.col3 + rhs.col3
    )
}

// MARK: - Scalar Subtraction

public func -(lhs: Matrix2x2, rhs: Float) -> Matrix2x2 {
    return Matrix2x2(
        lhs.col0 - rhs,
        lhs.col1 - rhs
    )
}

public func -(lhs: Float, rhs: Matrix2x2) -> Matrix2x2 {
    return Matrix2x2(
        lhs - rhs.col0,
        lhs - rhs.col1
    )
}

public func -(lhs: Matrix3x3, rhs: Float) -> Matrix3x3 {
    return Matrix3x3(
        lhs.col0 - rhs,
        lhs.col1 - rhs,
        lhs.col2 - rhs
    )
}

public func -(lhs: Float, rhs: Matrix3x3) -> Matrix3x3 {
    return Matrix3x3(
        lhs - rhs.col0,
        lhs - rhs.col1,
        lhs - rhs.col2
    )
}

public func -(lhs: Matrix4x4, rhs: Float) -> Matrix4x4 {
    return Matrix4x4(
        lhs.col0 - rhs,
        lhs.col1 - rhs,
        lhs.col2 - rhs,
        lhs.col3 - rhs
    )
}

public func -(lhs: Float, rhs: Matrix4x4) -> Matrix4x4 {
    return Matrix4x4(
        lhs - rhs.col0,
        lhs - rhs.col1,
        lhs - rhs.col2,
        lhs - rhs.col3
    )
}

// MARK: - Subtraction

public func -(lhs: Matrix2x2, rhs: Matrix2x2) -> Matrix2x2 {
    return Matrix2x2(
        lhs.col0 - rhs.col0,
        lhs.col1 - rhs.col1
    )
}

public func -(lhs: Matrix3x3, rhs: Matrix3x3) -> Matrix3x3 {
    return Matrix3x3(
        lhs.col0 - rhs.col0,
        lhs.col1 - rhs.col1,
        lhs.col2 - rhs.col2
    )
}

public func -(lhs: Matrix4x4, rhs: Matrix4x4) -> Matrix4x4 {
    return Matrix4x4(
        lhs.col0 - rhs.col0,
        lhs.col1 - rhs.col1,
        lhs.col2 - rhs.col2,
        lhs.col3 - rhs.col3
    )
}

// MARK: - Scalar Multiplication

public func *(lhs: Matrix2x2, rhs: Float) -> Matrix2x2 {
    return Matrix2x2(
        lhs.col0 * rhs,
        lhs.col1 * rhs
    )
}

public func *(lhs: Float, rhs: Matrix2x2) -> Matrix2x2 {
    return Matrix2x2(
        lhs * rhs.col0,
        lhs * rhs.col1
    )
}

public func *(lhs: Matrix3x3, rhs: Float) -> Matrix3x3 {
    return Matrix3x3(
        lhs.col0 * rhs,
        lhs.col1 * rhs,
        lhs.col2 * rhs
    )
}

public func *(lhs: Float, rhs: Matrix3x3) -> Matrix3x3 {
    return Matrix3x3(
        lhs * rhs.col0,
        lhs * rhs.col1,
        lhs * rhs.col2
    )
}

public func *(lhs: Matrix4x4, rhs: Float) -> Matrix4x4 {
    return Matrix4x4(
        lhs.col0 * rhs,
        lhs.col1 * rhs,
        lhs.col2 * rhs,
        lhs.col3 * rhs
    )
}

public func *(lhs: Float, rhs: Matrix4x4) -> Matrix4x4 {
    return Matrix4x4(
        lhs * rhs.col0,
        lhs * rhs.col1,
        lhs * rhs.col2,
        lhs * rhs.col3
    )
}

// MARK: - Multiplication

public func *(m: Matrix2x2, v: Vector2D) -> Vector2D {
    let x = m.col0.x * v.x + m.col1.x * v.y
    let y = m.col0.y * v.x + m.col1.y * v.y
    return Vector2D(x, y)
}

public func *(v: Vector2D, m: Matrix2x2) -> Vector2D {
    let x = v.x * m.col0.x + v.y * m.col0.y
    let y = v.x * m.col1.x + v.y * m.col1.y
    return Vector2D(x, y)
}

public func *(m1: Matrix2x2, m2: Matrix2x2) -> Matrix2x2 {
    let a00 = m1.col0.x
    let a01 = m1.col0.y
    let a10 = m1.col1.x
    let a11 = m1.col1.y
    
    let b00 = m2.col0.x
    let b01 = m2.col0.y
    let b10 = m2.col1.x
    let b11 = m2.col1.y
    
    let x0 = a00 * b00 + a10 * b01
    let y0 = a01 * b00 + a11 * b01
    let x1 = a00 * b10 + a10 * b11
    let y1 = a01 * b10 + a11 * b11
    
    return Matrix2x2(
        x0, y0,
        x1, y1
    )
}

public func *(m: Matrix3x3, v: Vector3D) -> Vector3D {
    let x = m.col0.x * v.x + m.col1.x * v.y + m.col2.x * v.z
    let y = m.col0.y * v.x + m.col1.y * v.y + m.col2.y * v.z
    let z = m.col0.z * v.x + m.col1.z * v.y + m.col2.z * v.z
    return Vector3D(x, y, z)
}

public func *(v: Vector3D, m: Matrix3x3) -> Vector3D {
    let x = m.col0.x * v.x + m.col0.y * v.y + m.col0.z * v.z
    let y = m.col1.x * v.x + m.col1.y * v.y + m.col1.z * v.z
    let z = m.col2.x * v.x + m.col2.y * v.y + m.col2.z * v.z
    return Vector3D(x, y, z)
}

public func *(m1: Matrix3x3, m2: Matrix3x3) -> Matrix3x3 {
    let a00 = m1.col0.x
    let a01 = m1.col0.y
    let a02 = m1.col0.z
    let a10 = m1.col1.x
    let a11 = m1.col1.y
    let a12 = m1.col1.z
    let a20 = m1.col2.x
    let a21 = m1.col2.y
    let a22 = m1.col2.z

    let b00 = m2.col0.x
    let b01 = m2.col0.y
    let b02 = m2.col0.z
    let b10 = m2.col1.x
    let b11 = m2.col1.y
    let b12 = m2.col1.z
    let b20 = m2.col2.x
    let b21 = m2.col2.y
    let b22 = m2.col2.z

    let x0 = a00 * b00 + a10 * b01 + a20 * b02
    let y0 = a01 * b00 + a11 * b01 + a21 * b02
    let z0 = a02 * b00 + a12 * b01 + a22 * b02
    let x1 = a00 * b10 + a10 * b11 + a20 * b12
    let y1 = a01 * b10 + a11 * b11 + a21 * b12
    let z1 = a02 * b10 + a12 * b11 + a22 * b12
    let x2 = a00 * b20 + a10 * b21 + a20 * b22
    let y2 = a01 * b20 + a11 * b21 + a21 * b22
    let z2 = a02 * b20 + a12 * b21 + a22 * b22
    
    return Matrix3x3(
        x0, y0, z0,
        x1, y1, z1,
        x2, y2, z2
    )
}

public func *(m: Matrix4x4, v: Vector4D) -> Vector4D {
    let v0 = Vector4D(v.x)
    let v1 = Vector4D(v.y)
    let mul0 = m.col0 * v0
    let mul1 = m.col1 * v1
    let add0 = mul0 + mul1
    let v2 = Vector4D(v.z)
    let v3 = Vector4D(v.w)
    let mul2 = m.col2 * v2
    let mul3 = m.col3 * v3
    let add1 = mul2 + mul3
    let add2 = add0 + add1
    return add2
}

public func *(v: Vector4D, m: Matrix4x4) -> Vector4D {
    let v0 = Vector4D(v.x)
    let v1 = Vector4D(v.y)
    let mul0 = m.row0 * v0
    let mul1 = m.row1 * v1
    let add0 = mul0 + mul1
    let v2 = Vector4D(v.z)
    let v3 = Vector4D(v.w)
    let mul2 = m.row2 * v2
    let mul3 = m.row3 * v3
    let add1 = mul2 + mul3
    let add2 = add0 + add1
    return add2
}

public func *(m1: Matrix4x4, m2: Matrix4x4) -> Matrix4x4 {
    let a0 = m1.col0
    let a1 = m1.col1
    let a2 = m1.col2
    let a3 = m1.col3
    
    let b0 = m2.col0
    let b1 = m2.col1
    let b2 = m2.col2
    let b3 = m2.col3
    
    let a0b0x = a0 * b0.x
    let a1b0y = a1 * b0.y
    let a2b0z = a2 * b0.z
    let a3b0w = a3 * b0.w

    let a0b1x = a0 * b1.x
    let a1b1y = a1 * b1.y
    let a2b1z = a2 * b1.z
    let a3b1w = a3 * b1.w
    
    let a0b2x = a0 * b2.x
    let a1b2y = a1 * b2.y
    let a2b2z = a2 * b2.z
    let a3b2w = a3 * b2.w
    
    let a0b3x = a0 * b3.x
    let a1b3y = a1 * b3.y
    let a2b3z = a2 * b3.z
    let a3b3w = a3 * b3.w

    let col0 = a0b0x + a1b0y + a2b0z + a3b0w
    let col1 = a0b1x + a1b1y + a2b1z + a3b1w
    let col2 = a0b2x + a1b2y + a2b2z + a3b2w
    let col3 = a0b3x + a1b3y + a2b3z + a3b3w
    
    return Matrix4x4(
        col0,
        col1,
        col2,
        col3
    )
}

// MARK: - Scalar Division

public func /(lhs: Matrix2x2, rhs: Float) -> Matrix2x2 {
    return Matrix2x2(
        lhs.col0 / rhs,
        lhs.col1 / rhs
    )
}

public func /(lhs: Float, rhs: Matrix2x2) -> Matrix2x2 {
    return Matrix2x2(
        lhs / rhs.col0,
        lhs / rhs.col1
    )
}

public func /(lhs: Matrix3x3, rhs: Float) -> Matrix3x3 {
    return Matrix3x3(
        lhs.col0 / rhs,
        lhs.col1 / rhs,
        lhs.col2 / rhs
    )
}

public func /(lhs: Float, rhs: Matrix3x3) -> Matrix3x3 {
    return Matrix3x3(
        lhs / rhs.col0,
        lhs / rhs.col1,
        lhs / rhs.col2
    )
}

public func /(lhs: Matrix4x4, rhs: Float) -> Matrix4x4 {
    return Matrix4x4(
        lhs.col0 / rhs,
        lhs.col1 / rhs,
        lhs.col2 / rhs,
        lhs.col3 / rhs
    )
}

public func /(lhs: Float, rhs: Matrix4x4) -> Matrix4x4 {
    return Matrix4x4(
        lhs / rhs.col0,
        lhs / rhs.col1,
        lhs / rhs.col2,
        lhs / rhs.col3
    )
}

// MARK: - Division

public func /(m: Matrix2x2, v: Vector2D) -> Vector2D {
    return inverse(m) * v
}

public func /(v: Vector2D, m: Matrix2x2) -> Vector2D {
    return v * inverse(m)
}

public func /(m1: Matrix2x2, m2: Matrix2x2) -> Matrix2x2 {
    return m1 * inverse(m2)
}

public func /(m: Matrix3x3, v: Vector3D) -> Vector3D {
    return inverse(m) * v
}

public func /(v: Vector3D, m: Matrix3x3) -> Vector3D {
    return v * inverse(m)
}

public func /(m1: Matrix3x3, m2: Matrix3x3) -> Matrix3x3 {
    return m1 * inverse(m2)
}

public func /(m: Matrix4x4, v: Vector4D) -> Vector4D {
    return inverse(m) * v
}

public func /(v: Vector4D, m: Matrix4x4) -> Vector4D {
    return v * inverse(m)
}

public func /(m1: Matrix4x4, m2: Matrix4x4) -> Matrix4x4 {
    return m1 * inverse(m2)
}

// MARK: - Inverse

public func inverse(m: Matrix2x2) -> Matrix2x2 {
    let a = m.col0.x
    let b = m.col1.x
    let c = m.col0.y
    let d = m.col1.y
    
    let ad = a * d
    let bc = b * c
    
    let oneOverDeterminant = 1 / (ad - bc)
    
    let x0 = +d * oneOverDeterminant
    let x1 = -b * oneOverDeterminant
    let y0 = -c * oneOverDeterminant
    let y1 = +a * oneOverDeterminant
    
    return Matrix2x2(
        x0, y0,
        x1, y1
    )
}

public func inverse(m: Matrix3x3) -> Matrix3x3 {
    let m00 = m.col0.x
    let m10 = m.col1.x
    let m20 = m.col2.x
    let m01 = m.col0.y
    let m11 = m.col1.y
    let m21 = m.col2.y
    let m02 = m.col0.z
    let m12 = m.col1.z
    let m22 = m.col2.z
    
    let a = +(m00 * (m11 * m22 - m21 * m12))
    let b = -(m10 * (m01 * m22 - m21 * m02))
    let c = +(m20 * (m01 * m12 - m11 * m02))
    
    let oneOverDeterminant = 1 / (a + b + c)
    
    let x0 = +(m11 * m22 - m21 * m12) * oneOverDeterminant
    let y0 = -(m10 * m22 - m20 * m12) * oneOverDeterminant
    let z0 = +(m10 * m21 - m20 * m11) * oneOverDeterminant
    let x1 = -(m01 * m22 - m21 * m02) * oneOverDeterminant
    let y1 = +(m00 * m22 - m20 * m02) * oneOverDeterminant
    let z1 = -(m00 * m21 - m20 * m01) * oneOverDeterminant
    let x2 = +(m01 * m12 - m11 * m02) * oneOverDeterminant
    let y2 = -(m00 * m12 - m10 * m02) * oneOverDeterminant
    let z2 = +(m00 * m11 - m10 * m01) * oneOverDeterminant
    
    return Matrix3x3(
        x0, y0, z0,
        x1, y1, z1,
        x2, y2, z2
    )
}

public func inverse(m: Matrix4x4) -> Matrix4x4 {
    let m00 = m.col0.x
    let m10 = m.col1.x
    let m20 = m.col2.x
    let m30 = m.col3.x
    let m01 = m.col0.y
    let m11 = m.col1.y
    let m21 = m.col2.y
    let m31 = m.col3.y
    let m02 = m.col0.z
    let m12 = m.col1.z
    let m22 = m.col2.z
    let m32 = m.col3.z
    let m03 = m.col0.w
    let m13 = m.col1.w
    let m23 = m.col2.w
    let m33 = m.col3.w
    
    let c00 = m22 * m33 - m32 * m23
    let c02 = m12 * m33 - m32 * m13
    let c03 = m12 * m23 - m22 * m13
    
    let c04 = m21 * m33 - m31 * m23
    let c06 = m11 * m33 - m31 * m13
    let c07 = m11 * m23 - m21 * m13
    
    let c08 = m21 * m32 - m31 * m22
    let c10 = m11 * m32 - m31 * m12
    let c11 = m11 * m22 - m21 * m12
    
    let c12 = m20 * m33 - m30 * m23
    let c14 = m10 * m33 - m30 * m13
    let c15 = m10 * m23 - m20 * m13
    
    let c16 = m20 * m32 - m30 * m22
    let c18 = m10 * m32 - m30 * m12
    let c19 = m10 * m22 - m20 * m12
    
    let c20 = m20 * m31 - m30 * m21
    let c22 = m10 * m31 - m30 * m11
    let c23 = m10 * m21 - m20 * m11
    
    let f0 = Vector4D(c00, c00, c02, c03)
    let f1 = Vector4D(c04, c04, c06, c07)
    let f2 = Vector4D(c08, c08, c10, c11)
    let f3 = Vector4D(c12, c12, c14, c15)
    let f4 = Vector4D(c16, c16, c18, c19)
    let f5 = Vector4D(c20, c20, c22, c23)
    
    let v0 = Vector4D(m10, m00, m00, m00)
    let v1 = Vector4D(m11, m01, m01, m01)
    let v2 = Vector4D(m12, m02, m02, m02)
    let v3 = Vector4D(m13, m03, m03, m03)
    
    let i0 = v1 * f0 - v2 * f1 + v3 * f2
    let i1 = v0 * f0 - v2 * f3 + v3 * f4
    let i2 = v0 * f1 - v1 * f3 + v3 * f5
    let i3 = v0 * f2 - v1 * f4 + v2 * f5
    
    let one: Float = 1
    let sA = Vector4D(+one, -one, +one, -one)
    let sB = Vector4D(-one, +one, -one, +one)
    // This causes tests to fail, not sure why
//    let sA = Vector4D(+1, -1, +1, -1)
//    let sB = Vector4D(-1, +1, -1, +1)
    
    let iM = Matrix4x4(
        i0 * sA,
        i1 * sB,
        i2 * sA,
        i3 * sB
    )

    let d = sum(m.col0 * iM.row0)
    let oneOverDeterminant = 1 / d
    
    return iM * oneOverDeterminant
}

// MARK: - Negation

public prefix func -(m: Matrix2x2) -> Matrix2x2 {
    return Matrix2x2(
        -m.col0,
        -m.col1
    )
}

public prefix func -(m: Matrix3x3) -> Matrix3x3 {
    return Matrix3x3(
        -m.col0,
        -m.col1,
        -m.col2
    )
}

public prefix func -(m: Matrix4x4) -> Matrix4x4 {
    return Matrix4x4(
        -m.col0,
        -m.col1,
        -m.col2,
        -m.col3
    )
}

public prefix func +(m: Matrix2x2) -> Matrix2x2 {
    return m
}

public prefix func +(m: Matrix3x3) -> Matrix3x3 {
    return m
}

public prefix func +(m: Matrix4x4) -> Matrix4x4 {
    return m
}

// MARK: - Equatable

public func ==(va: Matrix2x2, vb: Matrix2x2) -> Bool {
    return va.col0 == vb.col0 && va.col1 == vb.col1
}

public func ==(va: Matrix3x3, vb: Matrix3x3) -> Bool {
    return va.col0 == vb.col0 && va.col1 == vb.col1 && va.col2 == vb.col2
}

public func ==(va: Matrix4x4, vb: Matrix4x4) -> Bool {
    return va.col0 == vb.col0 && va.col1 == vb.col1 && va.col2 == vb.col2 && va.col3 == vb.col3
}

// MARK: Approximately Equal

public func approx(ma: Matrix2x2, _ mb: Matrix2x2, epsilon: Float = 1e-6) -> Bool {
    let a0 = approx(ma.col0, mb.col0, epsilon: epsilon)
    let a1 = approx(ma.col1, mb.col1, epsilon: epsilon)
    return a0 && a1
}

public func approx(ma: Matrix3x3, _ mb: Matrix3x3, epsilon: Float = 1e-6) -> Bool {
    let a0 = approx(ma.col0, mb.col0, epsilon: epsilon)
    let a1 = approx(ma.col1, mb.col1, epsilon: epsilon)
    let a2 = approx(ma.col2, mb.col2, epsilon: epsilon)
    return a0 && a1 && a2
}

public func approx(ma: Matrix4x4, _ mb: Matrix4x4, epsilon: Float = 1e-6) -> Bool {
    let a0 = approx(ma.col0, mb.col0, epsilon: epsilon)
    let a1 = approx(ma.col1, mb.col1, epsilon: epsilon)
    let a2 = approx(ma.col2, mb.col2, epsilon: epsilon)
    let a3 = approx(ma.col3, mb.col3, epsilon: epsilon)
    return a0 && a1 && a2 && a3
}
