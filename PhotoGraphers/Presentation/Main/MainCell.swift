//
//  MainCell.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/6/26.
//

import SwiftUI
import Kingfisher

/// 메인화면 리스트 셀 뷰
struct MainCell: View {
    var photographer : Photographer
    
    var body: some View {
        HStack(spacing: 10){
            KFImage(photographer.profileImageURL)
                .onSuccess { result in
                    print("Image loaded from cache: \(result.cacheType)")
                }
                .onFailure { error in
                    print("Error: \(error)")
                }
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(photographer.name)
                Spacer().frame(height: 5)
                Text(photographer.email)
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    MainCell(
        photographer: Photographer(
            id: 0,
            name: "Lee",
            email: "Lee@n.com",
            profileImageURL: URL(string:"")!
        )
    )
}
