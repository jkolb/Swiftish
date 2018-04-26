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

public struct Sphere<T: Vectorable> : Equatable, CustomStringConvertible {
    public let center: Vector3<T>
    public let radius: T
    
    public init() {
        self.init(center: Vector3<T>(), radius: 0)
    }
    
    public init(center: Vector3<T>, radius: T) {
        precondition(radius >= 0)
        self.center = center
        self.radius = radius
    }
    
    public init(_ bounds: Bounds3<T>) {
        self.center = bounds.center
        self.radius = Vector3<T>.length(bounds.extents)
    }

    public var isNull: Bool {
        return center == Vector3<T>() && radius == 0
    }
    
    public var description: String {
        return "{\(center), \(radius)}"
    }

    public static func ==(a: Sphere<T>, b: Sphere<T>) -> Bool {
        return a.center == b.center && a.radius == b.radius
    }

    public var bounds: Bounds3<T> {
        return Bounds3<T>(center: center, extents: Vector3<T>(radius))
    }
    
    public static func union<T>(_ a: Sphere<T>, _ b: Sphere<T>) -> Sphere<T> {
        let midpoint = (a.center + b.center) / 2
        let largestRadius = Vector3<T>.distance(midpoint, a.center) + max(a.radius, b.radius)
        
        return Sphere<T>(center: midpoint, radius: largestRadius)
    }

    public func intersectsOrIsInside(_ plane: Plane<T>) -> Bool {
        let dist = Vector3<T>.dot(center, plane.normal) - plane.distance
        let intersects = abs(dist) <= radius
        let isInside = radius <= dist
        
        return intersects || isInside
    }

    public func intersects(_ plane: Plane<T>) -> Bool {
        let dist = Vector3<T>.dot(center, plane.normal) - plane.distance
        
        return Swift.abs(dist) <= radius
    }
    
    public func intersects(_ bounds: Bounds3<T>) -> Bool {
        let distanceSquared = Bounds3<T>.distance2(center, bounds)
        
        return distanceSquared <= radius * radius
    }
    
    public func intersects(_ sphere: Sphere<T>) -> Bool {
        let delta = center - sphere.center
        let distanceSquared = Vector3<T>.dot(delta, delta)
        let radiusSum = radius + sphere.radius
        
        return distanceSquared < radiusSum * radiusSum
    }
    
    public func transform(_ t: Transform3<T>) -> Sphere<T> {
        return Sphere(
            center: center + t.translation,
            radius: radius * t.scale.maximum
        )
    }
}
