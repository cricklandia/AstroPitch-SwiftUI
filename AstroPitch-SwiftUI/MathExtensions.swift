//
//  MathExtensions.swift
//  Lockpicking WatchKit Extension
//
//  Created by Alex Nascimento on 10/03/20.
//  Copyright © 2020 Alex Nascimento. All rights reserved.
//

extension Float {
    
    static func / (_ lhs: Float, _ rhs: Int) -> Float {
        return lhs/Float(rhs)
    }
    
    static func * (_ lhs: Float, _ rhs: Int) -> Float {
        return lhs*Float(rhs)
    }
    
    static func += (_ lhs: inout Float, _ rhs: Double) {
        lhs += Float(rhs)
    }
    
    static func * (_ lhs: Float, _ rhs: Double) -> Double {
        return Double(lhs)*rhs
    }
}

extension Double {
    
    static func / (_ lhs: Double, _ rhs: Int) -> Double {
        return lhs/Double(rhs)
    }
    
    static func * (_ lhs: Double, _ rhs: Int) -> Double {
        return lhs*Double(rhs)
    }
    
    static func / (_ lhs: Double, _ rhs: Float) -> Double {
           return lhs/Double(rhs)
    }
    
    static func * (_ lhs: Double,_ rhs: Float) -> Double {
        return lhs*Double(rhs)
    }
}

func lerp(current: Float, target: Float, pct: Float) -> Float {
    var pct = pct
    pct = pct < 0 ? 0 : pct
    pct = pct > 1 ? 1 : pct
    return current * (1-pct) + target * pct
}

func distance(_ from: Float, _ to: Float) -> Float {
    let diff = from - to
    return diff > 0 ? diff : -diff
}

func remainder(_ n: Float, _ d: Float) -> Float {
    let div = Int(n / d)
    return n - (d * div)
}

func modulus(_ n: Int, _ mod: Int) -> Int {
    let remainder = n % mod
    return remainder >= 0 ? remainder : remainder + mod
}

func modulus(_ n: Float, _ mod: Float) -> Float {
    let r = remainder(n, mod)
    return r > 0 ? r : r + mod
}
