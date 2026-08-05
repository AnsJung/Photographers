//
//  PhotosResponseDTO.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/5/26.
//

import Foundation

struct PhotosResponseDTO : Decodable {
    let id: String
    let imageURL : URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "download_url"
    }
}
