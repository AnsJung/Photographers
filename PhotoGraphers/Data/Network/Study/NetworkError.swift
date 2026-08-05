//
//  NetworkError.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//
import Foundation

/// 네트워크 요청 및 결과 에러 표현
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingFailed(Error)
    case unknown(Error)
}
