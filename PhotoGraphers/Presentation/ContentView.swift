//
//  ContentView.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/3/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject
    private var viewModel : TempViewModel
    
    init(viewModel: TempViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // TODO: Factory DI 적용 후 제거 예정
    init() {
        _viewModel = StateObject(wrappedValue: TempViewModel(
            repository: DefaultPhotographersRepository(networkService: NetworkService())
        ))
    }
    
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
    ContentView(viewModel: TempViewModel(repository: StubRepository()))
}
