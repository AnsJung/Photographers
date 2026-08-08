//
//  Container.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/6/26.
//

import Foundation
import FactoryKit

extension Container {
    var networkService : Factory<NetworkService> {
        self { NetworkService() }
    }
    
    var photographersRepository : Factory<PhotographersRepository> {
        self { DefaultPhotographersRepository(networkService: self.networkService()) }
    }
    
    var photosRepository : Factory<PhotosRepository> {
        self { DefaultPhotosRepository(networkService: self.networkService()) }
    }
    
    @MainActor
    var mainViewModel : Factory<MainViewModel> {
        self{ MainViewModel() }
    }
    
    @MainActor
    var router : Factory<Router> {
        self { Router() }
            .scope(.singleton)
    }
}
