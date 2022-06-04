//
//  Shapes.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 04/06/2022.
//

import Foundation
import SwiftUI

struct Loadings: Shape {
    
    let maxWeight: Double
    let maxHeight: Double
    
    var startAngle: Double
    var endAngle: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(
            center: CGPoint(x: maxWeight / 2, y: maxHeight / 2),
            radius: maxWeight / 6,
            startAngle: Angle(degrees: startAngle),
            endAngle: Angle(degrees: endAngle),
            clockwise: false
        )
        
        return path
    }
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(startAngle), Double(endAngle))
        } set {
            startAngle = newValue.first
            endAngle = newValue.second
        }
    }
}

struct IPhoneBorder: Shape {
    
    let maxWeight: Double
    let maxHeight: Double
    let minWeight: Double = 0
    let minHeight: Double = 0
    
    var diff: Double {
        maxWeight * 0.1
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: minWeight, y: minHeight + diff))
        path.addQuadCurve(
            to: CGPoint(x: minWeight + diff, y: minHeight),
            control: CGPoint(x: minHeight, y: minWeight)
        )
        
        path.addLine(to: CGPoint(x: maxWeight - diff, y: minHeight))
        path.addQuadCurve(
            to: CGPoint(x: maxWeight, y: minHeight + diff),
            control: CGPoint(x: maxWeight, y: minHeight)
        )
        
        path.addLine(to: CGPoint(x: maxWeight, y: maxHeight - diff))
        path.addQuadCurve(
            to: CGPoint(x: maxWeight - diff, y: maxHeight),
            control: CGPoint(x: maxWeight, y: maxHeight)
        )
        
        path.addLine(to: CGPoint(x: minWeight + diff, y: maxHeight))
        path.addQuadCurve(
            to: CGPoint(x: minWeight, y: maxHeight - diff),
            control: CGPoint(x: minWeight, y: maxHeight)
        )
        
        return path
    }
}

struct IPhoneScreen: Shape {
    
    let maxWeight: Double
    let maxHeight: Double
    let minWeight: Double = 0
    let minHeight: Double = 0
    
    var window: Double {
        maxWeight * 0.25
    }
    
    var windowCorner: Double {
        maxWeight * 0.27
    }
    
    var windowHeightCorner: Double {
        maxWeight * 0.08
    }
    
    var smallCorner: Double {
        maxWeight * 0.02
    }
    
    var diff: Double {
        maxWeight * 0.1
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: minWeight, y: minHeight + diff))
        path.addQuadCurve(
            to: CGPoint(x: minWeight + diff, y: minHeight),
            control: CGPoint(x: minHeight, y: minWeight)
        )
        
        path.addLine(to: CGPoint(x: minWeight + window, y: minHeight))
        path.addQuadCurve(
            to: CGPoint(x: minWeight + windowCorner, y: smallCorner),
            control: CGPoint(x: windowCorner, y: minHeight)
        )
        
        path.addQuadCurve(
            to: CGPoint(x: minWeight + window + diff + smallCorner, y: minHeight + diff),
            control: CGPoint(x: minWeight + windowCorner, y: minHeight + diff)
        )
        
        path.addLine(
            to: CGPoint(x: maxWeight - diff - window - smallCorner, y: minHeight + diff)
        )
        path.addQuadCurve(
            to: CGPoint(x: maxWeight - window - smallCorner, y: minHeight + smallCorner),
            control: CGPoint(x: maxWeight - window - smallCorner, y: minHeight + diff)
        )
        path.addQuadCurve(
            to: CGPoint(x: maxWeight - window, y: minWeight),
            control: CGPoint(x: maxWeight - window - smallCorner, y: minWeight)
        )
        
        path.addLine(to: CGPoint(x: maxWeight - diff, y: minHeight))
        path.addQuadCurve(
            to: CGPoint(x: maxWeight, y: minHeight + diff),
            control: CGPoint(x: maxWeight, y: minHeight)
        )
        
        path.addLine(to: CGPoint(x: maxWeight, y: maxHeight - diff))
        path.addQuadCurve(
            to: CGPoint(x: maxWeight - diff, y: maxHeight),
            control: CGPoint(x: maxWeight, y: maxHeight)
        )
        
        path.addLine(to: CGPoint(x: minWeight + diff, y: maxHeight))
        path.addQuadCurve(
            to: CGPoint(x: minWeight, y: maxHeight - diff),
            control: CGPoint(x: minWeight, y: maxHeight)
        )
        
        return path
    }
}

struct ButtonView: Shape {
    
    let width: Double
    let height: Double
    let offsetX: Double
    let offsetY: Double
    
    var offsetDiff: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRoundedRect(
            in: CGRect(
                x: offsetX * 0.982,
                y: offsetY * 0.2,
                width: width * 0.03,
                height: height * 0.1
            ),
            cornerSize: CGSize(width: 10, height: 7))
        
        return path
    }
}
