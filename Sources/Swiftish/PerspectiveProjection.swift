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
public struct PerspectiveProjection<T: Vectorable> : Hashable {
    public var fovx: T {
        get {
            return 2 * T.atan(T.tan(fovy / 2) * aspectRatio)
        }
        set {
            fovy = 2 * T.atan(T.tan(newValue / 2) * inverseAspectRatio)
        }
    }
    public var fovy: T
    public var aspectRatio: T
    public var inverseAspectRatio: T {
        get {
            return 1 / aspectRatio;
        }
        set {
            aspectRatio = 1 / newValue
        }
    }
    public var zNear: T
    public var zFar: T
    
    public init(fovx: T, aspectRatio: T, zNear: T, zFar: T) {
        precondition(fovx > 0)
        precondition(fovx < T.pi)
        self.init(
            fovy: 2 * T.atan(T.tan(fovx / 2) * (1 / aspectRatio)),
            aspectRatio: aspectRatio,
            zNear: zNear,
            zFar: zFar
        )
    }
    
    public init(fovy: T, aspectRatio: T, zNear: T, zFar: T) {
        precondition(fovy > 0)
        precondition(fovy < T.pi)
        precondition(aspectRatio > 0)
        precondition(zNear > 0)
        precondition(zFar > zNear)
        self.fovy = fovy
        self.aspectRatio = aspectRatio
        self.zNear = zNear
        self.zFar = zFar
    }
    
    public var matrix: Matrix4x4<T> {
        let x = fovy / 2
        let s = T.sin(x)
        let c = T.cos(x)
        
        // cotangent(x) = cos(x) / sin(x)
        let f = c / s
        
        let col0 = Vector4<T>(
            f / aspectRatio,
            0,
            0,
            0
        )
        let col1 = Vector4<T>(
            0,
            f,
            0,
            0
        )
        let col2 = Vector4<T>(
            0,
            0,
            (zFar + zNear) / (zNear - zFar),
            -1
        )
        let col3 = Vector4<T>(
            0,
            0,
            (2 * zFar * zNear) / (zNear - zFar),
            0
        )
        
        return Matrix4x4(col0, col1, col2, col3)
    }
    
    public var frustum: Frustum<T> {
        return Frustum<T>(fovx: fovx, fovy: fovy, zNear: zNear, zFar: zFar)
    }
}
