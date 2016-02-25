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

// MARK: - Quaternion

public struct Quaternion : Equatable, CustomStringConvertible {
    public let w, x, y, z: Float
    
    public init() {
        self.w = 1
        self.x = 0
        self.y = 0
        self.z = 0
    }
    
    public init(_ w: Float, _ v: Vector3D) {
        self.w = w
        self.x = v.x
        self.y = v.y
        self.z = v.z
    }
    
    public init(_ w: Float, _ x: Float, _ y: Float, _ z: Float) {
        self.w = w
        self.x = x
        self.y = y
        self.z = z
    }
    
    public init(eulerAngle: Vector3D) {
        let halfEulerAngle = eulerAngle * 0.5
        let c = cos(halfEulerAngle)
        let s = sin(halfEulerAngle)
        self.w = c.x * c.y * c.z + s.x * s.y * s.z
        self.x = s.x * c.y * c.z - c.x * s.y * s.z
        self.y = c.x * s.y * c.z + s.x * c.y * s.z
        self.z = c.x * c.y * s.z - s.x * s.y * c.z
    }
    
    public init(_ m: Matrix3x3) {
        let q = convert(m)
        self.w = q.w
        self.x = q.x
        self.y = q.y
        self.z = q.z
    }
    
    public init(angle: Float, axis: Vector3D) {
        let halfAngle = angle * 0.5
        let s = sin(halfAngle)
        let c = cos(halfAngle)
        self.w = c
        self.x = axis.x * s
        self.y = axis.y * s
        self.z = axis.z * s
    }
    
    public func angle() -> Float {
        return acos(w) * 2
    }
    
    public func axis() -> Vector3D {
        let t1 = 1 - w * w
        
        if t1 <= 0 {
            return Vector3D(0, 0, 1)
        }
        
        let t2 = 1 / sqrt(t1)
        
        return Vector3D(
            x * t2,
            y * t2,
            z * t2
        )
    }

    public func roll() -> Float {
        let a = 2 * (x * y + w * z)
        let b = w * w + x * x - y * y - z * z
        return atan2(a, b)
    }
    
    public func pitch() -> Float {
        let a = 2 * (y * z + w * x)
        let b = w * w - x * x - y * y + z * z
        return atan2(a, b)
    }
    
    public func yaw() -> Float {
        let a = -2 * (x * z - w * y)
        return asin(a)
    }
    
    public func eulerAngles() -> Vector3D {
        return Vector3D(
            pitch(),
            yaw(),
            roll()
        )
    }
    
    public func matrix3x3() -> Matrix3x3 {
        return convert(self)
    }
    
    public func matrix4x4() -> Matrix4x4 {
        return convert(self)
    }
    
    public var description: String {
        return "{\(w), \(x), \(y), \(z)}"
    }
}

// MARK: - Equatable

public func ==(va: Quaternion, vb: Quaternion) -> Bool {
    return va.w == vb.w && va.x == vb.x && va.y == vb.y && va.z == vb.z
}

// MARK: - Conjugate

public func conjugate(q: Quaternion) -> Quaternion {
    return Quaternion(q.w, -q.x, -q.y, -q.z)
}

// MARK: - Inverse

public func inverse(q: Quaternion) -> Quaternion {
    return conjugate(q) / dot(q, q)
}

// MARK: - Dot Product

public func dot(lhs: Quaternion, _ rhs: Quaternion) -> Float {
    let v = Vector4D(
        lhs.x * rhs.x,
        lhs.y * rhs.y,
        lhs.z * rhs.z,
        lhs.w * rhs.w
    )
    return sum(v)
}

// MARK: - Multiplication

public func *(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
    let w = lhs.w * rhs.w - lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z
    let x = lhs.w * rhs.x + lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y
    let y = lhs.w * rhs.y + lhs.y * rhs.w + lhs.z * rhs.x - lhs.x * rhs.z
    let z = lhs.w * rhs.z + lhs.z * rhs.w + lhs.x * rhs.y - lhs.y * rhs.x
    return Quaternion(w, x, y, z)
}

