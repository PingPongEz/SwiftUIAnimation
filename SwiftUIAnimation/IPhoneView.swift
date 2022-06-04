//
//  TestAnimation1.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 01/06/2022.
//

import SwiftUI
import Combine

struct IPhoneViewBorder: View {
    
    @Binding var timerStarted: Bool
    
    @Binding var isScreenOn: Bool
    @Binding var degress: Double
    
    @Binding var offsetDiff: Double
    @Binding var zeroDegress: Double
    
    var timer = Timer.publish(every: 2.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width * 0.96
            let height = geo.size.height * 0.96
            ZStack {
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
        .onReceive(timer) { _ in
            if timerStarted {
                withAnimation(Animation.easeInOut(duration: 1)) {
                    degress += 360 * 0.63
                    withAnimation(Animation.linear(duration: 2)) {
                        degress += 360 * 0.3
                    }
                }
                Timer.scheduledTimer(withTimeInterval: 1.1, repeats: false) { _ in
                    withAnimation(Animation.easeInOut(duration: 1.5)) {
                        zeroDegress = degress - 60
                        withAnimation(Animation.linear(duration: 2.1)) {
                            zeroDegress = degress
                        }
                    }
                }
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
            
            timerStarted = true
            
        } else {
            zeroDegress = 0.0
            degress = 0.0
            timerStarted = false
            isScreenOn.toggle()
        }
    }
}

struct IPhoneViewScreen: View {
    
    @Binding var isScreenOn: Bool
    @Binding var degress: Double
    @Binding var zeroDegress: Double
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                let width = geo.size.width * 0.96
                let height = geo.size.height * 0.96
                IPhoneScreen(maxWeight: width, maxHeight: height)
                
                Loadings(maxWeight: width, maxHeight: height, startAngle: degress, endAngle: zeroDegress).stroke(lineWidth: 4)
                    .foregroundColor(.red)
            }
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

struct TestAnimation1_Previews: PreviewProvider {
    static var previews: some View {
        IPhoneViewBorder(timerStarted: .constant(false), isScreenOn: .constant(false), degress: .constant(0.0), offsetDiff: .constant(0.0), zeroDegress: .constant(0.0))
    }
}
