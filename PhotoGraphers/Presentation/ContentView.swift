//
//  ContentView.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/3/26.
//

import SwiftUI
import FactoryKit

struct ContentView: View {
    @StateObject
    private var viewModel = Container.shared.tempViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            print("네트워크 요청")
            viewModel.fetchPhotographers()
        }
    }
}

#Preview {
    ContentView()
}
