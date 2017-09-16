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

public struct Ray3<T: Vectorable> : Equatable, CustomStringConvertible {
    public var origin: Vector3<T>
    public var direction: Vector3<T>
    
    public init(origin: Vector3<T>, direction: Vector3<T>) {
        self.origin = origin
        self.direction = direction;
    }
    
    public var description: String {
        return "{\(origin), \(direction)}"
    }
}

public func ==<T: Vectorable>(a: Ray3<T>, b: Ray3<T>) -> Bool {
    return a.origin == b.origin && a.direction == b.direction
}

public func distance<T: FloatingPointVectorable>(_ r: Ray3<T>, _ t: Triangle3<T>) -> T {
    let n = normalOf(t)
    let qp = -r.direction
    let d = dot(qp, n)
    let ap = r.origin - t.a
    let t = dot(ap, n)
    let ood = t / d
    
    return ood
}
