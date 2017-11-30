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

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

public protocol Vectorable : Numeric, Strideable {
    static func /(a: Self, b: Self) -> Self
    
    static var min: Self { get }
    static var max: Self { get }
}

public protocol SignedVectorable : Vectorable, SignedNumeric {
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

extension UInt : Vectorable {}

extension UInt8 : Vectorable {}

extension UInt16 : Vectorable {}

extension UInt32 : Vectorable {}

extension UInt64 : Vectorable {}

extension Int : SignedVectorable {}

extension Int8 : SignedVectorable {}

extension Int16 : SignedVectorable {}

extension Int32 : SignedVectorable {}

extension Int64 : SignedVectorable {}

extension Float32: FloatingPointVectorable {
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

// Float80 not available on ARM architecture
#if arch(i386) || arch(x86_64)

extension Float80: FloatingPointVectorable {
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

#endif
