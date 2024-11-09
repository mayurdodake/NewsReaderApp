//
//  NewsListView.swift
//  NewsReader
//
//  Created by Mayur on 09/11/24.
//

import SwiftUI
import SwiftUI

struct NewsListView: View {
    
    @StateObject private var viewModel = NewsViewModel()
    var isBookMarked : Bool = false
    
    var body: some View {
        TabView {
            NavigationView {
                VStack (spacing: 5) {
                    Picker("Select Category", selection: $viewModel.selectedCategory) {
                        ForEach(viewModel.categories, id: \.self) { category in
                            Text(category.capitalized).tag(category)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .textSelection(.enabled)
                    .padding()
                    List(viewModel.articles, id: \.url) { article in
                        HStack {
                            NavigationLink(destination: NewsArticleDetailsView(article: article)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(article.title)
                                        .font(.headline)
                                    
                                    if let description = article.description {
                                        Text(description)
                                            .font(.subheadline)
                                            .foregroundColor(.orange)
                                            .lineLimit(3)
                                    }
                                    
                                    Text("Author: \(article.author ?? "Unknown Author")")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            Button(action: {
                                viewModel.toggleBookmark(for: article)
                            }) {
                                Image(systemName: article.isBookmarked ? "star.fill" : "star")
                                    .foregroundColor(article.isBookmarked || isBookMarked ? .yellow : .gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.vertical, 8)
                    }
                    .foregroundColor(.pink)
                    .navigationTitle("Today's Headlines")
                    .onAppear {
                        viewModel.fetchAllNewsArticles()
                        viewModel.loadBookmarks()
                    }
                    .onChange(of: viewModel.selectedCategory) { _ in
                        viewModel.fetchAllNewsArticles()
                    }
                }
            }
            .tabItem {
                Label("News", systemImage: "newspaper")
            }

            NavigationView {
                List(viewModel.bookMarkedArticles, id: \.url) { article in
                    NavigationLink(destination: NewsArticleDetailsView(article: article)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(article.title)
                                .font(.headline)
                            
                            if let description = article.description {
                                Text(description)
                                    .font(.subheadline)
                                    .foregroundColor(.orange)
                                    .lineLimit(3)
                            }
                            
                            Text("Author: \(article.author ?? "Unknown Author")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .navigationTitle("Bookmarked")
            }
            .tabItem {
                Label("Bookmarks", systemImage: "star.fill")
            }
        }
        .padding(5)
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}
