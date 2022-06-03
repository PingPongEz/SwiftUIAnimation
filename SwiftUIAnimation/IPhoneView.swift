//
//  TestAnimation1.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 01/06/2022.
//

import SwiftUI

struct IPhoneViewBorder: View {
    
    @Binding var isScreenOn: Bool
    @Binding var degress: Double
    
    @Binding var offsetDiff: Double
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width * 0.96
            let height = geo.size.height * 0.96
            ZStack {
                Loadings(maxWeight: width, maxHeight: height, source: degress)
                    .foregroundColor(.red)
                IPhoneBorder(maxWeight: width, maxHeight: height)
                    .foregroundColor(.greenLish)
                IPhoneButtonView(
                    width: width,
                    height: height,
                    offsetX: width,
                    offsetY: height,
                    offsetDiff: $offsetDiff
                )
                .onTapGesture {
                    animate(width: width)
                }
                .offset(CGSize(width: offsetDiff, height: 0))
            }
        }
    }
    
    func animate(width: Double) {
        withAnimation(.linear(duration: 0.1)) {
            offsetDiff -= width * 0.009
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.11, repeats: false) { _ in
            withAnimation(.linear(duration: 0.1)) {
                offsetDiff += width * 0.009
            }
        }
        
        if !isScreenOn {
            Timer.scheduledTimer(withTimeInterval: 0.44, repeats: false) { _ in
                withAnimation(.linear(duration: 0.1)) {
                    isScreenOn.toggle()
                }
            }
        } else {
            isScreenOn.toggle()
        }
    }
}

struct IPhoneViewScreen: View {
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width * 0.96
            let height = geo.size.height * 0.96
            IPhoneScreen(maxWeight: width, maxHeight: height)
        }
    }
}

struct IPhoneButtonView: View {
    
    let width: Double
    let height: Double
    let offsetX: Double
    let offsetY: Double
    
    @Binding var offsetDiff: Double
    
    var body: some View {
        ButtonView(width: width, height: height, offsetX: width, offsetY: height, offsetDiff: offsetDiff)
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

struct Loadings: Shape {
    
    let maxWeight: Double
    let maxHeight: Double
    
    let source: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(
            center: CGPoint(x: maxWeight / 2, y: maxHeight / 2),
            radius: maxWeight / 6,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: source),
            clockwise: true
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

extension Color {
    static let greenLish = Color(red: 103/255, green: 183/255, blue: 164/255)
    static let whiteLish = Color(red: 208/255, green: 208/255, blue: 208/255)
    static let blackLish = Color(red: 30/255, green: 32/255, blue: 36/255)
}


struct TestAnimation1_Previews: PreviewProvider {
    static var previews: some View {
        IPhoneViewBorder(isScreenOn: .constant(false), degress: .constant(0.0), offsetDiff: .constant(0.0))
    }
}
