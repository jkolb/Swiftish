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

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

public protocol Vectorable : Equatable, Comparable {
    static func +(a: Self, b: Self) -> Self
    static func -(a: Self, b: Self) -> Self
    static func *(a: Self, b: Self) -> Self
    static func /(a: Self, b: Self) -> Self
    
    static var zero: Self { get }
    static var one: Self { get }
    static var two: Self { get }
    static var min: Self { get }
    static var max: Self { get }
}

public protocol SignedVectorable : Vectorable, SignedNumber {
}

public protocol FloatingPointVectorable : SignedVectorable, FloatingPoint {    
    static var epsilon: Self { get }
    static var deg2rad: Self { get }
    static var rad2deg: Self { get }
    
    func cosine() -> Self
    func sine() -> Self
    func tangent() -> Self
    
    func arccosine() -> Self
    func arcsine() -> Self
    func arctangent() -> Self
    
    func arctangent2(_ b: Self) -> Self
}

extension UInt : Vectorable {
    public static let zero: UInt = 0
    public static let one: UInt = 1
    public static let two: UInt = 2
}

extension UInt8 : Vectorable {
    public static let zero: UInt8 = 0
    public static let one: UInt8 = 1
    public static let two: UInt8 = 2
}

extension UInt16 : Vectorable {
    public static let zero: UInt16 = 0
    public static let one: UInt16 = 1
    public static let two: UInt16 = 2
}

extension UInt32 : Vectorable {
    public static let zero: UInt32 = 0
    public static let one: UInt32 = 1
    public static let two: UInt32 = 2
}

extension UInt64 : Vectorable {
    public static let zero: UInt64 = 0
    public static let one: UInt64 = 1
    public static let two: UInt64 = 2
}

extension Int : SignedVectorable {
    public static let zero: Int = 0
    public static let one: Int = 1
    public static let two: Int = 2
}

extension Int8 : SignedVectorable {
    public static let zero: Int8 = 0
    public static let one: Int8 = 1
    public static let two: Int8 = 2
}

extension Int16 : SignedVectorable {
    public static let zero: Int16 = 0
    public static let one: Int16 = 1
    public static let two: Int16 = 2
}

extension Int32 : SignedVectorable {
    public static let zero: Int32 = 0
    public static let one: Int32 = 1
    public static let two: Int32 = 2
}

extension Int64 : SignedVectorable {
    public static let zero: Int64 = 0
    public static let one: Int64 = 1
    public static let two: Int64 = 2
}

extension Float32: FloatingPointVectorable {
    public static let zero: Float32 = 0
    public static let one: Float32 = 1
    public static let two: Float32 = 2
    public static let min: Float32 = -greatestFiniteMagnitude
    public static let max: Float32 = +greatestFiniteMagnitude
    public static let epsilon: Float32 = 1e-6
    public static let deg2rad: Float32 = 0.0174532925199433
    public static let rad2deg: Float32 = 57.295779513082321
    
    public func cosine() -> Float32 {
        return cos(self)
    }
    
    public func sine() -> Float32 {
        return sin(self)
    }
    
    public func tangent() -> Float32 {
        return tan(self)
    }
    
    public func arccosine() -> Float32 {
        return acos(self)
    }
    
    public func arcsine() -> Float32 {
        return asin(self)
    }
    
    public func arctangent() -> Float32 {
        return atan(self)
    }
    
    public func arctangent2(_ b: Float32) -> Float32 {
        return atan2(self, b)
    }
}

extension Float64: FloatingPointVectorable {
    public static let zero: Float64 = 0
    public static let one: Float64 = 1
    public static let two: Float64 = 2
    public static let min: Float64 = -greatestFiniteMagnitude
    public static let max: Float64 = +greatestFiniteMagnitude
    public static let epsilon: Float64 = 1e-15
    public static let deg2rad: Float64 = 0.0174532925199433
    public static let rad2deg: Float64 = 57.295779513082321
    
    public func cosine() -> Float64 {
        return cos(self)
    }
    
    public func sine() -> Float64 {
        return sin(self)
    }
    
    public func tangent() -> Float64 {
        return tan(self)
    }
    
    public func arccosine() -> Float64 {
        return acos(self)
    }
    
    public func arcsine() -> Float64 {
        return asin(self)
    }
    
    public func arctangent() -> Float64 {
        return atan(self)
    }
    
    public func arctangent2(_ b: Float64) -> Float64 {
        return atan2(self, b)
    }
}

extension Float80: FloatingPointVectorable {
    public static let zero: Float80 = 0
    public static let one: Float80 = 1
    public static let two: Float80 = 2
    public static let min: Float80 = -greatestFiniteMagnitude
    public static let max: Float80 = +greatestFiniteMagnitude
    public static let epsilon: Float80 = 1e-15
    public static let deg2rad: Float80 = 0.0174532925199433
    public static let rad2deg: Float80 = 57.295779513082321
    
    public func cosine() -> Float80 {
        return Float80(cos(Float64(self)))
    }
    
    public func sine() -> Float80 {
        return Float80(sin(Float64(self)))
    }
    
    public func tangent() -> Float80 {
        return Float80(tan(Float64(self)))
    }
    
    public func arccosine() -> Float80 {
        return Float80(acos(Float64(self)))
    }
    
    public func arcsine() -> Float80 {
        return Float80(asin(Float64(self)))
    }
    
    public func arctangent() -> Float80 {
        return Float80(atan(Float64(self)))
    }
    
    public func arctangent2(_ b: Float80) -> Float80 {
        return Float80(atan2(Float64(self), Float64(b)))
    }
}
