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

import XCTest
@testable import Swiftish

class Matrix3Tests: XCTestCase {
    func testInverse() {
        let col0 = Vector3<Float>(0.6, 0.2, 0.3)
        let col1 = Vector3<Float>(0.2, 0.7, 0.5)
        let col2 = Vector3<Float>(0.3, 0.5, 0.7)
        let a = Matrix3x3<Float>(col0, col1, col2)
        let ai = invert(a)
        let im = a * ai
        let id = a / a
        let i = Matrix3x3<Float>()
        
        // Multiplication
        XCTAssertTrue(approx(im, i), "\(im) not identity")
        
        // Division
        XCTAssertTrue(approx(id, i), "\(id) not identity")
    }
}
