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
    
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            ScrollView {
                LoadingView(offsetDiff: $offsetDiff, isLoadingOn: $isLoadingOn, opacityOfLoadingBar: $opacityOfLoadingBar, startAngle: $startAngle, endAngle: $endAngle)
                    .frame(width: width / 1.5, height: height / 1.5)
                
                BouncingCirclesView(geoWidth: width, geoHeight: height, offsetOfAnotherButton: $offsetOfAnotherButton, isCirclesOn: $isCirclesOn, isSecondScreenOn: $isSecondScreenOn, currentCircle: $currentCircle, opacityOfCircles: $opacityOfCircles)
                    .frame(width: width / 1.5, height: height / 1.5)
            }
            .frame(width: width, height: height)
        }
    }
}

struct NewMainView_Previews: PreviewProvider {
    static var previews: some View {
        NewMainView()
    }
}
