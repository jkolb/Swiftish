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

public struct Frustum<T: Vectorable> : Equatable, CustomStringConvertible {
    public let top: Plane<T>
    public let bottom: Plane<T>
    public let left: Plane<T>
    public let right: Plane<T>
    public let near: Plane<T>
    public let far: Plane<T>
    
    public init(top: Plane<T>, bottom: Plane<T>, left: Plane<T>, right: Plane<T>, near: Plane<T>, far: Plane<T>) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
        self.near = near
        self.far = far
    }
    
    public var description: String {
        return "{\n\tT: \(top)\n\tB: \(bottom)\n\tL: \(left)\n\tR: \(right)\n\tN: \(near)\n\tF: \(far)}"
    }
}

public func ==<T: Vectorable>(lhs: Frustum<T>, rhs: Frustum<T>) -> Bool {
    return lhs.top == rhs.top && lhs.bottom == rhs.bottom && lhs.left == rhs.left && lhs.right == rhs.right && lhs.near == rhs.near && lhs.far == rhs.far
}
