//
//  HomeContentView.swift
//  ImgurGallerySearchSwiftUI
//
//  Created by Chaudhari, Dipak Bharat (external - Service) on 10/01/24.
//

import SwiftUI

enum LayoutType {
    case list
    case grid
}

struct HomeContentView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.selectedLayout == .list {
                    listView
                } else {
                    gridView
                }
            }
            .navigationTitle("Home").background(.green)
            .navigationBarItems(trailing:Button(action: {
                viewModel.toggleLayout()
            }){
                Image(systemName: viewModel.selectedLayout == .list ? "list.bullet" : "square.grid.2x2")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                    .padding()
            })
        }.background(.orange)
        .ignoresSafeArea(edges: .bottom)
    }
    
    var listView: some View {
        List(viewModel.items, id: \.id) { item in
            Text(item.name)
        }
    }
    
    
    var gridView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
            ForEach(viewModel.items, id: \.id) { item in
                Text(item.name)
            }
        }.background(.red)
            .padding()
    }
}

struct MyModel: Identifiable {
    let id: Int
    let name: String
}
