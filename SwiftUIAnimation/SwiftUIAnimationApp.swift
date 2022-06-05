//
//  SwiftUIAnimationApp.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 31/05/2022.
//

import SwiftUI

@main
struct SwiftUIAnimationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NewMainView()
        }
    }
}
