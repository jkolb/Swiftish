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

public struct Matrix2x2<T: Vectorable> : Equatable, CustomStringConvertible {
    fileprivate var col0: Vector2<T>
    fileprivate var col1: Vector2<T>
    
    fileprivate var row0: Vector2<T> {
        return Vector2<T>(col0.x, col1.x)
    }
    
    fileprivate var row1: Vector2<T> {
        return Vector2<T>(col0.y, col1.y)
    }
    
    public init() {
        self.init(
            Vector2<T>(1, 0),
            Vector2<T>(0, 1)
        )
    }
    
    public init(_ v: T) {
        self.init(
            Vector2<T>(v, 0),
            Vector2<T>(0, v)
        )
    }
    
    public init(_ d: Vector2<T>) {
        self.init(
            Vector2<T>(d.x, 0),
            Vector2<T>(0, d.y)
        )
    }
    
    public init(
        _ x0: T, _ y0: T,
        _ x1: T, _ y1: T
        )
    {
        self.init(
            Vector2<T>(x0, x1),
            Vector2<T>(y0, y1)
        )
    }
    
    public init(_ rows: [[T]]) {
        precondition(rows.count == 2 && rows[0].count == 2 && rows[1].count == 2)
        self.init(
            Vector2<T>(rows[0][0], rows[1][0]),
            Vector2<T>(rows[0][1], rows[1][1])
        )
    }
    
    public init(
        _ col0: Vector2<T>,
        _ col1: Vector2<T>
        )
    {
        self.col0 = col0
        self.col1 = col1
    }
    
    public subscript(index: Int) -> Vector2<T> {
        get {
            switch index {
            case 0:
                return col0
            case 1:
                return col1
            default:
                fatalError("Index out of range")
            }
        }
        
        set {
            switch index {
            case 0:
                col0 = newValue
            case 1:
                col1 = newValue
            default:
                fatalError("Index out of range")
            }
        }
    }
    
    public func col(_ index: Int) -> Vector2<T> {
        return self[index]
    }
    
    public func row(_ index: Int) -> Vector2<T> {
        switch index {
        case 0:
            return row0
        case 1:
            return row1
        default:
            fatalError("Index out of range")
        }
    }
    
    public var transpose: Matrix2x2<T> {
        return Matrix2x2<T>(row0, row1)
    }

    public var description: String {
        return "{\n\t\(row0),\n\t\(row1)}"
    }

    // MARK: - Equatable

    public static func ==(a: Matrix2x2<T>, b: Matrix2x2<T>) -> Bool {
        return a.col0 == b.col0 && a.col1 == b.col1
    }

    // MARK: - Addition

    public static func +(a: Matrix2x2<T>, b: T) -> Matrix2x2<T> {
        let col0: Vector2<T> = a.col0 + b
        let col1: Vector2<T> = a.col1 + b
        
        return Matrix2x2<T>(col0, col1)
    }

    public static func +(a: T, b: Matrix2x2<T>) -> Matrix2x2<T> {
        let col0: Vector2<T> = a + b.col0
        let col1: Vector2<T> = a + b.col1
        
        return Matrix2x2<T>(col0, col1)
    }

    public static func +(a: Matrix2x2<T>, b: Matrix2x2<T>) -> Matrix2x2<T> {
        let col0: Vector2<T> = a.col0 + b.col0
        let col1: Vector2<T> = a.col1 + b.col1
        
        return Matrix2x2<T>(col0, col1)
    }

    // MARK: - Subtraction

    public static func -(a: Matrix2x2<T>, b: T) -> Matrix2x2<T> {
        let col0: Vector2<T> = a.col0 - b
        let col1: Vector2<T> = a.col1 - b
        
        return Matrix2x2<T>(col0, col1)
    }

    public static func -(a: T, b: Matrix2x2<T>) -> Matrix2x2<T> {
        let col0: Vector2<T> = a - b.col0
        let col1: Vector2<T> = a - b.col1
        
        return Matrix2x2<T>(col0, col1)
    }

    public static func -(a: Matrix2x2<T>, b: Matrix2x2<T>) -> Matrix2x2<T> {
        let col0: Vector2<T> = a.col0 - b.col0
        let col1: Vector2<T> = a.col1 - b.col1
        
        return Matrix2x2<T>(col0, col1)
    }

    // MARK: - Multiplication

    public static func *(a: Matrix2x2<T>, b: T) -> Matrix2x2<T> {
        let col0: Vector2<T> = a.col0 * b
        let col1: Vector2<T> = a.col1 * b
        
        return Matrix2x2<T>(col0, col1)
    }

