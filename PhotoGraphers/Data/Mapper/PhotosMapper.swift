//
//  PhotographerMapper.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//

import Foundation

enum PhotoMapper {
    static func map(_ response: [PhotosResponseDTO]) -> [Photo] {
        response.map { dto in
            Photo(
                id: dto.id,
                imageURL: dto.imageURL
            )
        }
    }
}
