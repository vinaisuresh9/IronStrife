//
//  MathFunctions.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/20/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import UIKit

class MathFunctions {
    
    static func calculateDistance(_ point1: CGPoint, point2: CGPoint) -> Double{
        if (point1 == point2){
            return 0
        }
        
        let squareX = Float(point1.x - point2.x) * Float(point1.x - point2.x)
        let squareY = Float(point1.y - point2.y) * Float(point1.y - point2.y)
        
        let squareRoot = sqrtf(squareX + squareY)
        return Double(squareRoot)
    }
    
    //Change to use vectors instead of points
    static func angleFromLine(_ point1: CGPoint, point2: CGPoint) -> Float?{
        switch (point1,point2) {
            //Case for first quadrant
        case let (p1,p2) where point2.x >= point1.x && point2.y >= point1.y:
            return atanf(Float(p2.y - p1.y)/Float(p2.x - p1.x))
        
            //Second Quadrant
        case let (p1,p2) where point2.x < point1.x && point2.y >= point1.y:
            return Float(M_PI) - atanf(Float(p2.y - p1.y)/Float(p1.x - p2.x))
            
            //Third Quadrant
        case let (p1,p2) where point2.x < point1.x && point2.y < point1.y:
            return Float(M_PI) + atanf(Float(p1.y - p2.y)/Float(p1.x - p2.x))
            
            //Invert points to get negative fourth quadrant
        case let (p1,p2) where point2.x >= point1.x && point2.y < point1.y:
            return atanf(Float(p2.y - p1.y)/Float(p2.x - p1.x))
        default:
            return nil
        }
    }
    
    //Normalize Vector Method!!!
    static func normalizedVector(_ point1: CGPoint, point2: CGPoint) -> CGVector{
        let distance = MathFunctions.calculateDistance(point1, point2: point2)
        
        var tempVector = CGVector(dx: point2.x - point1.x, dy: point2.y - point1.y)
        tempVector.dx /= CGFloat(distance)
        tempVector.dy /= CGFloat(distance)
        
        return tempVector
    }
    
    static func point(withOrigin origin: CGPoint, distance: CGFloat, angle: Double) -> CGPoint? {
        // Won't accept angles not within 0 - 2PI
        guard angle <= 2 * M_PI else { return nil }
        switch angle {
            //First Quadrant
        case let angle where angle >= 0 && angle <= M_PI_2:
            let dy = distance * CGFloat(sin(angle))
            let dx = distance * CGFloat(cos(angle))
            return CGPoint(x: origin.x + dx, y: origin.y + dy)
            // Second Quadrant
        case let angle where angle >= M_PI_2 && angle < M_PI:
            let dx = distance * CGFloat(sin(angle))
            let dy = distance * CGFloat(cos(angle))
            return CGPoint(x: origin.x + dx, y: origin.y + dy)
            // Third Quadrant
        case let angle where angle >= M_PI && angle <= (3 * M_PI_2):
            let dy = distance * CGFloat(sin(angle))
            let dx = distance * CGFloat(cos(angle))
            return CGPoint(x: origin.x + dx, y: origin.y + dy)
            // Fourth Quadrant
        case let angle where angle >= (3 * M_PI_2) && angle < (2 * M_PI):
            let dx = distance * CGFloat(sin(angle))
            let dy = distance * CGFloat(cos(angle))
            return CGPoint(x: origin.x + dx, y: origin.y + dy)
        default:
            return nil
        }
    }
}
