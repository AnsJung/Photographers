//
//  PhotographerMapper.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//

import Foundation

enum PhotographerMapper {
    static func map(_ response: PhotographerResponseDTO) -> [Photographer] {
        response.results.enumerated().map { index, dto in
            Photographer(
                id: index,
                name: "\(dto.name.first) \(dto.name.last)",
                email: dto.email,
                profileImageURL: dto.picture.medium,
            )
        }
    }
}
