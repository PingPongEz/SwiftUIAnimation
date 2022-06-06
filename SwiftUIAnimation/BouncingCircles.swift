//
//  BouncingCircles.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 04/06/2022.
//

import SwiftUI

struct BouncingCircles: View {
    
    let width: Double
    let height: Double
    
    @Binding var currentCircle: Int
    @Binding var isCirclesOn: Bool
    
    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .center, spacing: width * 0.05) {
                Circle()
                    .frame(width: width * 0.05, height: width * 0.05)
                    .offset(y: currentCircle == 1 ? -height * 0.03 : 0)
                Circle()
                    .frame(width: width * 0.05, height: width * 0.05)
                    .offset(y: currentCircle == 2 ? -height * 0.03 : 0)
                Circle()
                    .frame(width: width * 0.05, height: width * 0.05)
                    .offset(y: currentCircle == 3 ? -height * 0.03 : 0)
            }
            .opacity(!isCirclesOn ? 0 : 1)
            .offset(x: width / 8, y: height / 4) //Это середина экрана. Всё. 
        }
    }
}

struct BouncingCircles_Previews: PreviewProvider {
    static var previews: some View {
        BouncingCircles(width: 200, height: 450, currentCircle: .constant(1), isCirclesOn: .constant(true))
    }
}
