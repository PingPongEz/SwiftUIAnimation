//
//  MainView.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 02/06/2022.
//

import SwiftUI

struct MainView: View {
    
    @State private var animateButton = false
    @State private var isScreenOn = false
    @State private var screenWidth = UIScreen.main.bounds.width
    @State private var screenHeight = UIScreen.main.bounds.height
    @State private var degress = 0.0
    @State private var zeroDegress = 0.0
    @State private var offset = 0.0
    @State private var timerStarted = false
    
    var body: some View {
        GeometryReader { geo in
            
            let width = geo.size.width
            let height = geo.size.height
            
            ScrollView {
                Section("IPhone model") {
                    ZStack {
                        IPhoneViewBorder(timerStarted: $timerStarted, isScreenOn: $isScreenOn, degress: $degress, offsetDiff: $offset, zeroDegress: $zeroDegress)
                            .frame(width: screenWidth * 0.5, height: screenHeight * 0.5)
                            .foregroundColor(.greenLish)
                        IPhoneViewScreen(isScreenOn: $isScreenOn, degress: $degress, zeroDegress: $zeroDegress)
                            .frame(width: screenWidth * 0.48, height: screenHeight * 0.49)
                            .foregroundColor(isScreenOn ? .blackLish : .black)
                            .animation(
                                .linear(duration: isScreenOn ? 0.15 : 0),
                                value: isScreenOn
                            )
                    }
                    .padding(.bottom, 50)
                    Section("Bouncing cirecles") {
                        
                    }
                }
                .frame(width: width, height: height)
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
