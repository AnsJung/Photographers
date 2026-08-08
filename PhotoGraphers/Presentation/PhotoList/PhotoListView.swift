//
//  PhotoListView.swift
//  PhotoGraphers
//
//  Created by 이정현 on 8/8/26.
//

import SwiftUI

struct PhotoListView: View {
    var name : String
    
    var body: some View {
        Text("Hello, \(name)")
    }
}

#Preview {
    PhotoListView(name:"iOS")
}
