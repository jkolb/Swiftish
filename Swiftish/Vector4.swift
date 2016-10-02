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

public struct Vector4<T: Vectorable> : Equatable, CustomStringConvertible {
    public var x: T
    public var y: T
    public var z: T
    public var w: T
    
    public init() {
        self.init(T.zero, T.zero, T.zero, T.zero)
    }
    
    public init(_ v: T) {
        self.init(v, v, v, v)
    }
    
    public init(_ v: Vector3<T>, _ c: T = T.zero) {
        self.init(v.x, v.y, v.z, c)
    }
    
    public init(_ x: T, _ y: T, _ z: T, _ w: T) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public var components: [T] {
        get {
            return [x, y, z, w]
        }
        
        set {
            precondition(newValue.count == 4)
            x = newValue[0]
            y = newValue[1]
            z = newValue[2]
            w = newValue[3]
        }
    }
    
    public subscript(index: Int) -> T {
        get {
            switch index {
            case 0:
                return x
            case 1:
                return y
            case 2:
                return z
            case 3:
                return w
            default:
                fatalError("Index out of range")
            }
        }
        
        set {
            switch index {
            case 0:
                x = newValue
            case 1:
                y = newValue
            case 2:
                z = newValue
            case 3:
                w = newValue
            default:
                fatalError("Index out of range")
            }
        }
    }
    
    public var minimum: T {
        return min(min(min(x, y), z), w)
    }
    
    public var maximum: T {
        return min(max(max(x, y), z), w)
    }

    public var description: String {
        return "{\(x), \(y), \(z), \(w)}"
    }
}

// MARK: - Equatable

public func ==<T: Vectorable>(a: Vector4<T>, b: Vector4<T>) -> Bool {
    return a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w
}

// MARK: Approximately Equal

public func approx<T: FloatingPointVectorable>(_ a: Vector4<T>, _ b: Vector4<T>, epsilon: T = T.epsilon) -> Bool {
    let delta: Vector4<T> = b - a
    let magnitude: Vector4<T> = abs(delta)
    
    return magnitude.x <= epsilon && magnitude.y <= epsilon && magnitude.z <= epsilon && magnitude.w <= epsilon
}

// MARK: Absolute Value

public func abs<T: SignedVectorable>(_ a: Vector4<T>) -> Vector4<T> {
    let x: T = abs(a.x)
    let y: T = abs(a.y)
    let z: T = abs(a.z)
    let w: T = abs(a.w)
    
    return Vector4<T>(x, y, z, w)
}

// MARK: - Addition

public func +<T: Vectorable>(a: Vector4<T>, b: T) -> Vector4<T> {
    let x: T = a.x + b
    let y: T = a.y + b
    let z: T = a.z + b
    let w: T = a.w + b
    
    return Vector4<T>(x, y, z, w)
}

public func +<T: Vectorable>(a: T, b: Vector4<T>) -> Vector4<T> {
    let x: T = a + b.x
    let y: T = a + b.y
    let z: T = a + b.z
    let w: T = a + b.w
    
    return Vector4<T>(x, y, z, w)
}

public func +<T: Vectorable>(a: Vector4<T>, b: Vector4<T>) -> Vector4<T> {
    let x: T = a.x + b.x
    let y: T = a.y + b.y
    let z: T = a.z + b.z
    let w: T = a.w + b.w
    
    return Vector4<T>(x, y, z, w)
}

// MARK: - Subtraction

public func -<T: Vectorable>(a: Vector4<T>, b: T) -> Vector4<T> {
    let x: T = a.x - b
    let y: T = a.y - b
    let z: T = a.z - b
    let w: T = a.w - b
    
    return Vector4<T>(x, y, z, w)
}

public func -<T: Vectorable>(a: T, b: Vector4<T>) -> Vector4<T> {
    let x: T = a - b.x
    let y: T = a - b.y
    let z: T = a - b.z
    let w: T = a - b.w
    
    return Vector4<T>(x, y, z, w)
}

public func -<T: Vectorable>(a: Vector4<T>, b: Vector4<T>) -> Vector4<T> {
    let x: T = a.x - b.x
    let y: T = a.y - b.y
    let z: T = a.z - b.z
    let w: T = a.w - b.w
    
    return Vector4<T>(x, y, z, w)
}

