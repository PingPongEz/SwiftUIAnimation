//
//  NewMainView.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 05/06/2022.
//

import SwiftUI

struct NewMainView: View {
    
    @State private var offsetDiff: Double = 0.0
    @State private var isLoadingOn: Bool = false
    @State private var startAngle = 0.0
    @State private var endAngle = 0.0
    @State private var opacityOfLoadingBar = 0.0
    
    @State private var isCirclesOn = false
    @State private var isSecondScreenOn = false
    @State private var currentCircle = 0
    @State private var opacityOfCircles = 0.0
    @State private var offsetOfAnotherButton = 0.0
    
    let loadingBarTimer = Timer.publish(every: 2.1, on: .main, in: .common).autoconnect()
    let circlesTimer = Timer.publish(every: 0.6, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            let xCenter = width * 0.01
            let yCenter = height * 0.005
            ScrollView {
                Section("First Phone") {
                    ZStack {
                        IPhoneBorder(maxWeight: width * 0.5, maxHeight: height * 0.5)
                            .foregroundColor(.greenLish)
                        
                        Button(width: width, height: width, offsetX: width * 0.485, offsetY: width, animatableData: offsetDiff)
                            .foregroundColor(.greenLish)
                            .onTapGesture {
                                turnOnLoadingBar(width)
                            }
                        
                        IPhoneScreen(maxWeight: width * 0.5, maxHeight: height * 0.51)
                            .offset(x: xCenter, y: yCenter)
                            .foregroundColor(isLoadingOn ? .blackLish : .black)
                            .animation(
                                .linear(duration: isLoadingOn ? 0.15 : 0),
                                value: isLoadingOn
                            )
                        
                        
                        Loadings(maxWeight: width * 0.5, maxHeight: height * 0.5, startAngle: startAngle, endAngle: endAngle).stroke(lineWidth: 3)
                            .foregroundColor(.red)
                            .opacity(opacityOfLoadingBar)
                        
                    }
                    .onReceive(loadingBarTimer) { _ in
                        if isLoadingOn {
                            withAnimation(Animation.easeInOut(duration: 1)) {
                                endAngle += 360 * 0.63
                                withAnimation(Animation.linear(duration: 2)) {
                                    endAngle += 360 * 0.3
                                }
                            }
                            Timer.scheduledTimer(withTimeInterval: 1.1, repeats: false) { _ in
                                withAnimation(Animation.easeInOut(duration: 1.5)) {
                                    startAngle = endAngle - 60
                                    withAnimation(Animation.linear(duration: 2.1)) {
                                        startAngle = endAngle
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: width * 0.5, height: height * 0.5)
                }
                Section("Second Phone") {
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
                        
                        BouncingCircles(currentCircle: $currentCircle, isCirclesOn: $isCirclesOn)
                            .foregroundColor(.white)
                    }
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
                    .frame(width: width * 0.5, height: height * 0.5)
                }
                .frame(width: width) // Ширина скролвью видимо от секций зависит почему-то
            }
        }
    }
    
    private func turnOnCircles(_ widht: Double) {
        clickButton(widht, button: .two)
        
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
    
    private func turnOnLoadingBar(_ width: Double) {
        clickButton(width, button: .one)
        
        if !isLoadingOn {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                isLoadingOn.toggle()
            }
            
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                withAnimation(.linear(duration: 2)) {
                    opacityOfLoadingBar = 1
                }
            }
        } else {
            endAngle = 0.0
            startAngle = 0.0
            opacityOfLoadingBar = 0.0
            isLoadingOn.toggle()
        }
    }
    
    private func clickButton(_ width: Double, button: ButtonCases) {
        withAnimation(.linear(duration: 0.1)) {
            switch button {
            case .one:
                offsetDiff += width * 0.008
            case .two:
                offsetOfAnotherButton += width * 0.008
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            withAnimation(.linear(duration: 0.1)) {
                switch button {
                case .one:
                    offsetDiff -= width * 0.008
                case .two:
                    offsetOfAnotherButton -= width * 0.008
                }
            }
        }
    }
}

enum ButtonCases {
    case one
    case two
}

struct NewMainView_Previews: PreviewProvider {
    static var previews: some View {
        NewMainView()
    }
}
