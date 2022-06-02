//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 31/05/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let size = min(width, height)
            let minimal = size * 0.1
            let maximal = size * 0.9
            let middle = size / 2
            
            Path { path in
                path.move(to: CGPoint(x: middle - minimal, y: minimal))
                path.addLine(to: CGPoint(x: middle + minimal, y: minimal))
                path.addLine(to: CGPoint(x: maximal, y: maximal))
                path.addLine(to: CGPoint(x: minimal, y: maximal))
            }
            .opacity(0.4)
            
            Path { path in
                path.move(to: CGPoint(x: middle, y: minimal))
                path.addLine(to: CGPoint(x: middle, y: maximal))
            }
            .stroke(
                .white,
                style: StrokeStyle(
                    lineWidth: 3,
                    dash: [height / minimal]
                )
            )
            
            Image(systemName: "car.fill")
                .resizable()
                .foregroundColor(.black)
                .scaleEffect(minimal / 100)
                .offset(x: -middle / 3.75)
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 200, height: 200)
    }
}