// MARK: - Scalar Multiplication

public func *(lhs: Quaternion, rhs: Float) -> Quaternion {
    return Quaternion(
        lhs.w * rhs,
        lhs.x * rhs,
        lhs.y * rhs,
        lhs.z * rhs
    )
}

// MARK: - Scalar Division

public func /(lhs: Quaternion, rhs: Float) -> Quaternion {
    return Quaternion(
        lhs.w / rhs,
        lhs.x / rhs,
        lhs.y / rhs,
        lhs.z / rhs
    )
}

// MARK: - Normalization

public func normalize(q: Quaternion) -> Quaternion {
    let length = sqrt(dot(q, q))
    if length <= 0 {
        return Quaternion()
    }
    let inverseLength = 1 / length
    return q * inverseLength
}

// MARK: - Matrix Conversion

public func convert(q: Quaternion) -> Matrix3x3 {
    let qxx = q.x * q.x
    let qyy = q.y * q.y
    let qzz = q.z * q.z
    let qxz = q.x * q.z
    let qxy = q.x * q.y
    let qyz = q.y * q.z
    let qwx = q.w * q.x
    let qwy = q.w * q.y
    let qwz = q.w * q.z
    
    let m0x = 1 - 2 * (qyy +  qzz)
    let m0y = 2 * (qxy + qwz)
    let m0z = 2 * (qxz - qwy)
    
    let m1x = 2 * (qxy - qwz)
    let m1y = 1 - 2 * (qxx +  qzz)
    let m1z = 2 * (qyz + qwx)
    
    let m2x = 2 * (qxz + qwy)
    let m2y = 2 * (qyz - qwx)
    let m2z = 1 - 2 * (qxx +  qyy)
    
    return Matrix3x3(
        m0x, m0y, m0z,
        m1x, m1y, m1z,
        m2x, m2y, m2z
    )
}

public func convert(q: Quaternion) -> Matrix4x4 {
    return Matrix4x4(convert(q))
}

public func convert(m: Matrix3x3) -> Quaternion {
    let m00 = m[0].x
    let m10 = m[1].x
    let m20 = m[2].x
    let m01 = m[0].y
    let m11 = m[1].y
    let m21 = m[2].y
    let m02 = m[0].z
    let m12 = m[1].z
    let m22 = m[2].z
    
    let fX = m00 - m11 - m22
    let fY = m11 - m00 - m22
    let fZ = m22 - m00 - m11
    let fW = m00 + m11 + m22
    
    var index = 0
    var fMax = fW
    
    if fX > fMax {
        index = 1
        fMax = fX
    }
    
    if fY > fMax {
        index = 2
        fMax = fY
    }
    
    if fZ > fMax {
        index = 3
        fMax = fZ
    }
    
    let max = sqrt(fMax + 1.0) * 0.5
    let mul = 0.25 / max
    
    switch index {
    case 0:
        let w = max
        let x = (m12 - m21) * mul
        let y = (m20 - m02) * mul
        let z = (m01 - m10) * mul
        return Quaternion(w, x, y, z)
    case 1:
        let w = (m12 - m21) * mul
        let x = max
        let y = (m01 + m10) * mul
        let z = (m20 + m02) * mul
        return Quaternion(w, x, y, z)
    case 2:
        let w = (m20 - m02) * mul
        let x = (m01 + m10) * mul
        let y = max
        let z = (m12 + m21) * mul
        return Quaternion(w, x, y, z)
    case 3:
        let w = (m01 - m10) * mul
        let x = (m20 + m02) * mul
        let y = (m12 + m21) * mul
        let z = max
        return Quaternion(w, x, y, z)
    default:
        preconditionFailure("Should never happen")
    }
}
