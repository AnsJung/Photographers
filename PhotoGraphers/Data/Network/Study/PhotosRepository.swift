//
//  DefaultPhotographersRepository.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//
import Foundation
import Combine
import FactoryKit

protocol PhotosRepository {
    func fetchPhotos() -> AnyPublisher<[Photo], NetworkError>
}

final class DefaultPhotosRepository : PhotosRepository {
    @Injected(\.networkService)
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPhotos() -> AnyPublisher<[Photo], NetworkError> {
        networkService.request(.photos)
            .map { (response: [PhotosResponseDTO]) -> [Photo] in
                PhotosMapper.map(response)
            }
            .eraseToAnyPublisher()
    }
}

final class StubPhotosRepository: PhotosRepository {
    func fetchPhotos() -> AnyPublisher<[Photo], NetworkError> {
        let response = [
            Photo(
                id: "0",
                imageURL: URL(string: "https://picsum.photos/id/0/5000/3333")!
            ),
            Photo(
                id: "1",
                imageURL: URL(string: "https://picsum.photos/id/1/5000/3333")!
            )
        ]
        
        return Just(response)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
