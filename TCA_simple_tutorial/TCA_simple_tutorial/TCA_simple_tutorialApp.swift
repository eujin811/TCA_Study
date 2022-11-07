//
//  TCA_simple_tutorialApp.swift
//  TCA_simple_tutorial
//
//  Created by YoujinMac on 2022/11/07.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_simple_tutorialApp: App {
    let countStore = Store(initialState: CounterState(),
                           reducer: counterReducer,
                           environment: CounterEnvironment())
    
    var body: some Scene {
        WindowGroup {
            // App Level
            CounterView(store: countStore)
        }
    }
}
