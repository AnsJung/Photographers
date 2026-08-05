//
//  DefaultPhotographersRepository.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//
import Foundation
import Combine

protocol PhotographersRepository {
    func fetchPhotographers() -> AnyPublisher<PhotographerResponseDTO, NetworkError>
}

final class DefaultPhotographersRepository : PhotographersRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPhotographers() -> AnyPublisher<PhotographerResponseDTO, NetworkError> {
        networkService.request(.photographers)
    }
}

final class StubRepository: PhotographersRepository {
    func fetchPhotographers() -> AnyPublisher<PhotographerResponseDTO, NetworkError> {
        let response = PhotographerResponseDTO(
            results: [
                PhotographerUserDTO(
                    name: PhotographerNameDTO(
                        first: "Annie",
                        last: "Leibovitz"
                    ),
                    email: "annie@example.com",
                    picture: PhotographerPictureDTO(
                        medium: "https://randomuser.me/api/portraits/med/women/1.jpg"
                    )
                )
            ]
        )

        return Just(response)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
