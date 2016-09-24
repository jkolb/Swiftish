//
// Copyright (c) 2015 Justin Kolb - https://github.com/jkolb/Swiftish
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Darwin

public protocol Arithmetic : Comparable, Equatable, IntegerLiteralConvertible {
    func +(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
    func *(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
}

public protocol SignedArithmetic : Arithmetic, SignedNumberType {
}

public protocol RealArithmetic : Arithmetic, AbsoluteValuable, FloatLiteralConvertible {
    prefix func √(x: Self) -> Self
    static func sqrt(x: Self) -> Self
    static func tan(x: Self) -> Self
    static func cos(x: Self) -> Self
    static func sin(x: Self) -> Self
    static func atan(x: Self) -> Self
    static func atan2(y: Self, _ x: Self) -> Self
    static func acos(x: Self) -> Self
    static func asin(x: Self) -> Self
    func distanceTo(other: Self) -> Self
    static var epsilon: Self { get }
}

extension UInt : Arithmetic {}
extension UInt8 : Arithmetic {}
extension UInt16 : Arithmetic {}
extension UInt32 : Arithmetic {}
extension UInt64 : Arithmetic {}

extension Int : SignedArithmetic {}
extension Int8 : SignedArithmetic {}
extension Int16 : SignedArithmetic {}
extension Int32 : SignedArithmetic {}
extension Int64 : SignedArithmetic {}

extension Float : RealArithmetic, SignedArithmetic {
    public static let epsilon: Float = 1e-6
    
    public static func sqrt(x: Float) -> Float {
        return Darwin.sqrt(x)
    }
    
    public static func tan(x: Float) -> Float {
        return Darwin.tanf(x)
    }
    
    public static func cos(x: Float) -> Float {
        return Darwin.cosf(x)
    }
    
    public static func sin(x: Float) -> Float {
        return Darwin.sinf(x)
    }
    
    public static func atan(x: Float) -> Float {
        return Darwin.atanf(x)
    }
    
    public static func atan2(y: Float, _ x: Float) -> Float {
        return Darwin.atan2f(y, x)
    }
    
    public static func acos(x: Float) -> Float {
        return Darwin.acosf(x)
    }
    
    public static func asin(x: Float) -> Float {
        return Darwin.asinf(x)
    }
}

extension Double : RealArithmetic, SignedArithmetic {
    public static let epsilon: Double = 1e-15

    public static func sqrt(x: Double) -> Double {
        return Darwin.sqrt(x)
    }
    
    public static func tan(x: Double) -> Double {
        return Darwin.tan(x)
    }
    
    public static func cos(x: Double) -> Double {
        return Darwin.cos(x)
    }
    
    public static func sin(x: Double) -> Double {
        return Darwin.sin(x)
    }
    
    public static func atan(x: Double) -> Double {
        return Darwin.atan(x)
    }
    
    public static func atan2(y: Double, _ x: Double) -> Double {
        return Darwin.atan2(y, x)
    }
    
    public static func acos(x: Double) -> Double {
        return Darwin.acos(x)
    }
    
    public static func asin(x: Double) -> Double {
        return Darwin.asin(x)
    }
}
