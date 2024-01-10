//
//  HomeViewModel.swift
//  ImgurGallerySearchSwiftUI
//
//  Created by Chaudhari, Dipak Bharat (external - Service) on 10/01/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
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
}
