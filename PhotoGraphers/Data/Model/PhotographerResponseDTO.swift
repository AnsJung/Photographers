//
//  PhotographerResponseDTO.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/3/26.
//
import Foundation

struct PhotographerResponseDTO: Decodable {
    let results: [PhotographerUserDTO]
}

struct PhotographerUserDTO: Decodable {
    let name: PhotographerNameDTO
    let email: String
    let picture: PhotographerPictureDTO
}

struct PhotographerNameDTO: Decodable {
    let first: String
    let last: String
}

struct PhotographerPictureDTO: Decodable {
    let medium: URL
}
