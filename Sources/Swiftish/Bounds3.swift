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
        let center = (maximum + minimum) / 2
        let extents = (maximum - minimum) / 2
        self.init(center: center, extents: extents)
    }
    
    public init(center: Vector3<T>, extents: Vector3<T>) {
        precondition(extents.x >= 0)
        precondition(extents.y >= 0)
        precondition(extents.z >= 0)
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
        let max: Vector3<T> = maximum
        let corner0: Vector3<T> = max * Vector3<T>(+1, +1, +1)
        let corner1: Vector3<T> = max * Vector3<T>(-1, +1, +1)
        let corner2: Vector3<T> = max * Vector3<T>(+1, -1, +1)
        let corner3: Vector3<T> = max * Vector3<T>(+1, +1, -1)
        let corner4: Vector3<T> = max * Vector3<T>(-1, -1, +1)
        let corner5: Vector3<T> = max * Vector3<T>(+1, -1, -1)
        let corner6: Vector3<T> = max * Vector3<T>(-1, +1, -1)
        let corner7: Vector3<T> = max * Vector3<T>(-1, -1, -1)
        
        return [
            corner0, corner1, corner2, corner3,
            corner4, corner5, corner6, corner7,
        ]
    }

    public static func ==(a: Bounds3<T>, b: Bounds3<T>) -> Bool {
        return a.center == b.center && a.extents == b.extents
    }
}

public func sphere<T: FloatingPointVectorable>(_ a: Bounds3<T>) -> Sphere<T> {
    return Sphere<T>(center: a.center, radius: length(a.extents))
}

public func distance2<T>(_ point: Vector3<T>, _ bounds: Bounds3<T>) -> T {
    var distanceSquared: T = 0
    let minimum = bounds.minimum
    let maximum = bounds.maximum
    
    for index in 0..<3 {
        let p = point[index]
        let bMin = minimum[index]
        let bMax = maximum[index]
        
        if p < bMin {
            let delta = bMin - p
            distanceSquared = distanceSquared + delta * delta
        }
        
        if p > bMax {
            let delta = p - bMax
            distanceSquared = distanceSquared + delta * delta
        }
    }
    
    return distanceSquared
}
