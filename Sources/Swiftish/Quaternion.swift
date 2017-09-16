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

public struct Quaternion<T: Vectorable> : Equatable, CustomStringConvertible {
    public var w: T
    public var xyz: Vector3<T>
    
    public var x: T {
        get {
            return xyz.x
        }
        
        set {
            xyz.x = newValue
        }
    }
    
    public var y: T {
        get {
            return xyz.y
        }
        
        set {
            xyz.y = newValue
        }
    }
    
    public var z: T {
        get {
            return xyz.z
        }
        
        set {
            xyz.z = newValue
        }
    }

    public init() {
        self.init(1, Vector3<T>())
    }
    
    public init(_ w: T, _ x: T, _ y: T, _ z: T) {
        self.init(w, Vector3<T>(x, y, z))
    }

    public init(_ w: T, _ xyz: Vector3<T>) {
        self.w = w
        self.xyz = xyz
    }
    
    public var components: [T] {
        get {
            return [w, xyz.x, xyz.y, xyz.z]
        }
        
        set {
            precondition(newValue.count == 4)
            w = newValue[0]
            xyz = Vector3<T>(newValue[1], newValue[2], newValue[3])
        }
    }
    
    public subscript(index: Int) -> T {
        get {
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
        
        set {
            switch index {
            case 0:
                w = newValue
            case 1:
                xyz.x = newValue
            case 2:
                xyz.y = newValue
            case 3:
                xyz.z = newValue
            default:
                fatalError("Index out of range")
            }
        }
    }
    
    public var description: String {
        return "{\(w), \(xyz)}"
    }
    
    public var matrix: Matrix3x3<T> {
        let v: Vector3<T> = xyz
        let twoWV = 2 * (w * v)
        let twoV2 = 2 * (v * v)
        let twoXY = 2 * (v.x * v.y)
        let twoXZ = 2 * (v.x * v.z)
        let twoYZ = 2 * (v.y * v.z)
        
        let col0 = Vector3<T>(1 - twoV2.y - twoV2.z, twoXY + twoWV.z, twoXZ - twoWV.y)
        let col1 = Vector3<T>(twoXY - twoWV.z, 1 - twoV2.x - twoV2.z, twoYZ + twoWV.x)
        let col2 = Vector3<T>(twoXZ + twoWV.y, twoYZ - twoWV.x, 1 - twoV2.x - twoV2.y)
        
        return Matrix3x3<T>(col0, col1, col2)
    }

    // MARK: - Equatable

    public static func ==(a: Quaternion<T>, b: Quaternion<T>) -> Bool {
        return a.w == b.w && a.xyz == b.xyz
    }

    // MARK: - Addition

    public static func +(a: Quaternion<T>, b: Quaternion<T>) -> Quaternion<T> {
        let w: T = a.w + b.w
        let xyz: Vector3<T> = a.xyz + b.xyz
        
        return Quaternion<T>(w, xyz)
    }

    // MARK: - Subtraction

    public static func -(a: Quaternion<T>, b: Quaternion<T>) -> Quaternion<T> {
        let w: T = a.w - b.w
        let xyz: Vector3<T> = a.xyz - b.xyz
        
        return Quaternion<T>(w, xyz)
    }

    // MARK: - Multiplication

    public static func *(a: Quaternion<T>, b: Quaternion<T>) -> Quaternion<T> {
        let ps: T = a.w
        let pv: Vector3<T> = a.xyz
        let qs: T = b.w
        let qv: Vector3<T> = b.xyz
        let s: T = ps * qs - dot(pv, qv)
        let v: Vector3<T> = cross(pv, qv) + ps * qv + qs * pv
        
        return Quaternion<T>(s, v)
    }

    public static func *(a: T, b: Quaternion<T>) -> Quaternion<T> {
        let w: T = a * b.w
        let xyz: Vector3<T> = a * b.xyz
        
        return Quaternion<T>(w, xyz)
    }

    public static func *(a: Quaternion<T>, b: T) -> Quaternion<T> {
        let w: T = a.w * b
        let xyz: Vector3<T> = a.xyz * b
        
        return Quaternion<T>(w, xyz)
    }

    // MARK: - Division

    public static func /(a: Quaternion<T>, b: T) -> Quaternion<T> {
        let w: T = a.w / b
        let xyz: Vector3<T> = a.xyz / b
        
        return Quaternion<T>(w, xyz)
    }

    // MARK: - Rotation

    public static func *(q: Quaternion<T>, r: Vector3<T>) -> Vector3<T> {
        let qXr: Vector3<T> = cross(q.xyz, r)
        let twoQ: Quaternion<T> = 2 * q
        
        return r + twoQ.w * qXr + cross(twoQ.xyz, qXr)
    }

    public static func *(r: Vector3<T>, q: Quaternion<T>) -> Vector3<T> {
        let qXr: Vector3<T> = cross(q.xyz, r)
        let twoQ: Quaternion<T> = 2 * q
        
        return r + twoQ.w * qXr + cross(twoQ.xyz, qXr)
    }
}

// MARK: Conjugate

public func conjugate<T: SignedVectorable>(_ q: Quaternion<T>) -> Quaternion<T> {
    return Quaternion<T>(q.w, -q.xyz)
}

// MARK: Geometric

public func dot<T>(_ a: Quaternion<T>, _ b: Quaternion<T>) -> T {
    return a.w * b.w + dot(a.xyz, b.xyz)
}

public func length2<T>(_ q: Quaternion<T>) -> T {
    return q.w * q.w + sum(q.xyz * q.xyz)
}

public func length<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> T {
    return length2(q).squareRoot()
}

public func normalize<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> Quaternion<T> {
    return q * (1 / length(q))
}

// MARK: - Inverse

public func inverse<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> Quaternion<T> {
    return conjugate(q) / dot(q, q)
}

// MARK: - Conversion

public func quat<T: FloatingPointVectorable>(_ m: Matrix3x3<T>) -> Quaternion<T> {
    let m00: T = m[0].x
    let m10: T = m[1].x
    let m20: T = m[2].x
    let m01: T = m[0].y
    let m11: T = m[1].y
    let m21: T = m[2].y
    let m02: T = m[0].z
    let m12: T = m[1].z
    let m22: T = m[2].z
    
    let fX: T = m00 - m11 - m22
    let fY: T = m11 - m00 - m22
    let fZ: T = m22 - m00 - m11
    let fW: T = m00 + m11 + m22
    
    var index = 0
    var fMax: T = fW
    
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
    
    let oneQuarter: T = 1 / (2 * 2)
    let max = (fMax + 1).squareRoot() / 2
    let mul = oneQuarter / max
    
    switch index {
    case 0:
        let w: T = max
        let x: T = (m12 - m21) * mul
        let y: T = (m20 - m02) * mul
        let z: T = (m01 - m10) * mul
        
        return Quaternion(w, x, y, z)
    case 1:
        let w: T = (m12 - m21) * mul
        let x: T = max
        let y: T = (m01 + m10) * mul
        let z: T = (m20 + m02) * mul
        
        return Quaternion(w, x, y, z)
    case 2:
        let w: T = (m20 - m02) * mul
        let x: T = (m01 + m10) * mul
        let y: T = max
        let z: T = (m12 + m21) * mul
        
        return Quaternion(w, x, y, z)
    case 3:
        let w: T = (m01 - m10) * mul
        let x: T = (m20 + m02) * mul
        let y: T = (m12 + m21) * mul
        let z: T = max
        
        return Quaternion(w, x, y, z)
    default:
        preconditionFailure("Should never happen")
    }
}

public func angleOf<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> Angle<T> {
    return Angle<T>(radians: q.w.arccosine() * 2)
}

public func axisOf<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> Vector3<T> {
    let t1 = 1 - q.w * q.w
    
    if t1 <= 0 {
        return Vector3<T>(0, 0, 0)
    }
    
    let t2 = 1 / t1.squareRoot()
    
    return Vector3<T>(
        q.x * t2,
        q.y * t2,
        q.z * t2
    )
}

public func quat<T>(axis: Vector3<T>, angle: Angle<T>) -> Quaternion<T> {
    let halfAngle = angle / 2
    
    return Quaternion<T>(cos(halfAngle).radians, sin(halfAngle).radians * axis)
}

public func rollOf<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> Angle<T> {
    let a: T = 2 * (q.x * q.y + q.w * q.z)
    let w2: T = q.w * q.w
    let x2: T = q.x * q.x
    let y2: T = q.y * q.y
    let z2: T = q.z * q.z
    let u: T = w2 + x2
    let v: T = y2 - z2
    let b: T = u - v
    
    return Angle<T>(radians: a.arctangent2(b))
}

public func pitchOf<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> Angle<T> {
    let a: T = 2 * (q.y * q.z + q.w * q.x)
    let w2: T = q.w * q.w
    let x2: T = q.x * q.x
    let y2: T = q.y * q.y
    let z2: T = q.z * q.z
    let u: T = w2 - x2
    let v: T = y2 + z2
    let b: T = u - v
    
    return Angle<T>(radians: a.arctangent2(b))
}

public func yawOf<T: FloatingPointVectorable>(_ q: Quaternion<T>) -> Angle<T> {
    let a = -2 * (q.x * q.z - q.w * q.y)
    
    return Angle<T>(radians: a.arcsine())
}

public func rotation<T>(pitch: Angle<T>, yaw: Angle<T>, roll: Angle<T>) -> Quaternion<T> {
    let angle = Vector3<T>(pitch.radians, yaw.radians, roll.radians)
    let halfAngle: Vector3<T> = angle / 2
    let c = cos(halfAngle)
    let s = sin(halfAngle)
    let w: T = c.x * c.y * c.z + s.x * s.y * s.z
    let x: T = s.x * c.y * c.z - c.x * s.y * s.z
    let y: T = c.x * s.y * c.z + s.x * c.y * s.z
    let z: T = c.x * c.y * s.z - s.x * s.y * c.z
    
    return Quaternion<T>(w, x, y, z)
}

public func rotation<T>(angle: Angle<T>, axis: Vector3<T>) -> Quaternion<T> {
    let halfAngle = angle / 2
    let s = sin(halfAngle).radians
    let c = cos(halfAngle).radians
    let w: T = c
    let x: T = axis.x * s
    let y: T = axis.y * s
    let z: T = axis.z * s
    
    return Quaternion<T>(w, x, y, z)
}
