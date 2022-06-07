//
//  ViewBuilder.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 07/06/2022.
//

//
//
//Пробую понять что такое @viewbuilder и как оно работает
//
//
//

import SwiftUI

struct ViewBuilders<Content: View>: View{
    
    let title: String
    @ViewBuilder var content: (CGFloat) -> Content
    
    var body: some View {
        HStack {
            Text("\(title) :")
                .font(.system(size: 24))
            content(UIScreen.main.bounds.width)
        }
    }
}

struct ViewBuilderTests: View {
    
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
    
    let rows = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.height / 2))
    ]
    let items = SomeView.getViews()
    
    var body: some View {
        ScrollView {
            ViewBuilders(title: "FIRST VIEW") { width in
                LoadingView(offsetDiff: $offsetDiff, isLoadingOn: $isLoadingOn, opacityOfLoadingBar: $opacityOfLoadingBar, startAngle: $startAngle, endAngle: $endAngle)
                    .frame(width: width / 2, height: width)
            }
            ViewBuilders(title: "SECOND VIEW") { width in
                BouncingCirclesView(offsetOfAnotherButton: $offsetOfAnotherButton, isCirclesOn: $isCirclesOn, isSecondScreenOn: $isSecondScreenOn, currentCircle: $currentCircle, opacityOfCircles: $opacityOfCircles)
                    .frame(width: width / 2, height: width)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        }
}


struct ViewBuilder_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderTests()
    }
}
