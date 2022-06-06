//
//  LoadingView.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 06/06/2022.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var offsetDiff: Double
    @Binding var isLoadingOn: Bool
    @Binding var opacityOfLoadingBar: Double
    @Binding var startAngle: Double
    @Binding var endAngle: Double
    
    let loadingBarTimer = Timer.publish(every: 2.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let xCenter = width * 0.01
            let yCenter = height * 0.005
            ZStack {
                IPhoneBorder(maxWeight: width * 0.5, maxHeight: height * 0.5)
                    .foregroundColor(.greenLish)
                
                Button(width: width, height: width, offsetX: width * 0.485, offsetY: width, animatableData: offsetDiff)
                    .foregroundColor(.greenLish)
                    .onTapGesture {
                        turnOnLoadingBar(width)
                    }
                
                IPhoneScreen(maxWeight: width * 0.5, maxHeight: height * 0.51)
                    .offset(x: xCenter, y: yCenter)
                    .foregroundColor(isLoadingOn ? .blackLish : .black)
                    .animation(
                        .linear(duration: isLoadingOn ? 0.15 : 0),
                        value: isLoadingOn
                    )
                
                
                Loadings(maxWeight: width * 0.5, maxHeight: height * 0.5, startAngle: startAngle, endAngle: endAngle).stroke(lineWidth: 3)
                    .foregroundColor(.red)
                    .opacity(opacityOfLoadingBar)
                
            }
            .offset(x: width * 0.25, y: height * 0.25)
            .onReceive(loadingBarTimer) { _ in
                if isLoadingOn {
                    withAnimation(Animation.easeInOut(duration: 1)) {
                        endAngle += 360 * 0.63
                        withAnimation(Animation.linear(duration: 2)) {
                            endAngle += 360 * 0.3
                        }
                    }
                    Timer.scheduledTimer(withTimeInterval: 1.1, repeats: false) { _ in
                        withAnimation(Animation.easeInOut(duration: 1.5)) {
                            startAngle = endAngle - 60
                            withAnimation(Animation.linear(duration: 2.1)) {
                                startAngle = endAngle
                            }
                        }
                    }
                }
            }
        }
        .scaleEffect(1.9)
    }
    
    private func turnOnLoadingBar(_ width: Double) {
        withAnimation(.linear(duration: 0.1)) {
            offsetDiff += width * 0.008
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            withAnimation(.linear(duration: 0.1)) {
                offsetDiff -= width * 0.008
            }
        }
        if !isLoadingOn {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                isLoadingOn.toggle()
            }
            
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                withAnimation(.linear(duration: 2)) {
                    opacityOfLoadingBar = 1
                }
            }
        } else {
            endAngle = 0.0
            startAngle = 0.0
            opacityOfLoadingBar = 0.0
            isLoadingOn.toggle()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(offsetDiff: .constant(0.0), isLoadingOn: .constant(false), opacityOfLoadingBar: .constant(0.0), startAngle: .constant(0.0), endAngle: .constant(0.0))
    }
}
