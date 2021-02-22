//
//  Operators.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import CoreGraphics
extension CGFloat {
    public init(_ value: CGFloat){
        self = value
    }
}

protocol NumberConvertible: Comparable {
    init(_ value: Int)
    init(_ value: Float)
    init(_ value: Double)
    init(_ value: CGFloat)
}
extension NumberConvertible {
    fileprivate func convert<T: NumberConvertible>() -> T {
        switch self {
        case let x as CGFloat: return T(x)
        case let x as Float: return T(x)
        case let x as Int: return T(x)
        case let x as Double: return T(x)
        default:
            assert(false, "NumberConvertible convert cast failed!")
            return T(0)
        }
    }
    
    var c: CGFloat {
        get{ return convert() }
    }
    var f: Float {
        get{ return convert() }
    }
    var d: Double {
        get{ return convert() }
    }
    var i: Int {
        get{ return convert() }
    }
    
    fileprivate typealias PreferredType = Double
    fileprivate typealias CombineType = (PreferredType,PreferredType) -> PreferredType
    fileprivate func operate<T:NumberConvertible,V:NumberConvertible>(_ b:T, combine:CombineType) -> V {
        let x:PreferredType = convert()
        let y:PreferredType = b.convert()
        return combine(x,y).convert()
    }
}

extension CGFloat : NumberConvertible {}
extension Double  : NumberConvertible {}
extension Float   : NumberConvertible {}
extension Int     : NumberConvertible {}

//MARK: - Assignment overloading -
func + <T:NumberConvertible, U:NumberConvertible,V:NumberConvertible>(lhs: T, rhs: U) -> V {
    return lhs.operate(rhs, combine:+)
}
func - <T:NumberConvertible, U:NumberConvertible,V:NumberConvertible>(lhs: T, rhs: U) -> V {
    return lhs.operate(rhs, combine:-)
}
func * <T:NumberConvertible, U:NumberConvertible,V:NumberConvertible>(lhs: T, rhs: U) -> V {
    return lhs.operate(rhs, combine:*)
}
func / <T:NumberConvertible, U:NumberConvertible,V:NumberConvertible>(lhs: T, rhs: U) -> V {
    return lhs.operate(rhs, combine:/)
}

