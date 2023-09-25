//
//  ContentView.swift
//  ConfettiSwiftUIDemoApp
//
//  Created by Miguel.Afonso Maia on 25/09/2023.
//

import ConfettiSwiftUI
import SwiftUI

struct ContentView: View {
    @State private var trigger: String = ""
    
    var body: some View {
        Button("🎉") {
            trigger += " "
        }
        .confettiCannon(trigger: $trigger)
    }
}

#Preview {
    ContentView()
}
