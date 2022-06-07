//
//  BouncingCirclesView.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 06/06/2022.
//

import SwiftUI

struct BouncingCirclesView: View {
    
    @Binding var offsetOfAnotherButton: Double
    @Binding var isCirclesOn: Bool
    @Binding var isSecondScreenOn: Bool
    @Binding var currentCircle: Int
    @Binding var opacityOfCircles: Double
    
    let circlesTimer = Timer.publish(every: 0.6, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let xCenter = width * 0.01
            let yCenter = height * 0.005
            ZStack {
                IPhoneBorder(maxWeight: width * 0.5, maxHeight: height * 0.5)
                    .foregroundColor(.greenLish)
                
                Button(width: width, height: width, offsetX: width * 0.485, offsetY: width, animatableData: offsetOfAnotherButton)
                    .foregroundColor(.greenLish)
                    .onTapGesture {
                        turnOnCircles(width)
                    }
                
                IPhoneScreen(maxWeight: width * 0.5, maxHeight: height * 0.51)
                    .offset(x: xCenter, y: yCenter)
                    .foregroundColor(isSecondScreenOn ? .blackLish : .black)
                    .animation(
                        .linear(duration: isSecondScreenOn ? 0.15 : 0),
                        value: isSecondScreenOn
                    )
                
                BouncingCircles(width: width, height: height, currentCircle: $currentCircle, isCirclesOn: $isCirclesOn)
                    .foregroundColor(.white)
            }
            .offset(x: width * 0.25, y: height * 0.25)
            .onReceive(circlesTimer) { _ in
                if isCirclesOn {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        if currentCircle == 3 {
                            currentCircle = 0
                        }
                        currentCircle += 1
                    }
                }
            }
        }
        .scaleEffect(1.9)
    }
    
    private func turnOnCircles(_ widht: Double) {
        withAnimation(.linear(duration: 0.1)) {
            offsetOfAnotherButton += widht * 0.008
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            withAnimation(.linear(duration: 0.1)) {
                offsetOfAnotherButton -= widht * 0.008
            }
        }
        if !isCirclesOn {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                isSecondScreenOn.toggle()
            }
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                withAnimation(.linear(duration: 1)) {
                    opacityOfCircles = 1
                    isCirclesOn = true
                }
            }
        } else {
            opacityOfCircles = 0
            isCirclesOn = false
            isSecondScreenOn = false
        }
        
    }
}

struct BouncingCirclesView_Previews: PreviewProvider {
    static var previews: some View {
        BouncingCirclesView(offsetOfAnotherButton: .constant(0.0), isCirclesOn: .constant(false), isSecondScreenOn: .constant(false), currentCircle: .constant(0), opacityOfCircles: .constant(0.0))
    }
}
