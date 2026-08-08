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
    @EnvironmentObject var router : Router
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.photographers) { photographer in
                    Button {
                        router.push(.photoList(name: photographer.name))
                    } label: {
                        VStack(spacing: 0) {
                            HStack {
                                MainCell(photographer: photographer)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.gray.opacity(0.5))
                            }
                            .padding(.horizontal, 15)
                            .padding(.vertical, 12)
                            .contentShape(Rectangle())

                            Divider()
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .onAppear {
            print("네트워크 요청")
            viewModel.fetchPhotographers()
        }
    }
}

#Preview {
    MainView()
}
