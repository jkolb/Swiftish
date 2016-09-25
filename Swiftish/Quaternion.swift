/*
 The MIT License (MIT)
 
 Copyright (c) 2016 Justin Kolb
 
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

public struct Quaternion<T: Vectorable> : Equatable, CustomStringConvertible {
    public let w: T
    public let xyz: Vector3<T>
    
    public init() {
        self.init(T.one, Vector3<T>())
    }
    
    public init(_ w: T, _ x: T, _ y: T, _ z: T) {
        self.init(w, Vector3<T>(x, y, z))
    }
    
    public init(_ w: T, _ xyz: Vector3<T>) {
        self.w = w
        self.xyz = xyz
    }
    
    public var components: [T] {
        return [w, xyz.x, xyz.y, xyz.z]
    }
    
    public subscript(index: Int) -> T {
        switch index {
        case 0:
            return w
        case 1:
            return xyz.x
        case 2:
            return xyz.y
        case 3:
            return xyz.z
        default:
            fatalError("Index out of range")
        }
    }
    
    public var description: String {
        return "{\(w), \(xyz)}"
    }

//    public init(eulerAngle: Vector3<T>) {
//        let halfEulerAngle = eulerAngle * 0.5
//        let c = cos(halfEulerAngle)
//        let s = sin(halfEulerAngle)
//        self.w = c.x * c.y * c.z + s.x * s.y * s.z
//        self.x = s.x * c.y * c.z - c.x * s.y * s.z
//        self.y = c.x * s.y * c.z + s.x * c.y * s.z
//        self.z = c.x * c.y * s.z - s.x * s.y * c.z
//    }
//    
//    public init(_ m: Matrix3<T>) {
//        let q = convert(m)
//        self.w = q.w
//        self.x = q.x
//        self.y = q.y
//        self.z = q.z
//    }
//    
//    public init(angle: T, axis: Vector3<T>) {
//        let halfAngle = angle * 0.5
//        let s = T.sin(halfAngle)
//        let c = T.cos(halfAngle)
//        self.w = c
//        self.x = axis.x * s
//        self.y = axis.y * s
//        self.z = axis.z * s
//    }
//    
//    public func angle() -> T {
//        return T.acos(w) * 2
//    }
//    
//    public func axis() -> Vector3<T> {
//        let t1 = 1 - w * w
//        
//        if t1 <= 0 {
//            return Vector3<T>(0, 0, 1)
//        }
//        
//        let t2 = 1 / T.sqrt(t1)
//        
//        return Vector3<T>(
//            x * t2,
//            y * t2,
//            z * t2
//        )
//    }
//    
//    public func roll() -> T {
//        let a = 2 * (x * y + w * z)
//        let b = w * w + x * x - y * y - z * z
//        return T.atan2(a, b)
//    }
//    
//    public func pitch() -> T {
//        let a = 2 * (y * z + w * x)
//        let b = w * w - x * x - y * y + z * z
//        return T.atan2(a, b)
//    }
//    
//    public func yaw() -> T {
//        let a = -2 * (x * z - w * y)
//        return T.asin(a)
//    }
//    
//    public func eulerAngles() -> Vector3<T> {
//        return Vector3<T>(
//            pitch(),
//            yaw(),
//            roll()
//        )
//    }
//    
//    public func matrix3() -> Matrix3<T> {
//        return convert(self)
//    }
//    
//    public func matrix4() -> Matrix4<T> {
//        return convert(self)
//    }
//    
//    public static func axis(axis: Vector3<T>, angle: Angle) -> Quaternion {
//        let halfAngle = angle * 0.5
//        return Quaternion(cos(halfAngle), sin(halfAngle) * axis)
//    }
//    
//    public var description: String {
//        return "{\(w), \(xyz)}"
//    }
//    
//    public var matrix: Matrix3x3 {
//        let v = xyz
//        let twoWV = 2.0 * (w * v)
//        let twoV2 = 2.0 * (v * v)
//        let twoXY = 2.0 * (v.x * v.y)
//        let twoXZ = 2.0 * (v.x * v.z)
//        let twoYZ = 2.0 * (v.y * v.z)
//        
//        let col0 = Vector3D(1.0 - twoV2.y - twoV2.z, twoXY + twoWV.z, twoXZ - twoWV.y)
//        let col1 = Vector3D(twoXY - twoWV.z, 1.0 - twoV2.x - twoV2.z, twoYZ + twoWV.x)
//        let col2 = Vector3D(twoXZ + twoWV.y, twoYZ - twoWV.x, 1.0 - twoV2.x - twoV2.y)
//        
//        return Matrix3x3(col0, col1, col2)
//    }
}

// MARK: - Equatable

public func ==<T: Vectorable>(va: Quaternion<T>, vb: Quaternion<T>) -> Bool {
    return va.w == vb.w && va.xyz == vb.xyz
}

// MARK: - Addition

public func +<T: Vectorable>(lhs: Quaternion<T>, rhs: Quaternion<T>) -> Quaternion<T> {
    return Quaternion<T>(
        lhs.w + rhs.w,
        lhs.xyz + rhs.xyz
    )
}

// MARK: - Subtraction

public func -<T: Vectorable>(lhs: Quaternion<T>, rhs: Quaternion<T>) -> Quaternion<T> {
    return Quaternion<T>(
        lhs.w - rhs.w,
        lhs.xyz - rhs.xyz
    )
}

// MARK: - Multiplication

public func *<T: Vectorable>(lhs: Quaternion<T>, rhs: Quaternion<T>) -> Quaternion<T> {
    let ps = lhs.w
    let pv = lhs.xyz
    let qs = rhs.w
    let qv = rhs.xyz
    let s = ps * qs - dot(pv, qv)
    let v = cross(pv, qv) + ps * qv + qs * pv
    return Quaternion<T>(s, v)
}

public func *<T: Vectorable>(lhs: T, rhs: Quaternion<T>) -> Quaternion<T> {
    return Quaternion<T>(
        lhs * rhs.w,
        lhs * rhs.xyz
    )
}

public func *<T: Vectorable>(lhs: Quaternion<T>, rhs: T) -> Quaternion<T> {
    return Quaternion<T>(
        lhs.w * rhs,
        lhs.xyz * rhs
    )
}

// MARK: - Division

public func /<T: FloatingPoint>(a: Quaternion<T>, b: T) -> Quaternion<T> {
    return Quaternion(
        a.w / b,
        a.xyz / b
    )
}

// MARK: - Rotation

public func *<T: Vectorable>(q: Quaternion<T>, r: Vector3<T>) -> Vector3<T> {
    let qXr = cross(q.xyz, r)
    let twoQ = T.two * q
    return r + twoQ.w * qXr + cross(twoQ.xyz, qXr)
}

public func *<T: Vectorable>(r: Vector3<T>, q: Quaternion<T>) -> Vector3<T> {
    let qXr = cross(q.xyz, r)
    let twoQ = T.two * q
    return r + twoQ.w * qXr + cross(twoQ.xyz, qXr)
}

// MARK: Conjugate

public func conjugate<T: SignedVectorable>(_ q: Quaternion<T>) -> Quaternion<T> {
    return Quaternion<T>(q.w, -q.xyz)
}

// MARK: Geometric

public func dot<T: Vectorable>(_ lhs: Quaternion<T>, _ rhs: Quaternion<T>) -> T {
    return lhs.w * rhs.w + dot(lhs.xyz, rhs.xyz)
}

public func length2<T: Vectorable>(_ q: Quaternion<T>) -> T {
    return q.w * q.w + sum(q.xyz * q.xyz)
}

public func length<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> T {
    return length2(q).squareRoot()
}

public func normalize<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> Quaternion<T> {
    return q * (T.one / length(q))
}

// MARK: - Inverse

public func inverse<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> Quaternion<T> {
    return conjugate(q) / dot(q, q)
}

// MARK: - Matrix Conversion

//public func convert<T: RealArithmetic>(_ q: Quaternion<T>) -> Matrix3<T> {
//    let qxx = q.x * q.x
//    let qyy = q.y * q.y
//    let qzz = q.z * q.z
//    let qxz = q.x * q.z
//    let qxy = q.x * q.y
//    let qyz = q.y * q.z
//    let qwx = q.w * q.x
//    let qwy = q.w * q.y
//    let qwz = q.w * q.z
//    
//    let m0x = 1 - 2 * (qyy +  qzz)
//    let m0y = 2 * (qxy + qwz)
//    let m0z = 2 * (qxz - qwy)
//    
//    let m1x = 2 * (qxy - qwz)
//    let m1y = 1 - 2 * (qxx +  qzz)
//    let m1z = 2 * (qyz + qwx)
//    
//    let m2x = 2 * (qxz + qwy)
//    let m2y = 2 * (qyz - qwx)
//    let m2z = 1 - 2 * (qxx +  qyy)
//    
//    return Matrix3(
//        m0x, m0y, m0z,
//        m1x, m1y, m1z,
//        m2x, m2y, m2z
//    )
//}
//
//public func convert<T: RealArithmetic>(_ q: Quaternion<T>) -> Matrix4<T> {
//    return Matrix4(convert(q))
//}
//
//public func convert<T: RealArithmetic>(_ m: Matrix3<T>) -> Quaternion<T> {
//    let m00 = m[0].x
//    let m10 = m[1].x
//    let m20 = m[2].x
//    let m01 = m[0].y
//    let m11 = m[1].y
//    let m21 = m[2].y
//    let m02 = m[0].z
//    let m12 = m[1].z
//    let m22 = m[2].z
//    
//    let fX = m00 - m11 - m22
//    let fY = m11 - m00 - m22
//    let fZ = m22 - m00 - m11
//    let fW = m00 + m11 + m22
//    
//    var index = 0
//    var fMax = fW
//    
//    if fX > fMax {
//        index = 1
//        fMax = fX
//    }
//    
//    if fY > fMax {
//        index = 2
//        fMax = fY
//    }
//    
//    if fZ > fMax {
//        index = 3
//        fMax = fZ
//    }
//    
//    let max = T.sqrt(fMax + 1.0) * 0.5
//    let mul = 0.25 / max
//    
//    switch index {
//    case 0:
//        let w = max
//        let x = (m12 - m21) * mul
//        let y = (m20 - m02) * mul
//        let z = (m01 - m10) * mul
//        return Quaternion(w, x, y, z)
//    case 1:
//        let w = (m12 - m21) * mul
//        let x = max
//        let y = (m01 + m10) * mul
//        let z = (m20 + m02) * mul
//        return Quaternion(w, x, y, z)
//    case 2:
//        let w = (m20 - m02) * mul
//        let x = (m01 + m10) * mul
//        let y = max
//        let z = (m12 + m21) * mul
//        return Quaternion(w, x, y, z)
//    case 3:
//        let w = (m01 - m10) * mul
//        let x = (m20 + m02) * mul
//        let y = (m12 + m21) * mul
//        let z = max
//        return Quaternion(w, x, y, z)
//    default:
//        preconditionFailure("Should never happen")
//    }
//}
