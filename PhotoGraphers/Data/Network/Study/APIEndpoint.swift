//
//  APIEndpoint.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//
import Foundation

/// 앱에서 사용하는 API 요청 정보를 정의한다.
enum APIEndpoint {
    case photographers

    var url: URL? {
        switch self {
        case .photographers:
            var components = URLComponents(string: "https://randomuser.me/api/1.4/")
            components?.queryItems = [
                URLQueryItem(name: "results", value: "30"),
                URLQueryItem(name: "inc", value: "name,email,picture"),
                URLQueryItem(name: "seed", value: "photographers")
            ]
            return components?.url
        }
    }
}
