//
//  HomeViewModel.swift
//  ImgurGallerySearchSwiftUI
//
//  Created by Chaudhari, Dipak Bharat (external - Service) on 10/01/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    // MARK: - Public Props
    @Published var albumDataList:[AlbumEntity] = []
    @Published var error: Error?
    
    @Published var items: [MyModel] = []
    @Published var selectedLayout: LayoutType = .list

    init() {
        items = [
            MyModel(id: 1, name: "Item 1"),
            MyModel(id: 2, name: "Item 2"),
            MyModel(id: 3, name: "Item 3"),
        ]
    }

    func toggleLayout() {
        selectedLayout = (selectedLayout == .list) ? .grid : .list
    }
    
    func getData() {
        APIManager.shared.request(inputString: "Random", modelType: GalleryDataEntity.self, type: .imgurGallery) { response in
            switch response {
            case .success(let galleryDataEntity):
                DispatchQueue.main.async {
                    if let albumArray = galleryDataEntity.data {
                        self.albumDataList = albumArray
                    }
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
}
