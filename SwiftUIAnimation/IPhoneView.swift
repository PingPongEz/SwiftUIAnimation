//
//  TestAnimation1.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 01/06/2022.
//

import SwiftUI
import Combine


//Первые попыточки получилось некрасиво и нереюзабельно
struct IPhoneViewScreen: View {
    
    @Binding var isScreenOn: Bool
    @Binding var degress: Double
    @Binding var zeroDegress: Double
    @State private var oppasity: Double = 0
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width * 0.96
            let height = geo.size.height * 0.96
            
            ZStack {
                IPhoneScreen(maxWeight: width, maxHeight: height)
                
                Loadings(maxWeight: width, maxHeight: height, startAngle: degress, endAngle: zeroDegress).stroke(lineWidth: 3)
                    .foregroundColor(.red)
                    .opacity(oppasity)
                    .onChange(of: isScreenOn) { newValue in //Плавность ползунка
                        if isScreenOn {
                            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                                withAnimation(.linear(duration: 0.5)) {
                                    oppasity = 1
                                }
                            }
                        } else {
                            oppasity = 0
                        }
                    }
            }
        }
    }
}

//Первые попыточки получилось некрасиво и нереюзабельно
struct IPhoneViewCircles: View {
    
    @Binding var currentCircle: Int
    @Binding var isCirclesOn: Bool
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width * 0.96
            let height = geo.size.height * 0.96
            
            ZStack {
                IPhoneScreen(maxWeight: width, maxHeight: height)
                
//                BouncingCircles(currentCircle: $currentCircle, isCirclesOn: $isCirclesOn)
                    .foregroundColor(.white)
            }
        }
    }
    
}

//Первые попыточки получилось некрасиво и нереюзабельно
struct IPhoneButtonView: View {
    
    let width: Double
    let height: Double
    let offsetX: Double
    let offsetY: Double
    
    @Binding var offsetDiff: Double
    
    var body: some View {
        Button(width: width, height: height, offsetX: width, offsetY: height, animatableData: offsetDiff)
    }
}

//Первые попыточки получилось некрасиво и нереюзабельно
struct IPhoneButtonViewCircle: View {
    
    let width: Double
    let height: Double
    let offsetX: Double
    let offsetY: Double
    
    @Binding var offsetDiff: Double
    
    var body: some View {
        Button(width: width, height: height, offsetX: width, offsetY: height, animatableData: offsetDiff)
    }
}

struct TestAnimation1_Previews: PreviewProvider {
    static var previews: some View {
        IPhoneViewCircles(currentCircle: .constant(0), isCirclesOn: .constant(true))
    }
}
