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

public struct Ray3<T: Vectorable> : Hashable, CustomStringConvertible {
    public var origin: Vector3<T>
    public var direction: Vector3<T>
    
    public init(origin: Vector3<T>, direction: Vector3<T>) {
        self.origin = origin
        self.direction = direction;
    }
    
    public var description: String {
        return "{\(origin), \(direction)}"
    }

    public static func distance<T>(_ r: Ray3<T>, _ t: Triangle3<T>) -> T {
        let n = t.normal
        let qp = -r.direction
        let d = Vector3<T>.dot(qp, n)
        let ap = r.origin - t.a
        let t = Vector3<T>.dot(ap, n)
        let ood = t / d
        
        return ood
    }

    public func intersects(_ bounds: Bounds3<T>, epsilon: T) -> Bool {
        var tmin: T = 0
        var tmax = T.greatestFiniteMagnitude
        let amin = bounds.minimum
        let amax = bounds.maximum
        
        for i in 0..<3 {
            let oi = origin[i]
            let di = direction[i]
            
            if abs(di) < epsilon {
                if oi < amin[i] || oi > amax[i] {
                    return false
                }
            }
            else {
                let ood = 1 / di
                var t1 = (amin[i] - oi) * ood
                var t2 = (amax[i] - oi) * ood
                
                if t1 > t2 {
                    swap(&t1, &t2)
                }
                
                tmin = max(tmin, t1)
                tmax = min(tmax, t2)
                
                if tmin > tmax {
                    return false
                }
            }
        }
        
        return true
    }
    
    public func intersects(_ triangle: Triangle3<T>) -> Bool {
        let ab = triangle.b - triangle.a
        let ac = triangle.c - triangle.a
        let qp = -direction
        
        let n = Vector3<T>.cross(ab, ac)
        
        let d = Vector3<T>.dot(qp, n)
        
        if d <= 0 {
            return false
        }
        
        let ap = origin - triangle.a
        let t = Vector3<T>.dot(ap, n)
        
        if t < 0 {
            return false
        }
        
        let e = Vector3<T>.cross(qp, ap)
        let v = Vector3<T>.dot(ac, e)
        
        if v < 0 || v > d {
            return false
        }
        
        let w = -Vector3<T>.dot(ab, e)
        
        if w < 0 || v + w > d {
            return false
        }
        
        return true
    }
    
    public func transform(_ t: Transform3<T>) -> Ray3<T> {
        return Ray3<T>(origin: origin.transform(t), direction: direction * t.rotation)
    }
}
