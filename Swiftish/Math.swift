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

// Approximately equal using T.epsilon
infix operator ~~ {
    associativity none
    precedence 130
}

// Dot product Alt + 8 = •
infix operator • {
    associativity left
    precedence 160
}

// Cross product
infix operator × {
    associativity left
    precedence 170
}

// Square Root Alt + V = √
prefix operator √ {
}

public prefix func √(x: Float) -> Float {
    return Darwin.sqrtf(x)
}

public prefix func √(x: Double) -> Double {
    return Darwin.sqrt(x)
}
