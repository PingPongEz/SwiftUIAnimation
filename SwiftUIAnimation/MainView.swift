//
//  MainView.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 02/06/2022.
//

import SwiftUI

/*Первые попыточки получилось некрасиво и нереюзабельно
Оставлю это здесь просто для резюме чтобы было понятно что я не безнадежен











*/

































struct MainView: View {
    
    //Loadingbar states
    @State private var timerStarted = false
    @State private var isScreenOn = false
    @State private var degress = 0.0
    @State private var offset = 0.0
    @State private var zeroDegress = 0.0
    
    //Circles states
    @State private var timerForCircles = false
    @State private var isCirclesOn = false
    @State private var buttonForCirclesOffset = 0.0
    @State private var currentCircle = 0
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            ScrollView {
                Section("First path pic") {
                    ZStack {
                    FirstPathShape()
                        .frame(width: 200, height: 200)
                        CarView()
                            .frame(width: 40, height: 40)
                            .offset(x: -25)
                    }
                    .padding(.bottom, 50)
                }
                Section("IPhone model") {
                    ZStack {
                        IPhoneViewBorder(
                            timerStarted: $timerStarted,
                            isScreenOn: $isScreenOn,
                            degress: $degress,
                            offsetDiff: $offset,
                            zeroDegress: $zeroDegress
                        )
                        .modifier(SetupBoard(width: width * 0.5, height: height * 0.5, color: .greenLish))
                        IPhoneViewScreen(
                            isScreenOn: $isScreenOn,
                            degress: $degress,
                            zeroDegress: $zeroDegress
                        )
                        .modifier(
                            SetupScreen(
                                screenWidth: width * 0.48,
                                screenHeight: height * 0.49,
                                isOn: isScreenOn
                            )
                        )
                    }
                }
                Section("Bouncing cirecles") {
                    ZStack {
                        IPhoneViewBorderForCircles(
                            timerForCircles: $timerForCircles,
                            isCircleOn: $isCirclesOn,
                            buttonForCirclesOffset: $buttonForCirclesOffset,
                            currentCircle: $currentCircle
                        )
                        .modifier(SetupBoard(width: width * 0.5, height: height * 0.5, color: .greenLish))
                        IPhoneViewCircles(
                            currentCircle: $currentCircle,
                            isCirclesOn: $isCirclesOn
                        )
                        .modifier(
                            SetupScreen(
                                screenWidth: width * 0.48,
                                screenHeight: height * 0.49,
                                isOn: isCirclesOn
                            )
                        )
                    }
                }
                .frame(width: width)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