    public static func *(a: T, b: Matrix2x2<T>) -> Matrix2x2<T> {
        let col0: Vector2<T> = a * b.col0
        let col1: Vector2<T> = a * b.col1
        
        return Matrix2x2<T>(col0, col1)
    }

    public static func *(m: Matrix2x2<T>, v: Vector2<T>) -> Vector2<T> {
        let x: T = m.col0.x * v.x + m.col1.x * v.y
        let y: T = m.col0.y * v.x + m.col1.y * v.y
        
        return Vector2<T>(x, y)
    }

    public static func *(v: Vector2<T>, m: Matrix2x2<T>) -> Vector2<T> {
        let x: T = v.x * m.col0.x + v.y * m.col0.y
        let y: T = v.x * m.col1.x + v.y * m.col1.y
        
        return Vector2<T>(x, y)
    }

    public static func *(m1: Matrix2x2<T>, m2: Matrix2x2<T>) -> Matrix2x2<T> {
        let a00: T = m1.col0.x
        let a01: T = m1.col0.y
        let a10: T = m1.col1.x
        let a11: T = m1.col1.y
        
        let b00: T = m2.col0.x
        let b01: T = m2.col0.y
        let b10: T = m2.col1.x
        let b11: T = m2.col1.y
        
        let x0: T = a00 * b00 + a10 * b01
        let y0: T = a01 * b00 + a11 * b01
        let x1: T = a00 * b10 + a10 * b11
        let y1: T = a01 * b10 + a11 * b11
        
        let col0 = Vector2<T>(x0, y0)
        let col1 = Vector2<T>(x1, y1)
        
        return Matrix2x2<T>(col0, col1)
    }

    // MARK: - Division

    public static func /(a: Matrix2x2<T>, b: T) -> Matrix2x2<T> {
        let col0: Vector2<T> = a.col0 / b
        let col1: Vector2<T> = a.col1 / b
        
        return Matrix2x2<T>(col0, col1)
    }

    public static func /(a: T, b: Matrix2x2<T>) -> Matrix2x2<T> {
        let col0: Vector2<T> = a / b.col0
        let col1: Vector2<T> = a / b.col1
        
        return Matrix2x2<T>(col0, col1)
    }
}

// MARK: - Division

public func /<T: SignedVectorable>(m: Matrix2x2<T>, v: Vector2<T>) -> Vector2<T> {
    return invert(m) * v
}

public func /<T: SignedVectorable>(v: Vector2<T>, m: Matrix2x2<T>) -> Vector2<T> {
    return v * invert(m)
}

public func /<T: SignedVectorable>(m1: Matrix2x2<T>, m2: Matrix2x2<T>) -> Matrix2x2<T> {
    return m1 * invert(m2)
}

// MARK: - Negation

public prefix func -<T: SignedVectorable>(m: Matrix2x2<T>) -> Matrix2x2<T> {
    let col0: Vector2<T> = -m.col0
    let col1: Vector2<T> = -m.col1
    
    return Matrix2x2<T>(col0, col1)
}

public prefix func +<T: SignedVectorable>(m: Matrix2x2<T>) -> Matrix2x2<T> {
    let col0: Vector2<T> = +m.col0
    let col1: Vector2<T> = +m.col1
    
    return Matrix2x2<T>(col0, col1)
}

// MARK: Approximately Equal

public func approx<T: FloatingPointVectorable>(_ a: Matrix2x2<T>, _ b: Matrix2x2<T>, epsilon: T = T.epsilon) -> Bool {
    let col0: Bool = approx(a.col0, b.col0, epsilon: epsilon)
    let col1: Bool = approx(a.col1, b.col1, epsilon: epsilon)
    
    return col0 && col1
}

// MARK: - Inverse

public func invert<T: SignedVectorable>(_ m: Matrix2x2<T>) -> Matrix2x2<T> {
    let a: T = m.col0.x
    let b: T = m.col1.x
    let c: T = m.col0.y
    let d: T = m.col1.y
    
    let ad: T = a * d
    let bc: T = b * c
    
    let oneOverDeterminant = 1 / (ad - bc)
    
    let x0: T = +d * oneOverDeterminant
    let x1: T = -b * oneOverDeterminant
    let y0: T = -c * oneOverDeterminant
    let y1: T = +a * oneOverDeterminant
    
    let col0 = Vector2<T>(x0, y0)
    let col1 = Vector2<T>(x1, y1)
    
    return Matrix2x2<T>(col0, col1)
}
