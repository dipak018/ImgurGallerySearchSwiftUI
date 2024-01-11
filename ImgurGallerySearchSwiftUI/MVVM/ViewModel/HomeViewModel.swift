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
    @Published var selectedLayout: LayoutType = .list
    @State private var isGrid: Bool = UserDefaults.standard.bool(forKey: "isGrid")
    
    @Published var searchText = ""

    init() {
        selectedLayout = (isGrid == true) ? .grid : .list
    }
    
    func toggleLayout() {
        if selectedLayout == .list {
            selectedLayout = .grid
            UserDefaults.standard.set(true, forKey: "isGrid")
        } else {
            selectedLayout = .list
            UserDefaults.standard.set(false, forKey: "isGrid")
        }
    }
    
    func findImages() {
        var inputSearchText = searchText
        if searchText == "" {
            inputSearchText = "Random"
        }
        APIManager.shared.request(inputString: inputSearchText, modelType: GalleryDataEntity.self, type: .imgurGallery) { response in
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
