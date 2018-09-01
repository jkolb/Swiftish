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

public struct Transform3<T: Vectorable> : Hashable, CustomStringConvertible {
    public var translation: Vector3<T>
    public var rotation: Quaternion<T>
    public var scale: Vector3<T>
    
    public init(translation: Vector3<T> = Vector3<T>(), rotation: Quaternion<T> = Quaternion<T>(), scale: Vector3<T> = Vector3<T>(1)) {
        self.translation = translation
        self.rotation = rotation
        self.scale = scale
    }
    
    public var isIdentity: Bool {
        return !hasTranslation && !hasRotation && !hasScale
    }
    
    public var hasScale: Bool {
        return scale != Vector3<T>(1)
    }
    
    public var hasRotation: Bool {
        return rotation != Quaternion<T>()
    }
    
    public var hasTranslation: Bool {
        return translation != Vector3<T>()
    }
    
    public var description: String {
        return "{\(translation), \(rotation), \(scale)}"
    }
    
    public var inverse: Transform3<T> {
        return Transform3<T>(translation: -translation, rotation: Quaternion<T>.conjugate(rotation), scale: 1 / scale)
    }
    
    public var matrix: Matrix4x4<T> {
        let rs = rotation.matrix * Matrix3x3<T>(scale)
        
        return Matrix4x4<T>(
            Vector4<T>(rs[0]),
            Vector4<T>(rs[1]),
            Vector4<T>(rs[2]),
            Vector4<T>(translation, 1)
        )
    }
    
    public var inverseMatrix: Matrix4x4<T> {
        let sri = Matrix3x3<T>(1 / scale) * rotation.matrix.transpose
        let ti = sri * -translation

        return Matrix4x4<T>(
            Vector4<T>(sri[0]),
            Vector4<T>(sri[1]),
            Vector4<T>(sri[2]),
            Vector4<T>(ti, 1)
        )
    }

    public static func +(a: Transform3<T>, b: Transform3<T>) -> Transform3<T> {
        return Transform3<T>(
            translation: a.rotation * b.translation * a.scale + a.translation,
            rotation: a.rotation * b.rotation,
            scale: a.scale * b.scale
        )
    }
}
