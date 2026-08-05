//
//  DefaultPhotographersRepository.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//
import Foundation
import Combine

protocol PhotographersRepository {
    func fetchPhotographers() -> AnyPublisher<[Photographer], NetworkError>
    func fetchPhotos() -> AnyPublisher<[Photo], NetworkError>
}

final class DefaultPhotographersRepository : PhotographersRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPhotographers() -> AnyPublisher<[Photographer], NetworkError> {
        networkService.request(.photographers)
            .map { (response: PhotographerResponseDTO) in
                PhotographerMapper.map(response)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchPhotos() -> AnyPublisher<[Photo], NetworkError> {
        networkService.request(.photos)
            .map { (response: [PhotosResponseDTO]) -> [Photo] in
                PhotosMapper.map(response)
            }
            .eraseToAnyPublisher()
    }
}

final class StubRepository: PhotographersRepository {
    
    func fetchPhotographers() -> AnyPublisher<[Photographer], NetworkError> {
        let photographers = [
            Photographer(
                id: 0,
                name: "Annie Leibovitz",
                email: "annie@example.com",
                profileImageURL: URL(string: "https://randomuser.me/api/portraits/med/women/1.jpg")!
            )
        ]
        
        return Just(photographers)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
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
