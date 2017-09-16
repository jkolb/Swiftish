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

public func test<T: SignedVectorable>(_ sphere: Sphere<T>, intersectsOrIsInside plane: Plane<T>) -> Bool {
    let dist = dot(sphere.center, plane.normal) - plane.distance
    let intersects = abs(dist) <= sphere.radius
    let isInside = sphere.radius <= dist
    
    return intersects || isInside
}

public func test<T>(_ bounds: Bounds3<T>, intersectsOrIsInside plane: Plane<T>) -> Bool {
    let projectionRadiusOfBox = sum(bounds.extents * abs(plane.normal))
    let distanceOfBoxCenterFromPlane = dot(plane.normal, bounds.center) - plane.distance
    let intersects = abs(distanceOfBoxCenterFromPlane) <= projectionRadiusOfBox
    let isInside = projectionRadiusOfBox <= distanceOfBoxCenterFromPlane

    return intersects || isInside
}

public func test<T>(_ bounds:Bounds3<T>, intersectsOrIsInside frustum: Frustum<T>) -> Bool {
    if  bounds.isNull {
        return false
    }
    
    // In order of most likely to cause early exit
    if !test(bounds, intersectsOrIsInside:frustum.near) { return false }
    if !test(bounds, intersectsOrIsInside:frustum.left) { return false }
    if !test(bounds, intersectsOrIsInside:frustum.right) { return false }
    if !test(bounds, intersectsOrIsInside:frustum.top) { return false }
    if !test(bounds, intersectsOrIsInside:frustum.bottom) { return false }
    if !test(bounds, intersectsOrIsInside:frustum.far) { return false }
    
    return true
}

public func test<T>(_ bounds: Bounds3<T>, intersects plane: Plane<T>) -> Bool {
    let projectionRadiusOfBox = sum(bounds.extents * abs(plane.normal))
    let distanceOfBoxCenterFromPlane = abs(dot(plane.normal, bounds.center) - plane.distance)
    
    return distanceOfBoxCenterFromPlane <= projectionRadiusOfBox
}

public func test<T>(_ boundsA: Bounds3<T>, intersects boundsB: Bounds3<T>) -> Bool {
    if abs(boundsA.center.x - boundsB.center.x) > (boundsA.extents.x + boundsB.extents.x) { return false }
    if abs(boundsA.center.y - boundsB.center.y) > (boundsA.extents.y + boundsB.extents.y) { return false }
    if abs(boundsA.center.z - boundsB.center.z) > (boundsA.extents.z + boundsB.extents.z) { return false }
    
    return true
}

public func test<T: SignedVectorable>(_ sphere: Sphere<T>, intersects plane: Plane<T>) -> Bool {
    let dist = dot(sphere.center, plane.normal) - plane.distance
    
    return abs(dist) <= sphere.radius
}

public func test<T>(_ sphere: Sphere<T>, intersects bounds: Bounds3<T>) -> Bool {
    let distanceSquared = distance2(sphere.center, bounds)
    
    return distanceSquared <= sphere.radius * sphere.radius
}

public func test<T>(_ sphereA: Sphere<T>, intersects sphereB: Sphere<T>) -> Bool {
    let delta = sphereA.center - sphereB.center
    let distanceSquared = dot(delta, delta)
    let radiusSum = sphereA.radius + sphereB.radius
    
    return distanceSquared < radiusSum * radiusSum
}

public func test<T>(_ point: Vector3<T>, inside bounds: Bounds3<T>) -> Bool {
    let bmin = bounds.minimum
    let bmax = bounds.maximum
    let xin = point.x > bmin.x && point.x < bmax.x
    let yin = point.y > bmin.y && point.y < bmax.y
    let zin = point.z > bmin.z && point.z < bmax.z
    
    return xin && yin && zin
}

public func test<T: FloatingPointVectorable>(_ ray: Ray3<T>, intersects bounds: Bounds3<T>) -> Bool {
    var tmin: T = 0
    var tmax = T.max
    let amin = bounds.minimum
    let amax = bounds.maximum
    
    for i in 0..<3 {
        let oi = ray.origin[i]
        let di = ray.direction[i]
        
        if abs(di) < T.epsilon {
            if oi < amin[i] || oi > amax[i] {
                return false
            }
        }
        else {
            let ood = 1 / di
            var t1 = (amin[i] - oi) * ood
            var t2 = (amax[i] - oi) * ood
            
            if t1 > t2 {
                swap(&t1, &t2)
            }
            
            tmin = max(tmin, t1)
            tmax = min(tmax, t2)
            
            if tmin > tmax {
                return false
            }
        }
    }
    
    return true
}

public func test<T: SignedVectorable>(_ ray: Ray3<T>, intersects triangle: Triangle3<T>) -> Bool {
    let ab = triangle.b - triangle.a
    let ac = triangle.c - triangle.a
    let qp = -ray.direction
    
    let n = cross(ab, ac)
    
    let d = dot(qp, n)
    
    if d <= 0 {
        return false
    }
    
    let ap = ray.origin - triangle.a
    let t = dot(ap, n)
    
    if t < 0 {
        return false
    }
    
    let e = cross(qp, ap)
    let v = dot(ac, e)
    
    if v < 0 || v > d {
        return false
    }
    
    let w = -dot(ab, e)
    
    if w < 0 || v + w > d {
        return false
    }
    
    return true
}
