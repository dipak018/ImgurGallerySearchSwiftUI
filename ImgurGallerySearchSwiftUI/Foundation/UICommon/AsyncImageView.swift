//
//  AsyncImageView.swift
//  ImgurGallerySearchSwiftUI
//
//  Created by Chaudhari, Dipak Bharat (external - Service) on 11/01/24.
//

import SwiftUI

struct AsyncImageView<T>: View where T: Identifiable {
    let item: T?
    let imageLoader: (T) -> UIImage?
    
    init(item: T?, imageLoader: @escaping (T) -> UIImage?) {
        self.item = item
        self.imageLoader = imageLoader
    }

    var body: some View {
        if let item = item, let image = imageLoader(item) {
            Image(uiImage: image)
                .resizable()
        } else {
            Image(systemName: "photo")
                .resizable()
        }
    }
}
