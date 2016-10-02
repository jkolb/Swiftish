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

/*
 fovy	Specifies the field of view angle (in radians) in the y direction.
 aspect	Indicates the aspect ratio. This value determines the field of view in the x direction and is the ratio of x (width) to y (height). x/y
 zNear	Specifies the distance from the viewer to the closest clipping plane. This value must be positive. zNear must never be set to 0.
 zFar	Specifies the distance from the viewer to the farthest clipping plane. This value must be positive.
 
 Similar to gluPerspective: https://www.opengl.org/sdk/docs/man2/xhtml/gluPerspective.xml
 
 Given: f = cotangent(fovy / 2)
 
 (     f                                  )
 |  ------   0       0            0       |
 |  aspect                                |
 |                                        |
 |                                        |
 |     0     f       0            0       |
 |                                        |
 |                                        |
 |               zFar+zNear  2*zFar*zNear |
 |     0     0   ----------  ------------ |
 |               zNear-zFar   zNear-zFar  |
 |                                        |
 |                                        |
 |     0     0      -1            0       |
 (                                        )
 */
public struct PerspectiveProjection<T: FloatingPointVectorable> : Equatable {
    public var fovx: Angle<T> {
        get {
            return T.two * atan(tan(fovy / T.two) * aspectRatio)
        }
        set {
            fovy = T.two * atan(tan(newValue / T.two) * inverseAspectRatio)
        }
    }
    public var fovy: Angle<T>
    public var aspectRatio: T
    public var inverseAspectRatio: T {
        get {
            return T.one / aspectRatio;
        }
        set {
            aspectRatio = T.one / newValue
        }
    }
    public var zNear: T
    public var zFar: T
    
    public init(fovx: Angle<T>, aspectRatio: T, zNear: T, zFar: T) {
        self.init(
            fovy: T.two * atan(tan(fovx / T.two) * (T.one / aspectRatio)),
            aspectRatio: aspectRatio,
            zNear: zNear,
            zFar: zFar
        )
    }
    
    public init(fovy: Angle<T>, aspectRatio: T, zNear: T, zFar: T) {
        precondition(fovy > Angle<T>(radians: T.zero))
        precondition(fovy <= Angle<T>(radians: T.pi - T.epsilon))
        precondition(aspectRatio > T.zero)
        precondition(zNear > T.zero)
        precondition(zFar > zNear)
        self.fovy = fovy
        self.aspectRatio = aspectRatio
        self.zNear = zNear
        self.zFar = zFar
    }
    
    public var matrix: Matrix4x4<T> {
        let x = fovy / T.two
        let s = sin(x)
        let c = cos(x)
        
        // cotangent(x) = cos(x) / sin(x)
        let f = c.radians / s.radians
        
        let col0 = Vector4<T>(
            f / aspectRatio,
            T.zero,
            T.zero,
            T.zero
        )
        let col1 = Vector4<T>(
            T.zero,
            f,
            T.zero,
            T.zero
        )
        let col2 = Vector4<T>(
            T.zero,
            T.zero,
            (zFar + zNear) / (zNear - zFar),
            -T.one
        )
        let col3 = Vector4<T>(
            T.zero,
            T.zero,
            (T.two * zFar * zNear) / (zNear - zFar),
            T.zero
        )
        
        return Matrix4x4(col0, col1, col2, col3)
    }
    
    public var frustum: Frustum<T> {
        // Pointing down the -Z axis, camera frustum in world space using a right handed coordinate system
        let halfFOVY = fovy / T.two
        let halfFOVX = fovx / T.two
        let sy = sin(halfFOVY).radians
        let cy = cos(halfFOVY).radians
        let sx = sin(halfFOVX).radians
        let cx = cos(halfFOVX).radians
        
        return Frustum<T>(
            top:  Plane<T>(normal: Vector3<T>(T.zero, -cy, -sy), distance: T.zero),
            bottom: Plane<T>(normal: Vector3<T>(T.zero, +cy, -sy), distance: T.zero),
            left: Plane<T>(normal: Vector3<T>(+cx, T.zero, -sx), distance: T.zero),
            right: Plane<T>(normal: Vector3<T>(-cx, T.zero, -sx), distance: T.zero),
            near: Plane<T>(normal: Vector3<T>(T.zero, T.zero, -T.one), distance: +zNear),
            far: Plane<T>(normal: Vector3<T>(T.zero, T.zero, +T.one), distance: -zFar)
        )
    }
}

public func ==<T: FloatingPointVectorable>(lhs: PerspectiveProjection<T>, rhs: PerspectiveProjection<T>) -> Bool {
    return lhs.fovy == rhs.fovy && lhs.aspectRatio == rhs.aspectRatio && lhs.zNear == rhs.zNear && lhs.zFar == rhs.zFar
}
