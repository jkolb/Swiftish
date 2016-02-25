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

import XCTest

class Vector4Tests: XCTestCase {
    func testEmptyInit() {
        let v = Vector4D()
        
        XCTAssertEqual(v.x, 0.0, "")
        XCTAssertEqual(v.y, 0.0, "")
        XCTAssertEqual(v.z, 0.0, "")
        XCTAssertEqual(v.w, 0.0, "")
    }
    
    func testSingleValueInit() {
        let v = Vector4D(1.257)
        
        XCTAssertEqual(v.x, 1.257, "")
        XCTAssertEqual(v.y, 1.257, "")
        XCTAssertEqual(v.z, 1.257, "")
        XCTAssertEqual(v.w, 1.257, "")
    }
    
    func testNormalInit() {
        let v = Vector4D(1.257, 3.1415, 401.5, -56.0)
        
        XCTAssertEqual(v.x, 1.257, "")
        XCTAssertEqual(v.y, 3.1415, "")
        XCTAssertEqual(v.z, 401.5, "")
        XCTAssertEqual(v.w, -56.0, "")
    }
    
    func testEquatable() {
        let va = Vector4D(1.257, 3.1415, -1.7, 42.0)
        let vb = Vector4D(1.257, 3.1415, -1.7, 42.0)
        let vc = Vector4D(457.1, 3.1415, -1.7, 42.0)
        let vd = Vector4D(1.257, 0.1415, -1.7, 42.0)
        let ve = Vector4D(1.257, 3.1415, 1.7, 42.0)
        let vf = Vector4D(1.257, 3.1415, -1.7, 4.0)
        
        XCTAssertEqual(va, vb, "")
        XCTAssertNotEqual(va, vc, "")
        XCTAssertNotEqual(va, vd, "")
        XCTAssertNotEqual(va, ve, "")
        XCTAssertNotEqual(va, vf, "")
    }
    
    func testScalarAddition() {
        let va = Vector4D(1.0) + 1.0
        let vb = 1.0 + Vector4D(2.0)
        
        XCTAssertEqual(va.x, 2.0, "")
        XCTAssertEqual(va.y, 2.0, "")
        XCTAssertEqual(va.z, 2.0, "")
        XCTAssertEqual(va.w, 2.0, "")
        XCTAssertEqual(vb.x, 3.0, "")
        XCTAssertEqual(vb.y, 3.0, "")
        XCTAssertEqual(vb.z, 3.0, "")
        XCTAssertEqual(vb.w, 3.0, "")
    }
    
    func testScalarSubtraction() {
        let va = Vector4D(1.0) - 1.0
        let vb = 1.0 - Vector4D(2.0)
        
        XCTAssertEqual(va.x, 0.0, "")
        XCTAssertEqual(va.y, 0.0, "")
        XCTAssertEqual(va.z, 0.0, "")
        XCTAssertEqual(va.w, 0.0, "")
        XCTAssertEqual(vb.x, -1.0, "")
        XCTAssertEqual(vb.y, -1.0, "")
        XCTAssertEqual(vb.z, -1.0, "")
        XCTAssertEqual(vb.w, -1.0, "")
    }
    
    func testScalarMultiplication() {
        let va = Vector4D(1.0) * 2.0
        let vb = 3.0 * Vector4D(2.0)
        
        XCTAssertEqual(va.x, 2.0, "")
        XCTAssertEqual(va.y, 2.0, "")
        XCTAssertEqual(va.z, 2.0, "")
        XCTAssertEqual(va.w, 2.0, "")
        XCTAssertEqual(vb.x, 6.0, "")
        XCTAssertEqual(vb.y, 6.0, "")
        XCTAssertEqual(vb.z, 6.0, "")
        XCTAssertEqual(vb.w, 6.0, "")
    }
    
    func testScalarDivision() {
        let va = Vector4D(1.0) / 2.0
        let vb = 4.0 / Vector4D(2.0)
        
        XCTAssertEqual(va.x, 0.5, "")
        XCTAssertEqual(va.y, 0.5, "")
        XCTAssertEqual(va.z, 0.5, "")
        XCTAssertEqual(va.w, 0.5, "")
        XCTAssertEqual(vb.x, 2.0, "")
        XCTAssertEqual(vb.y, 2.0, "")
        XCTAssertEqual(vb.z, 2.0, "")
        XCTAssertEqual(vb.w, 2.0, "")
    }
    
    func testVectorAddition() {
        let va = Vector4D(1.0, 2.0, 3.0, 4.0)
        let vb = Vector4D(2.0, 1.0, -4.0, 0.0)
        let vc = va + vb
        
        XCTAssertEqual(vc.x, 3.0, "")
        XCTAssertEqual(vc.y, 3.0, "")
        XCTAssertEqual(vc.z, -1.0, "")
        XCTAssertEqual(vc.w, 4.0, "")
    }
    
    func testVectorSubtraction() {
        let va = Vector4D(1.0, 2.0, 3.0, 4.0)
        let vb = Vector4D(2.0, 1.0, -4.0, 1.0)
        let vc = va - vb
        
        XCTAssertEqual(vc.x, -1.0, "")
        XCTAssertEqual(vc.y, 1.0, "")
        XCTAssertEqual(vc.z, 7.0, "")
        XCTAssertEqual(vc.w, 3.0, "")
    }
    
    func testVectorMultiplication() {
        let va = Vector4D(3.0, 2.0, 3.0, 0.5)
        let vb = Vector4D(2.0, 3.0, -4.0, 2.0)
        let vc = va * vb
        
        XCTAssertEqual(vc.x, 6.0, "")
        XCTAssertEqual(vc.y, 6.0, "")
        XCTAssertEqual(vc.z, -12.0, "")
        XCTAssertEqual(vc.w, 1.0, "")
    }
    
    func testVectorDivision() {
        let va = Vector4D(1.0, 4.0, -12.0, 0.5)
        let vb = Vector4D(2.0, 2.0, 3.0, 4.0)
        let vc = va / vb
        
        XCTAssertEqual(vc.x, 0.5, "")
        XCTAssertEqual(vc.y, 2.0, "")
        XCTAssertEqual(vc.z, -4.0, "")
        XCTAssertEqual(vc.w, 0.125, "")
    }
}
