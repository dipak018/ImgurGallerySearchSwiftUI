//
//  HomeContentView.swift
//  ImgurGallerySearchSwiftUI
//
//  Created by Chaudhari, Dipak Bharat (external - Service) on 10/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

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
            .navigationTitle("Home")
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
        .onAppear {
                    // Fetch data when the view appears
                    viewModel.getData()
                }
    }
    
    var listView: some View {
        List(viewModel.albumDataList, id: \.id) { albumEntity in
            HStack {
                ZStack {
                    if let images = albumEntity.images {
                        if let imageURLString = images[0].link {
                            WebImage(url: URL(string:imageURLString))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                        }
                    }
                }
                Spacer()
                VStack {
                    HStack {
                        if let title = albumEntity.title {
                            Text(title)
                                .multilineTextAlignment(.leading)
                                .padding(5)
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        if let timeInterval = albumEntity.datetime {
                            Text(Date().getTime(timestamp: timeInterval)!)
                        }
                    }
                }
            }.frame(height: 100)
        }.listStyle(PlainListStyle())
            .background(Color.clear)
    }
        
    var gridView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
            ForEach(viewModel.items, id: \.id) { item in
                Text(item.name)
                Text(Date().getTime(timestamp: 1641776700)!)
            }
        }.background(.red)
            .padding()
    }
}

struct MyModel: Identifiable {
    let id: Int
    let name: String
}
