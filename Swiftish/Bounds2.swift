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

public struct Bounds2<T: SignedVectorable> : Equatable {
    public var center: Vector2<T>
    public var extents: Vector2<T>
    
    public init() {
        self.init(center: Vector2<T>(), extents: Vector2<T>())
    }
    
    public init(minimum: Vector2<T>, maximum: Vector2<T>) {
        precondition(minimum.x <= maximum.x)
        precondition(minimum.y <= maximum.y)
        let center = (maximum + minimum) / T.two
        let extents = (maximum - minimum) / T.two
        self.init(center: center, extents: extents)
    }
    
    public init(center: Vector2<T>, extents: Vector2<T>) {
        precondition(extents.x >= T.zero)
        precondition(extents.y >= T.zero)
        self.center = center
        self.extents = extents
    }
    
    public init(union: [Bounds2<T>]) {
        var minmax = [Vector2<T>]()
        
        for other in union {
            if !other.isNull {
                minmax.append(other.minimum)
                minmax.append(other.maximum)
            }
        }
        
        self.init(containingPoints: minmax)
    }
    
    public init(containingPoints points: [Vector2<T>]) {
        if points.count == 0 {
            self.init()
            return
        }
        
        var minimum = Vector2<T>(T.max, T.max)
        var maximum = Vector2<T>(T.min, T.min)
        
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
        }
        
        self.init(minimum: minimum, maximum: maximum)
    }
    
    public var minimum: Vector2<T> {
        return center - extents
    }
    
    public var maximum: Vector2<T> {
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
        return center == Vector2<T>() && extents == Vector2<T>()
    }
    
    public func union(other: Bounds2<T>) -> Bounds2<T> {
        if isNull {
            return other
        }
        else if other.isNull {
            return self
        }
        else {
            return Bounds2<T>(containingPoints: [minimum, maximum, other.minimum, other.maximum])
        }
    }
    
    public func union(others: [Bounds2<T>]) -> Bounds2<T> {
        var minmax = [Vector2<T>]()
        
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
            return Bounds2<T>(containingPoints: minmax)
        }
    }
    
    public var description: String {
        return "{\(center), \(extents)}"
    }
    
    public var corners: [Vector2<T>] {
        let max: Vector2<T> = maximum
        let corner0: Vector2<T> = max * Vector2<T>(+T.one, +T.one)
        let corner1: Vector2<T> = max * Vector2<T>(+T.one, -T.one)
        let corner2: Vector2<T> = max * Vector2<T>(-T.one, +T.one)
        let corner3: Vector2<T> = max * Vector2<T>(-T.one, -T.one)

        return [corner0, corner1, corner2, corner3]
    }
}

public func ==<T: SignedVectorable>(a: Bounds2<T>, b: Bounds2<T>) -> Bool {
    return a.center == b.center && a.extents == b.extents
}
