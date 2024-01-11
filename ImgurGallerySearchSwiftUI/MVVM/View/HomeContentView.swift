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
    @StateObject var viewModel = HomeViewModel()
    //    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.selectedLayout == .list {
                    listView
                } else {
                    gridView
                }
            }.searchable(text: $viewModel.searchText) {
            }
            .onSubmit(of: .search) {
                viewModel.findImages()
            }
            .navigationTitle("Home")
            .overlay {
                    if viewModel.albumDataList.isEmpty {
                        Text("No results found").bold()
                            .foregroundColor(.secondary)
                            .padding(.top, 20)
                    }
                }
            .navigationBarItems(trailing:Button(action: {
                viewModel.toggleLayout()
            }){
                Image(systemName: viewModel.selectedLayout == .list ? "square.grid.2x2" : "list.bullet")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                    .padding()
            })
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            viewModel.findImages()
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
                                .padding()
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
        }
    }
    
    var gridView: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(viewModel.albumDataList, id: \.id) { albumEntity in
                    ZStack {
                        if let images = albumEntity.images {
                            if let imageURLString = images[0].link {
                                WebImage(url: URL(string:imageURLString))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 170, height: 120)
                                    .cornerRadius(8)
                            }
                        }
                        
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
                                    Text(Date().getTime(timestamp: timeInterval)!).padding(.trailing)
                                }
                            }
                        }.frame(width: 170, height: 60)
                    }
                }.padding(.bottom,5)
            }.padding()
        }
    }
}

struct MyModel: Identifiable {
    let id: Int
    let name: String
}