// MARK: - Multiplication

public func *<T: Vectorable>(a: Vector4<T>, b: T) -> Vector4<T> {
    return Vector4<T>(
        a.x * b,
        a.y * b,
        a.z * b,
        a.w * b
    )
}

public func *<T: Vectorable>(a: T, b: Vector4<T>) -> Vector4<T> {
    let x: T = a * b.x
    let y: T = a * b.y
    let z: T = a * b.z
    let w: T = a * b.w
    
    return Vector4<T>(x, y, z, w)
}

public func *<T: Vectorable>(a: Vector4<T>, b: Vector4<T>) -> Vector4<T> {
    let x: T = a.x * b.x
    let y: T = a.y * b.y
    let z: T = a.z * b.z
    let w: T = a.w * b.w
    
    return Vector4<T>(x, y, z, w)
}

// MARK: - Division

public func /<T: Vectorable>(a: Vector4<T>, b: T) -> Vector4<T> {
    let x: T = a.x / b
    let y: T = a.y / b
    let z: T = a.z / b
    let w: T = a.w / b
    
    return Vector4<T>(x, y, z, w)
}

public func /<T: Vectorable>(a: T, b: Vector4<T>) -> Vector4<T> {
    let x: T = a / b.x
    let y: T = a / b.y
    let z: T = a / b.z
    let w: T = a / b.w
    
    return Vector4<T>(x, y, z, w)
}

public func /<T: Vectorable>(a: Vector4<T>, b: Vector4<T>) -> Vector4<T> {
    let x: T = a.x / b.x
    let y: T = a.y / b.y
    let z: T = a.z / b.z
    let w: T = a.w / b.w
    
    return Vector4<T>(x, y, z, w)
}

// MARK: - Negation

public prefix func -<T: SignedVectorable>(v: Vector4<T>) -> Vector4<T> {
    let x: T = -v.x
    let y: T = -v.y
    let z: T = -v.z
    let w: T = -v.w
    
    return Vector4<T>(x, y, z, w)
}

public prefix func +<T: SignedVectorable>(v: Vector4<T>) -> Vector4<T> {
    let x: T = +v.x
    let y: T = +v.y
    let z: T = +v.z
    let w: T = +v.w
    
    return Vector4<T>(x, y, z, w)
}

// MARK: - Sum

public func sum<T: Vectorable>(_ a: Vector4<T>) -> T {
    return a.x + a.y + a.z + a.w
}

// MARK: - Geometric

public func length<T: FloatingPointVectorable>(_ a: Vector4<T>) -> T {
    return length2(a).squareRoot()
}

public func length2<T: Vectorable>(_ a: Vector4<T>) -> T {
    let a2: Vector4<T> = a * a
    
    return sum(a2)
}

public func normalize<T: FloatingPointVectorable>(_ a: Vector4<T>) -> Vector4<T> {
    return a / length(a)
}

public func distance<T: FloatingPointVectorable>(_ a: Vector4<T>, _ b: Vector4<T>) -> T {
    return distance2(a, b).squareRoot()
}

public func distance2<T: Vectorable>(_ a: Vector4<T>, _ b: Vector4<T>) -> T {
    let difference: Vector4<T> = b - a
    let difference2: Vector4<T> = difference * difference
    
    return sum(difference2)
}

public func dot<T: Vectorable>(_ a: Vector4<T>, _ b: Vector4<T>) -> T {
    let ab: Vector4<T> = a * b
    
    return sum(ab)
}

// Trigonometry

public func cos<T: FloatingPointVectorable>(_ a: Vector4<T>) -> Vector4<T> {
    let x: T = a.x.cosine()
    let y: T = a.y.cosine()
    let z: T = a.z.cosine()
    let w: T = a.w.cosine()
    
    return Vector4<T>(x, y, z, w)
}

public func sin<T: FloatingPointVectorable>(_ a: Vector4<T>) -> Vector4<T> {
    let x: T = a.x.sine()
    let y: T = a.y.sine()
    let z: T = a.z.sine()
    let w: T = a.w.sine()
    
    return Vector4<T>(x, y, z, w)
}
