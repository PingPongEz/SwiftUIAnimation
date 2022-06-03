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
    @State private var offset = 0.0
    
    var body: some View {
        ZStack {
            IPhoneViewBorder(isScreenOn: $isScreenOn, degress: $degress, offsetDiff: $offset)
                .frame(width: screenWidth * 0.5, height: screenHeight * 0.5)
                .foregroundColor(.greenLish)
            IPhoneViewScreen()
                .frame(width: screenWidth * 0.48, height: screenHeight * 0.48)
                .foregroundColor(isScreenOn ? .blackLish : .black)
                .animation(
                    .linear(duration: isScreenOn ? 0.2 : 0),
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
