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

public struct Bounds3<T: SignedVectorable> : Equatable {
    public var center: Vector3<T>
    public var extents: Vector3<T>
    
    public init() {
        self.init(center: Vector3<T>(), extents: Vector3<T>())
    }
    
    public init(minimum: Vector3<T>, maximum: Vector3<T>) {
        precondition(minimum.x <= maximum.x)
        precondition(minimum.y <= maximum.y)
        precondition(minimum.z <= maximum.z)
        let center = (maximum + minimum) / T.two
        let extents = (maximum - minimum) / T.two
        self.init(center: center, extents: extents)
    }
    
    public init(center: Vector3<T>, extents: Vector3<T>) {
        precondition(extents.x >= T.zero)
        precondition(extents.y >= T.zero)
        precondition(extents.z >= T.zero)
        self.center = center
        self.extents = extents
    }
    
    public init(union: [Bounds3<T>]) {
        var minmax = [Vector3<T>]()
        
        for other in union {
            if !other.isNull {
                minmax.append(other.minimum)
                minmax.append(other.maximum)
            }
        }
        
        self.init(containingPoints: minmax)
    }
    
    public init(containingPoints points: [Vector3<T>]) {
        if points.count == 0 {
            self.init()
            return
        }
        
        var minimum = Vector3<T>(T.max, T.max, T.max)
        var maximum = Vector3<T>(T.min, T.min, T.min)
        
        for point in points {
            if point.x < minimum.x {
                minimum.x = point.x
            }
            
            if point.x > maximum.x {
                maximum.x = point.x
            }
            
            if point.y < minimum.y {
                minimum.y = point.y
            }
            
            if point.y > maximum.y {
                maximum.y = point.y
            }
            
            if point.z < minimum.z {
                minimum.z = point.z
            }
            
            if point.z > maximum.z {
                maximum.z = point.z
            }
        }
        
        self.init(minimum: minimum, maximum: maximum)
    }
    
    public var minimum: Vector3<T> {
        return center - extents
    }
    
    public var maximum: Vector3<T> {
        return center + extents
    }
    
    //    public func intersectsOrIsInsidePlane(plane: Plane) -> Bool {
    //        let projectionRadiusOfBox = sum(radius * abs(plane.normal))
    //        let distanceOfBoxCenterFromPlane = dot(plane.normal, center) - plane.distanceToOrigin
    //        let intersects = abs(distanceOfBoxCenterFromPlane) <= projectionRadiusOfBox
    //        let isInside = projectionRadiusOfBox <= distanceOfBoxCenterFromPlane
    //        return intersects || isInside
    //    }
    //
    //    public var sphere: Sphere {
    //        return Sphere(center: center, radius: length(radius))
    //    }
    
    public var isNull: Bool {
        return center == Vector3<T>() && extents == Vector3<T>()
    }
    
    public func union(other: Bounds3<T>) -> Bounds3<T> {
        if isNull {
            return other
        }
        else if other.isNull {
            return self
        }
        else {
            return Bounds3<T>(containingPoints: [minimum, maximum, other.minimum, other.maximum])
        }
    }
    
    public func union(others: [Bounds3<T>]) -> Bounds3<T> {
        var minmax = [Vector3<T>]()
        
        if !isNull {
            minmax.append(minimum)
            minmax.append(maximum)
        }
        
        for other in others {
            if !other.isNull {
                minmax.append(other.minimum)
                minmax.append(other.maximum)
            }
        }
        
        if minmax.count == 0 {
            return self
        }
        else {
            return Bounds3<T>(containingPoints: minmax)
        }
    }
    
    public var description: String {
        return "{\(center), \(extents)}"
    }
    
    public var corners: [Vector3<T>] {
        return [
            (center + extents * Vector3<T>(+T.one, +T.one, +T.one)),
            (center + extents * Vector3<T>(-T.one, +T.one, +T.one)),
            (center + extents * Vector3<T>(+T.one, -T.one, +T.one)),
            (center + extents * Vector3<T>(+T.one, +T.one, -T.one)),
            (center + extents * Vector3<T>(-T.one, -T.one, +T.one)),
            (center + extents * Vector3<T>(+T.one, -T.one, -T.one)),
            (center + extents * Vector3<T>(-T.one, +T.one, -T.one)),
            (center + extents * Vector3<T>(-T.one, -T.one, -T.one)),
        ]
    }
}

public func ==<T: SignedVectorable>(lhs: Bounds3<T>, rhs: Bounds3<T>) -> Bool {
    return lhs.center == rhs.center && lhs.extents == rhs.extents
}
