//
//  BouncingCircles.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 04/06/2022.
//

import SwiftUI

struct BouncingCircles: View {
    
    @Binding var currentCircle: Int
    @Binding var isCirclesOn: Bool
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            HStack(alignment: .center, spacing: width * 0.05) {
                Circle()
                    .position(
                        y: currentCircle == 1 ? (height / 2 - height * 0.03) : height / 2
                    )
                    .frame(width: width * 0.05, height: width * 0.05)
                Circle()
                    .position(
                        y: currentCircle == 2 ? (height / 2 - height * 0.03) : height / 2
                    )
                    .frame(width: width * 0.05, height: width * 0.05)
                Circle()
                    .position(
                        y: currentCircle == 3 ? (height / 2 - height * 0.03) : height / 2
                    )
                    .frame(width: width * 0.05, height: width * 0.05)
            }
            .position(x: width / 2)
        }
        .opacity(!isCirclesOn ? 0 : 1)
    }
}

struct BouncingCircles_Previews: PreviewProvider {
    static var previews: some View {
        BouncingCircles(currentCircle: .constant(1), isCirclesOn: .constant(true))
    }
}
