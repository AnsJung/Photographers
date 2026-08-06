//
//  TempViewModel.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/4/26.
//

import Foundation
import Combine
import FactoryKit

final class MainViewModel : ObservableObject {
    
    @Injected(\.photographersRepository)
    private var photographersRepository

    @Injected(\.photosRepository)
    private var photosRepository
    
    @Published var photographers: [Photographer] = []

    private var cancellables = Set<AnyCancellable>()
    
    /// 사진작가 목록 요청
    func fetchPhotographers(){
        photographersRepository.fetchPhotographers()
            .receive(on: DispatchQueue.main)
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
                self.photographers = photographers
            }
            .store(in: &cancellables)
    }
    
    func fetchPhotos(){
        photosRepository.fetchPhotos()
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
