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
    @State private var degress = 360.0
    @State private var zeroDegress = 360.0
    @State private var offset = 0.0
    
    var body: some View {
        ZStack {
            IPhoneViewBorder(isScreenOn: $isScreenOn, degress: $degress, offsetDiff: $offset, zeroDegress: $zeroDegress)
                .frame(width: screenWidth * 0.9, height: screenHeight * 0.9)
                .foregroundColor(.greenLish)
            IPhoneViewScreen(isScreenOn: $isScreenOn)
                .frame(width: screenWidth * 0.86, height: screenHeight * 0.88)
                .foregroundColor(isScreenOn ? .blackLish : .black)
                .animation(
                    .linear(duration: isScreenOn ? 0.15 : 0),
                    value: isScreenOn
                )
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
