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

// MARK: - Quaternion

public struct Quaternion<T: RealArithmetic> {
    public let w, x, y, z: T
    
    public init() {
        self.w = 1
        self.x = 0
        self.y = 0
        self.z = 0
    }
    
    public init(_ w: T, _ v: Vector3<T>) {
        self.w = w
        self.x = v.x
        self.y = v.y
        self.z = v.z
    }
    
    public init(_ w: T, _ x: T, _ y: T, _ z: T) {
        self.w = w
        self.x = x
        self.y = y
        self.z = z
    }
    
    public init(eulerAngle: Vector3<T>) {
        let halfEulerAngle = eulerAngle * 0.5
        let c = cos(halfEulerAngle)
        let s = sin(halfEulerAngle)
        self.w = c.x * c.y * c.z + s.x * s.y * s.z
        self.x = s.x * c.y * c.z - c.x * s.y * s.z
        self.y = c.x * s.y * c.z + s.x * c.y * s.z
        self.z = c.x * c.y * s.z - s.x * s.y * c.z
    }
    
    public init(_ m: Matrix3<T>) {
        let q = convert(m)
        self.w = q.w
        self.x = q.x
        self.y = q.y
        self.z = q.z
    }
    
    public init(angle: T, axis: Vector3<T>) {
        let halfAngle = angle * 0.5
        let s = T.sin(halfAngle)
        let c = T.cos(halfAngle)
        self.w = c
        self.x = axis.x * s
        self.y = axis.y * s
        self.z = axis.z * s
    }
    
    public func angle() -> T {
        return T.acos(w) * 2
    }
    
    public func axis() -> Vector3<T> {
        let t1 = 1 - w * w
        
        if t1 <= 0 {
            return Vector3(0, 0, 1)
        }
        
        let t2 = 1 / T.sqrt(t1)
        
        return Vector3(
            x * t2,
            y * t2,
            z * t2
        )
    }

    public func roll() -> T {
        let a = 2 * (x * y + w * z)
        let b = w * w + x * x - y * y - z * z
        return T.atan2(a, b)
    }
    
    public func pitch() -> T {
        let a = 2 * (y * z + w * x)
        let b = w * w - x * x - y * y + z * z
        return T.atan2(a, b)
    }
    
    public func yaw() -> T {
        let a = -2 * (x * z - w * y)
        return T.asin(a)
    }
    
    public func eulerAngles() -> Vector3<T> {
        return Vector3(
            pitch(),
            yaw(),
            roll()
        )
    }
    
    public func matrix3() -> Matrix3<T> {
        return convert(self)
    }
    
    public func matrix4() -> Matrix4<T> {
        return convert(self)
    }
}

// MARK: - Conjugate

public func conjugate<T: RealArithmetic>(q: Quaternion<T>) -> Quaternion<T> {
    return Quaternion(q.w, -q.x, -q.y, -q.z)
}

// MARK: - Inverse

public func inverse<T: RealArithmetic>(q: Quaternion<T>) -> Quaternion<T> {
    return conjugate(q) / (q • q)
}

// MARK: - Dot Product

public func •<T: Arithmetic>(qa: Quaternion<T>, qb: Quaternion<T>) -> T {
    return dot(qa, qb)
}

public func dot<T: RealArithmetic>(lhs: Quaternion<T>, rhs: Quaternion<T>) -> T {
    let v = Vector4(
        lhs.x * rhs.x,
        lhs.y * rhs.y,
        lhs.z * rhs.z,
        lhs.w * rhs.w
    )
    return sum(v)
}

// MARK: - Multiplication

public func *<T: RealArithmetic>(lhs: Quaternion<T>, rhs: Quaternion<T>) -> Quaternion<T> {
    let w = lhs.w * rhs.w - lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z
    let x = lhs.w * rhs.x + lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y
    let y = lhs.w * rhs.y + lhs.y * rhs.w + lhs.z * rhs.x - lhs.x * rhs.z
    let z = lhs.w * rhs.z + lhs.z * rhs.w + lhs.x * rhs.y - lhs.y * rhs.x
    return Quaternion(w, x, y, z)
}

// MARK: - Scalar Multiplication

public func *<T: RealArithmetic>(lhs: Quaternion<T>, rhs: T) -> Quaternion<T> {
    return Quaternion(
        lhs.w * rhs,
        lhs.x * rhs,
        lhs.y * rhs,
        lhs.z * rhs
    )
}

// MARK: - Scalar Division

public func /<T: RealArithmetic>(lhs: Quaternion<T>, rhs: T) -> Quaternion<T> {
    return Quaternion(
        lhs.w / rhs,
        lhs.x / rhs,
        lhs.y / rhs,
        lhs.z / rhs
    )
}

// MARK: - Normalization

public func normalize<T: RealArithmetic>(q: Quaternion<T>) -> Quaternion<T> {
    let length = T.sqrt(q • q)
    if length <= 0 {
        return Quaternion()
    }
    let inverseLength = 1 / length
    return q * inverseLength
}

// MARK: - Matrix Conversion

public func convert<T: RealArithmetic>(q: Quaternion<T>) -> Matrix3<T> {
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
    
    return Matrix3(
        m0x, m0y, m0z,
        m1x, m1y, m1z,
        m2x, m2y, m2z
    )
}

public func convert<T: RealArithmetic>(q: Quaternion<T>) -> Matrix4<T> {
    return Matrix4(convert(q))
}

public func convert<T: RealArithmetic>(m: Matrix3<T>) -> Quaternion<T> {
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
    
    let max = T.sqrt(fMax + 1.0) * 0.5
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
