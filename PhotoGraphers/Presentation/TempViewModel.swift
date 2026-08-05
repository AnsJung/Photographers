//
//  TempViewModel.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//

import Foundation
import Combine

final class TempViewModel : ObservableObject {
    private let repository: PhotographersRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: PhotographersRepository) {
        self.repository = repository
    }
    
    /// 사진작가 목록 요청
    func fetchPhotographers(){
        repository.fetchPhotographers()
            .sink { completion in
                switch completion{
                case .finished:
                    print("완료")
                case .failure(let error):
                    print("fail:", error)
                }
            } receiveValue: { photographers in
                photographers.forEach { photographer in
                    print("name:", photographer.name)
                    print("email:", photographer.email)
                    print("thumbnail:", photographer.profileImageURL.absoluteString)
                    print("---")
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchPhotos(){
        repository.fetchPhotos()
            .sink { completion in
                switch completion{
                case .finished:
                    print("완료")
                case .failure(let error):
                    print("fail:", error)
                }
            } receiveValue: { photos in
                photos.forEach { photo in
                    print("\(photo.id) >> \(photo.imageURL.absoluteString)")
                }
            }
            .store(in: &cancellables)
    }
}
