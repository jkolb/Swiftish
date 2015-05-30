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

// Approximately equal using T.epsilon
infix operator ~~ {
    associativity none
    precedence 130
}

// Square Root Alt + V = √
prefix operator √ {}

public prefix func √(x: Float) -> Float {
    return sqrtf(x)
}

public prefix func √(x: Double) -> Double {
    return sqrt(x)
}

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
}
extension Double : RealArithmetic, SignedArithmetic {
    public static let epsilon: Double = 1e-15
}

public typealias Vector2F = Vector2<Float>
public typealias Vector3F = Vector3<Float>
public typealias Vector4F = Vector4<Float>
public typealias Vector2D = Vector2<Double>
public typealias Vector3D = Vector3<Double>
public typealias Vector4D = Vector4<Double>

public typealias Matrix2F = Matrix2<Float>
public typealias Matrix3F = Matrix3<Float>
public typealias Matrix4F = Matrix4<Float>
public typealias Matrix2D = Matrix2<Double>
public typealias Matrix3D = Matrix3<Double>
public typealias Matrix4D = Matrix4<Double>
