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
}

final class StubPhotographersRepository : PhotographersRepository {
    
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
}
