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

public struct Bounds2<T: Vectorable> : Equatable {
    public var center: Vector2<T>
    public var extents: Vector2<T>
    
    public init() {
        self.init(center: Vector2<T>(), extents: Vector2<T>())
    }
    
    public init(minimum: Vector2<T>, maximum: Vector2<T>) {
        precondition(minimum.x <= maximum.x)
        precondition(minimum.y <= maximum.y)
        let center = (maximum + minimum) / 2
        let extents = (maximum - minimum) / 2
        self.init(center: center, extents: extents)
    }
    
    public init(center: Vector2<T>, extents: Vector2<T>) {
        precondition(extents.x >= 0)
        precondition(extents.y >= 0)
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
        
        var minimum = Vector2<T>(+T.greatestFiniteMagnitude, +T.greatestFiniteMagnitude)
        var maximum = Vector2<T>(-T.greatestFiniteMagnitude, -T.greatestFiniteMagnitude)
        
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
    
    public var isNull: Bool {
        return center == Vector2<T>() && extents == Vector2<T>()
    }
    
    public func contains(point: Vector2<T>) -> Bool {
        if point.x < minimum.x { return false }
        if point.y < minimum.y { return false }
        if point.x > maximum.x { return false }
        if point.y > maximum.y { return false }
        
        return true
    }
    
    /// If `other` bounds intersects current bounds, return their intersection.
    /// A `null` Bounds2 object is returned if any of those are `null` or if they don't intersect at all.
    ///
    /// - Note: A Bounds2 object `isNull` if it's center and extents are zero.
    /// - Parameter other: The second Bounds2 object to intersect with.
    /// - Returns: A Bounds2 object intersection.
    public func intersection(other: Bounds2<T>) -> Bounds2<T> {
        if isNull {
            return self
        }
        else if other.isNull {
            return other
        }
        else if minimum.x <= other.maximum.x && other.minimum.x <= maximum.x && maximum.y <= other.minimum.y &&
            other.maximum.y <= minimum.y {
            let minX = max(minimum.x, other.minimum.x)
            let minY = max(minimum.y, other.minimum.y)
            let maxX = min(maximum.x, other.maximum.x)
            let maxY = min(maximum.y, other.maximum.y)
            
            return Bounds2<T>(minimum: Vector2<T>(minX, minY), maximum: Vector2<T>(maxX, maxY))
        }
        return Bounds2<T>()
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
        let corner0: Vector2<T> = max * Vector2<T>(+1, +1)
        let corner1: Vector2<T> = max * Vector2<T>(+1, -1)
        let corner2: Vector2<T> = max * Vector2<T>(-1, +1)
        let corner3: Vector2<T> = max * Vector2<T>(-1, -1)

        return [corner0, corner1, corner2, corner3]
    }

    public static func ==(a: Bounds2<T>, b: Bounds2<T>) -> Bool {
        return a.center == b.center && a.extents == b.extents
    }
}
