//
//  ContentView.swift
//  steppa
//
//  Created by Godwin IE on 01/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "plus.circle")
                .imageScale(.large)
                .foregroundStyle(.black, .gray.tertiary )
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
