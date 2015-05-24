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

import Darwin.C.math

// Square Root Alt + V = √
prefix operator √ {}

public prefix func √(x: Float) -> Float {
    return sqrtf(x)
}

public prefix func √(x: Double) -> Double {
    return sqrt(x)
}

public protocol Arithmetic : Equatable {
    func +(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
    func *(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
    static var zero: Self { get }
    static var one: Self { get }
    static var two: Self { get }
}

public protocol SignedArithmetic : Arithmetic {
    prefix func +(x: Self) -> Self
    prefix func -(x: Self) -> Self
}

public protocol RealArithmetic : Arithmetic {
    prefix func √(x: Self) -> Self
}

extension UInt : Arithmetic {
    public static let zero: UInt = 0
    public static let one: UInt = 1
    public static let two: UInt = 2
}
extension UInt8 : Arithmetic {
    public static let zero: UInt8 = 0
    public static let one: UInt8 = 1
    public static let two: UInt8 = 2
}
extension UInt16 : Arithmetic {
    public static let zero: UInt16 = 0
    public static let one: UInt16 = 1
    public static let two: UInt16 = 2
}
extension UInt32 : Arithmetic {
    public static let zero: UInt32 = 0
    public static let one: UInt32 = 1
    public static let two: UInt32 = 2
}
extension UInt64 : Arithmetic {
    public static let zero: UInt64 = 0
    public static let one: UInt64 = 1
    public static let two: UInt64 = 2
}

extension Int : SignedArithmetic {
    public static let zero: Int = 0
    public static let one: Int = 1
    public static let two: Int = 2
}
extension Int8 : SignedArithmetic {
    public static let zero: Int8 = 0
    public static let one: Int8 = 1
    public static let two: Int8 = 2
}
extension Int16 : SignedArithmetic {
    public static let zero: Int16 = 0
    public static let one: Int16 = 1
    public static let two: Int16 = 2
}
extension Int32 : SignedArithmetic {
    public static let zero: Int32 = 0
    public static let one: Int32 = 1
    public static let two: Int32 = 2
}
extension Int64 : SignedArithmetic {
    public static let zero: Int64 = 0
    public static let one: Int64 = 1
    public static let two: Int64 = 2
}

extension Float : RealArithmetic, SignedArithmetic {
    public static let zero: Float = 0
    public static let one: Float = 1
    public static let two: Float = 2
}
extension Double : RealArithmetic, SignedArithmetic {
    public static let zero: Double = 0
    public static let one: Double = 1
    public static let two: Double = 2
}
