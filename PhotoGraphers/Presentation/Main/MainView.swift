//
//  ContentView.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/3/26.
//

import SwiftUI
import FactoryKit

struct MainView: View {
    @StateObject
    private var viewModel = Container.shared.mainViewModel()
    
    var body: some View {
        List(viewModel.photographers) { photographer in
            MainCell(photographer: photographer)
        }
        .scrollContentBackground(.hidden)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .listStyle(.plain)
        .onAppear {
            print("네트워크 요청")
            viewModel.fetchPhotographers()
        }
    }
}

#Preview {
    MainView()
}
