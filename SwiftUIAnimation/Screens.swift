//
//  Screens.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 04/06/2022.
//

import Foundation
import SwiftUI

/*Первые попыточки получилось некрасиво и нереюзабельно
Оставлю это здесь просто для резюме чтобы было понятно что я не безнадежен











*/






















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

struct IPhoneViewBorderForCircles: View {
    
    @Binding var timerForCircles: Bool
    @Binding var isCircleOn: Bool
    @Binding var buttonForCirclesOffset: Double
    @Binding var currentCircle: Int
    
    var timer = Timer.publish(every: 0.6, on: .main, in: .common).autoconnect()
    
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
                    offsetDiff: $buttonForCirclesOffset
                )
                .onTapGesture {
                    animate(width: width)
                }
                .offset(CGSize(width: buttonForCirclesOffset, height: 0))
            }
        }
        .onReceive(timer) { _ in
            if timerForCircles {
                withAnimation(.easeInOut(duration: 0.5)) {
                    if currentCircle == 3 {
                        currentCircle = 0
                    }
                    currentCircle += 1
                }
            }
        }
    }
    
    func animate(width: Double) {
        
        withAnimation(.linear(duration: 0.1)) {
            buttonForCirclesOffset -= width * 0.009
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.11, repeats: false) { _ in
            withAnimation(.linear(duration: 0.1)) {
                buttonForCirclesOffset += width * 0.009
            }
        }
        
        if !isCircleOn {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                isCircleOn.toggle()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                    timerForCircles = true
                }
            }
        } else {
            currentCircle = 0
            timerForCircles = false
            isCircleOn = false
        }
    }
}
