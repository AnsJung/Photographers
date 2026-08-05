//
//  PhotoGraphersRepository.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//

import Foundation
import Combine

protocol StartPhotographersRepository {
    /// 사진작가 목록 요청
    func fetchPhotographers() -> AnyPublisher<PhotographerResponseDTO, Error>
}

final class DefaultStartPhotographersRepository: StartPhotographersRepository {
    private enum Constant {
        static let photographersURLString =
        "https://randomuser.me/api/1.4/?results=30&inc=name,email,picture&seed=photographers"
    }
    func fetchPhotographers() -> AnyPublisher<PhotographerResponseDTO, Error> {
        guard let url = URL(string: Constant.photographersURLString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .decode(type: PhotographerResponseDTO.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


final class StubStartRepository: StartPhotographersRepository {
    func fetchPhotographers() -> AnyPublisher<PhotographerResponseDTO, Error> {
        let response = PhotographerResponseDTO(
            results: [
                PhotographerUserDTO(
                    name: PhotographerNameDTO(
                        first: "Annie",
                        last: "Leibovitz"
                    ),
                    email: "annie@example.com",
                    picture: PhotographerPictureDTO(
                        medium:  "https://randomuser.me/api/portraits/med/women/1.jpg",
                    )
                ),
            ]
        )

        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
