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
}

extension UInt : Vectorable {
    public static var zero: UInt {
        return 0
    }

    public static var one: UInt {
        return 1
    }
    
    public static var two: UInt {
        return 2
    }
}

extension UInt8 : Vectorable {
    public static var zero: UInt8 {
        return 0
    }

    public static var one: UInt8 {
        return 1
    }
    
    public static var two: UInt8 {
        return 2
    }
}

extension UInt16 : Vectorable {
    public static var zero: UInt16 {
        return 0
    }

    public static var one: UInt16 {
        return 1
    }
    
    public static var two: UInt16 {
        return 2
    }
}

extension UInt32 : Vectorable {
    public static var zero: UInt32 {
        return 0
    }

    public static var one: UInt32 {
        return 1
    }
    
    public static var two: UInt32 {
        return 2
    }
}

extension UInt64 : Vectorable {
    public static var zero: UInt64 {
        return 0
    }

    public static var one: UInt64 {
        return 1
    }
    
    public static var two: UInt64 {
        return 2
    }
}

extension Int : SignedVectorable {
    public static var zero: Int {
        return 0
    }

    public static var one: Int {
        return 1
    }
    
    public static var two: Int {
        return 2
    }
}

extension Int8 : SignedVectorable {
    public static var zero: Int8 {
        return 0
    }

    public static var one: Int8 {
        return 1
    }
    
    public static var two: Int8 {
        return 2
    }
}

extension Int16 : SignedVectorable {
    public static var zero: Int16 {
        return 0
    }

    public static var one: Int16 {
        return 1
    }
    
    public static var two: Int16 {
        return 2
    }
}

extension Int32 : SignedVectorable {
    public static var zero: Int32 {
        return 0
    }

    public static var one: Int32 {
        return 1
    }
    
    public static var two: Int32 {
        return 2
    }
}

extension Int64 : SignedVectorable {
    public static var zero: Int64 {
        return 0
    }

    public static var one: Int64 {
        return 1
    }
    
    public static var two: Int64 {
        return 2
    }
}

extension Float32: FloatingPointVectorable {
    public static var zero: Float32 {
        return 0
    }

    public static var one: Float32 {
        return 1
    }
    
    public static var two: Float32 {
        return 2
    }
    
    public static var min: Float32 {
        return -greatestFiniteMagnitude
    }
    
    public static var max: Float32 {
        return +greatestFiniteMagnitude
    }
}

extension Float64: FloatingPointVectorable {
    public static var zero: Float64 {
        return 0
    }

    public static var one: Float64 {
        return 1
    }
    
    public static var two: Float64 {
        return 2
    }
    
    public static var min: Float64 {
        return -greatestFiniteMagnitude
    }
    
    public static var max: Float64 {
        return +greatestFiniteMagnitude
    }
}

extension Float80: FloatingPointVectorable {
    public static var zero: Float80 {
        return 0
    }

    public static var one: Float80 {
        return 1
    }
    
    public static var two: Float80 {
        return 2
    }
    
    public static var min: Float80 {
        return -greatestFiniteMagnitude
    }
    
    public static var max: Float80 {
        return +greatestFiniteMagnitude
    }
}
