//
//  PhotoGraphersApp.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/3/26.
//

import SwiftUI
import FactoryKit

@main
struct PhotoGraphersApp: App {
    
    @StateObject private var router: Router = Container.shared.router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MainView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .photoList(let name):
                            // TODO: 화면 이동
                            PhotoListView(name: name)
                        }
                    }
            }.environmentObject(router)
        }
    }
}
