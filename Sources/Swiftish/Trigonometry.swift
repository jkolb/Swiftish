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
#elseif os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin
#endif

public protocol Trigonometry {
    static func rad2deg(_ radians: Self) -> Self
    static func deg2rad(_ degrees: Self) -> Self
    
    static func cos(_ radians: Self) -> Self
    static func sin(_ radians: Self) -> Self
    static func tan(_ radians: Self) -> Self

    static func acos(_ radians: Self) -> Self
    static func asin(_ radians: Self) -> Self
    static func atan(_ radians: Self) -> Self

    static func atan2(_ y: Self, _ x: Self) -> Self
}

extension Float : Trigonometry {
    public static func rad2deg(_ radians: Float) -> Float {
        return radians * 180 / Float.pi
    }
    
    public static func deg2rad(_ degrees: Float) -> Float {
        return degrees * Float.pi / 180
    }

    @_transparent
    public static func cos(_ radians: Float) -> Float {
        #if os(Linux)
        return Glibc.cosf(radians)
        #else
        return Darwin.cosf(radians)
        #endif
    }
    
    @_transparent
    public static func sin(_ radians: Float) -> Float {
        #if os(Linux)
        return Glibc.sinf(radians)
        #else
        return Darwin.sinf(radians)
        #endif
    }
    
    @_transparent
    public static func tan(_ radians: Float) -> Float {
        #if os(Linux)
        return Glibc.tanf(radians)
        #else
        return Darwin.tanf(radians)
        #endif
    }
    
    @_transparent
    public static func acos(_ radians: Float) -> Float {
        #if os(Linux)
        return Glibc.acosf(radians)
        #else
        return Darwin.acosf(radians)
        #endif
    }
    
    @_transparent
    public static func asin(_ radians: Float) -> Float {
        #if os(Linux)
        return Glibc.asinf(radians)
        #else
        return Darwin.asinf(radians)
        #endif
    }
    
    @_transparent
    public static func atan(_ radians: Float) -> Float {
        #if os(Linux)
        return Glibc.atanf(radians)
        #else
        return Darwin.atanf(radians)
        #endif
    }
    
    @_transparent
    public static func atan2(_ yRadians: Float, _ xRadians: Float) -> Float {
        #if os(Linux)
        return Glibc.atan2(yRadians, xRadians)
        #else
        return Darwin.atan2(yRadians, xRadians)
        #endif
    }
}

extension Double : Trigonometry {
    public static func rad2deg(_ radians: Double) -> Double {
        return radians * 180 / Double.pi
    }
    
    public static func deg2rad(_ degrees: Double) -> Double {
        return degrees * Double.pi / 180
    }
    
    @_transparent
    public static func cos(_ radians: Double) -> Double {
        #if os(Linux)
        return Glibc.cos(radians)
        #else
        return Darwin.cos(radians)
        #endif
    }
    
    @_transparent
    public static func sin(_ radians: Double) -> Double {
        #if os(Linux)
        return Glibc.sin(radians)
        #else
        return Darwin.sin(radians)
        #endif
    }
    
    @_transparent
    public static func tan(_ radians: Double) -> Double {
        #if os(Linux)
        return Glibc.tan(radians)
        #else
        return Darwin.tan(radians)
        #endif
    }
    
    @_transparent
    public static func acos(_ radians: Double) -> Double {
        #if os(Linux)
        return Glibc.acos(radians)
        #else
        return Darwin.acos(radians)
        #endif
    }
    
    @_transparent
    public static func asin(_ radians: Double) -> Double {
        #if os(Linux)
        return Glibc.asin(radians)
        #else
        return Darwin.asin(radians)
        #endif
    }
    
    @_transparent
    public static func atan(_ radians: Double) -> Double {
        #if os(Linux)
        return Glibc.atan(radians)
        #else
        return Darwin.atan(radians)
        #endif
    }
    
    @_transparent
    public static func atan2(_ yRadians: Double, _ xRadians: Double) -> Double {
        #if os(Linux)
        return Glibc.atan2(yRadians, xRadians)
        #else
        return Darwin.atan2(yRadians, xRadians)
        #endif
    }
}
