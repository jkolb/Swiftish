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

public struct Transform3<T: FloatingPointVectorable> : Equatable, CustomStringConvertible {
    public var t: Vector3<T>
    public var r: Quaternion<T>
    public var s: Vector3<T>
    
    public init(t: Vector3<T> = Vector3<T>(), r: Quaternion<T> = Quaternion<T>(), s: Vector3<T> = Vector3<T>(T.one)) {
        self.t = t
        self.r = r
        self.s = s
    }
    
    public var isIdentity: Bool {
        return !hasTranslation && !hasRotation && !hasScale
    }
    
    public var hasScale: Bool {
        return s != Vector3<T>(T.one)
    }
    
    public var hasRotation: Bool {
        return r != Quaternion<T>()
    }
    
    public var hasTranslation: Bool {
        return t != Vector3<T>()
    }
    
    public var description: String {
        return "{\(t), \(r), \(s)}"
    }
    
    public var inverse: Transform3<T> {
        return Transform3<T>(t: -t, r: conjugate(r), s: T.one / s)
    }
    
    public var matrix: Matrix4x4<T> {
        let rs: Matrix3x3<T>
        
        if hasRotation && hasScale {
            rs = r.matrix * Matrix3x3<T>(s)
        }
        else if hasRotation {
            rs = r.matrix
        }
        else if hasScale {
            rs = Matrix3x3<T>(s)
        }
        else {
            rs = Matrix3x3<T>()
        }
        
        return Matrix4x4<T>(
            Vector4<T>(rs[0]),
            Vector4<T>(rs[1]),
            Vector4<T>(rs[2]),
            Vector4<T>(t, T.one)
        )
    }
    
    public var inverseMatrix: Matrix4x4<T> {
        let sri: Matrix3x3<T>
        
        if hasRotation && hasScale {
            sri = Matrix3x3<T>(T.one / s) * r.matrix.transpose
        }
        else if hasRotation {
            sri = r.matrix.transpose
        }
        else if hasScale {
            sri = Matrix3x3<T>(T.one / s)
        }
        else {
            sri = Matrix3x3<T>()
        }
        
        let ti: Vector3<T>
        
        if hasTranslation {
            ti = sri * -t
        }
        else {
            ti = Vector3<T>()
        }

        return Matrix4x4<T>(
            Vector4<T>(sri[0]),
            Vector4<T>(sri[1]),
            Vector4<T>(sri[2]),
            Vector4<T>(ti, T.one)
        )
    }
    
    public func applyTo(_ v: Vector3<T>) -> Vector3<T> {
        return v * s * r + t
    }
    
    public func applyTo(_ b: Bounds3<T>) -> Bounds3<T> {
        return Bounds3<T>(containingPoints: b.corners.map({ applyTo($0) }))
    }
    
//    public func applyTo(p: Plane) -> Plane {
//        let pointOnPlane = p.normal * p.distanceToOrigin
//        let transformedNormal = p.normal * rotation
//        let transformedPoint = applyTo(pointOnPlane)
//        let transformedDistance = dot(transformedNormal, transformedPoint)
//        return Plane(normal: transformedNormal, distanceToOrigin: transformedDistance)
//    }
    
//    public func applyTo(f: Frustum) -> Frustum {
//        return Frustum(
//            top: applyTo(f.top),
//            bottom: applyTo(f.bottom),
//            right: applyTo(f.right),
//            left: applyTo(f.left),
//            near: applyTo(f.near),
//            far: applyTo(f.far)
//        )
//    }
    
//    public func applyTo(s: Sphere) -> Sphere {
//        return Sphere(
//            center: s.center + translation,
//            radius: s.radius * scale.maximum
//        )
//    }
    
//    public func applyTo(r: Ray3D) -> Ray3D {
//        return Ray3D(origin: applyTo(r.origin), direction: r.direction * rotation)
//    }
}

public func ==<T: FloatingPointVectorable>(a: Transform3<T>, b: Transform3<T>) -> Bool {
    return a.t == b.t && a.r == b.r && a.s == b.s
}

public func +<T: FloatingPointVectorable>(a: Transform3<T>, b: Transform3<T>) -> Transform3<T> {
    return Transform3<T>(
        t: a.r * b.t * a.s + a.t,
        r: a.r * b.r,
        s: a.s * b.s
    )
}
