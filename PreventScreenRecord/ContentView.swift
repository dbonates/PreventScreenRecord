//
//  ContentView.swift
//  PreventScreenRecord
//
//  Created by Daniel Bonates on 10/02/23.
//

import SwiftUI

struct ContentView: View {

    init() {
        ScreenRecordingGuardian.shared.initialize()
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
