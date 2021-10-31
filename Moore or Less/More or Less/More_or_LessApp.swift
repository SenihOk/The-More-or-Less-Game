//
//  More or Less.swift
//  More or Less
//
//  Created by Senih Okuyucu on 10/6/21.
//

import SwiftUI
    
    
class Info: ObservableObject {
    @Published var score = 0
}
@main
struct More_or_LessApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
