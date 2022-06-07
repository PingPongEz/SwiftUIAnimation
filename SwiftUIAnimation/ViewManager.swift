//
//  ViewManager.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 07/06/2022.
//

import SwiftUI

struct SomeView {
    
    let view: AnyView
    let title: String
    
    static func getViews() -> [SomeView] {
        [
        SomeView(
            view: AnyView(LoadingView(offsetDiff: .constant(0.0), isLoadingOn: .constant(true), opacityOfLoadingBar: .constant(1.0), startAngle: .constant(240.0), endAngle: .constant(160.0))),
            title: "Loading Screen"
        ),
        SomeView(
            view: AnyView(BouncingCirclesView(offsetOfAnotherButton: .constant(0.0), isCirclesOn: .constant(true), isSecondScreenOn: .constant(true), currentCircle: .constant(2), opacityOfCircles: .constant(1.0))),
            title: "Boucing circles"
        ),
        SomeView(view: AnyView(FirstPathShape()), title: "Road")
        ]
    }
    
}
