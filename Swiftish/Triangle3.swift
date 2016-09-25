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

public struct Triangle3<T: Vectorable> : CustomStringConvertible {
    public var a: Vector3<T>
    public var b: Vector3<T>
    public var c: Vector3<T>
    
    public init(_ a: Vector3<T>, _ b: Vector3<T>, _ c: Vector3<T>) {
        self.a = a
        self.b = b
        self.c = c
    }
    
    public var points: [Vector3<T>] {
        get {
            return [a, b, c]
        }
        
        set {
            precondition(newValue.count == 3)
            a = newValue[0]
            b = newValue[1]
            c = newValue[2]
        }
    }
    
    public var description: String {
        return "{\n\t\(a),\n\t\(b),\n\t\(c)}"
    }
}

public func normalOf<T: FloatingPointVectorable>(_ t: Triangle3<T>) -> Vector3<T> {
    return normalize(cross(t.b - t.a, t.c - t.a))
}

public func boundsOf<T: SignedVectorable>(_ t: Triangle3<T>) -> Bounds3<T> {
    return Bounds3<T>(containingPoints: t.points)
}

public func planeOf<T: FloatingPointVectorable>(_ t: Triangle3<T>) -> Plane<T> {
    let normal: Vector3<T> = normalOf(t)
    let distance: T = dot(normal, t.a)
    
    return Plane<T>(normal: normal, distance: distance)
}
