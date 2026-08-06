//
//  NetworkService.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//

import Foundation
import Combine

/// APIEndpoint를 기반으로 네트워크 요청을 수행하고 응답 데이터를 디코딩하는 공통 서비스.
final class NetworkService{
    
    /// 네트워크 API 요청
    ///
    /// endpoint : 요청한 API 정보
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, NetworkError> {
        guard let url = endpoint.url else{
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidStatusCode(httpResponse.statusCode)
                }
                
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                }
                
                if error is DecodingError {
                    return NetworkError.decodingFailed(error)
                }
                
                return NetworkError.unknown(error)
            }
            .eraseToAnyPublisher()
    }
}

