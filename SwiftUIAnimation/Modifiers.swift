//
//  Modifiers.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 04/06/2022.
//

import Foundation
import SwiftUI

/*Первые попыточки получилось некрасиво и нереюзабельно
Оставлю это здесь просто для резюме чтобы было понятно что я не безнадежен

Настройки экранов для первопопыточных анимаций









*/

struct SetupBoard: ViewModifier {
    
    let width: Double
    let height: Double
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .foregroundColor(color)
    }
}

struct SetupScreen: ViewModifier {
    
    let screenWidth: Double
    let screenHeight: Double
    let isOn: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(width: screenWidth, height: screenHeight)
            .foregroundColor(isOn ? .blackLish : .black)
            .animation(
                .linear(duration: isOn ? 0.15 : 0),
                value: isOn
            )
    }
}

