# [Swiftish](https://github.com/jkolb/Swiftish)

#### A fully generic Swift vector & matrix library
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
#### Changelog

### Version 3.1.2
* zubco Make sure Float80 is only compiled for Intel

### Version 3.1.1
* zubco added Bounds2 & Bounds3 contains(point:) and intersection(other:) methods.

### Version 3.1.0
* Fix Vector3 xAxis
* Turn Vector3 axis methods into static properties
* Simplify Transform3 matrix & inverseMatrix methods to not use conditionals

### Version 3.0.0
* Updated for Swift 4

### Version 2.0.0
* Updated for Swift 3
* Swift Package Manager support
* Geometry and intersection tests

### Version 1.0.2
* Forgot to make typealias public
* Fixed approx to always use <=

### Version 1.0.1
* Started adding tests
* Added some aliases for common sizes and element types
* Tightened up the Arithmetic protocols
* Implemented approximately equal function and operator
* Made Vector & Matrix classes conform to Printable
* Verified that a switch statement is the best way to implement subscripting
* Now have access to the rows of a Matrix

## Contact

[Justin Kolb](mailto:justin.kolb@franticapparatus.net)  
[@nabobnick](https://twitter.com/nabobnick)

## License

Swiftish is available under the MIT license. See the LICENSE file for more info.
