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

public struct Angle<T: FloatingPointVectorable> : Equatable, Comparable, CustomStringConvertible {
    public var radians: T {
        didSet {
            radians = Angle<T>.clamped(radians)
        }
    }
    
    public init() {
        self.init(radians: 0)
    }
    
    public init(radians: T) {
        self.radians = Angle<T>.clamped(radians)
    }
    
    private static func clamped(_ radians: T) -> T {
        let min: T = -(T.pi * 2)
        let max: T = +(T.pi * 2)
        var clampedRadians = radians
        
        while clampedRadians >= max {
            clampedRadians -= max
        }
        
        while clampedRadians < min {
            clampedRadians += max
        }
        
        return clampedRadians
    }
    
    public init(degrees: T) {
        self.init(radians: T.deg2rad * degrees)
    }
    
    public var degrees: T {
        return radians * T.rad2deg
    }
    
    public var description: String {
        return "\(radians)"
    }

    public static func ==(a: Angle<T>, b: Angle<T>) -> Bool {
        return a.radians == b.radians
    }

    public static func <(a: Angle<T>, b: Angle<T>) -> Bool {
        return a.radians < b.radians
    }

    public static func +(a: Angle<T>, b: Angle<T>) -> Angle<T> {
        return Angle<T>(radians: a.radians + b.radians)
    }

    public static func -(a: Angle<T>, b: Angle<T>) -> Angle<T> {
        return Angle<T>(radians: a.radians - b.radians)
    }

    public static func *(a: Angle<T>, b: T) -> Angle<T> {
        return Angle<T>(radians: a.radians * b)
    }

    public static func *(a: T, b: Angle<T>) -> Angle<T> {
        return Angle<T>(radians: a * b.radians)
    }

    public static func /(a: Angle<T>, b: T) -> Angle<T> {
        return Angle<T>(radians: a.radians / b)
    }

    public static func +=(a: inout Angle<T>, b: Angle<T>) {
        a.radians = a.radians + b.radians
    }

    public static func -=(a: inout Angle<T>, b: Angle<T>) {
        a.radians = a.radians - b.radians
    }

    // MARK: - Negation

    public static prefix func -(a: Angle<T>) -> Angle<T> {
        return Angle<T>(radians: -a.radians)
    }

    public static prefix func +(a: Angle<T>) -> Angle<T> {
        return Angle<T>(radians: +a.radians)
    }
}

// MARK: - Trigonometry

public func cos<T>(_ a: Angle<T>) -> Angle<T> {
    return Angle<T>(radians: a.radians.cosine())
}

public func sin<T>(_ a: Angle<T>) -> Angle<T> {
    return Angle<T>(radians: a.radians.sine())
}

public func tan<T>(_ a: Angle<T>) -> Angle<T> {
    return Angle<T>(radians: a.radians.tangent())
}

public func acos<T>(_ a: Angle<T>) -> Angle<T> {
    return Angle<T>(radians: a.radians.arccosine())
}

public func asin<T>(_ a: Angle<T>) -> Angle<T> {
    return Angle<T>(radians: a.radians.arcsine())
}

public func atan<T>(_ a: Angle<T>) -> Angle<T> {
    return Angle<T>(radians: a.radians.arctangent())
}
