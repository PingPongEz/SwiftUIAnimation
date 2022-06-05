//
//  CarView.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 31/05/2022.
//

import SwiftUI

//Тут просто машинка

struct CarView: View {
    
    var body: some View {
        GeometryReader { car in
            Image(systemName: "car.fill")
                .resizable()
                .frame(width: car.size.width, height: car.size.height)
        }
    }
}

struct CarView_Previews: PreviewProvider {
    static var previews: some View {
        CarView()
            .frame(width: 50, height: 50)
    }
}
