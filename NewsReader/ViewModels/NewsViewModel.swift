//
//  NewsViewModel.swift
//  NewsReader
//
//  Created by Mayur on 09/11/24.
//

import SwiftUI
import Alamofire

class NewsViewModel: ObservableObject {
    
    @Published var articles: [NewsArticle] = []
    
    private let baseURL: String = "http://api.mediastack.com/v1/news"
    let categories = ["technology", "business", "sports", "entertainment"]
    @Published var selectedCategory: String = "technology"
    
    @AppStorage("bookMarkedArticles") private var savedBookmarksData: Data = Data()
    
    @Published var bookMarkedArticles: [NewsArticle] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(bookMarkedArticles) {
                savedBookmarksData = encoded
            }
        }
    }
    
    func fetchAllNewsArticles() {
        let url = "\(baseURL)"
        let apiKey = "60a15bfaeaa75bd1dbbc3ff6b68f4b6d"
        let parameters: [String: Any] = [
            "access_key": apiKey,
            "categories": selectedCategory,
            "languages": "en"
        ]
        AF.request(url, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Response.self, from: data)
//                    print("Articles: \(result.data)")
//                    DispatchQueue.main.async {
//                        self.articles = result.data
//                    }
                    DispatchQueue.main.async {
                        self.articles = result.data.map { article in
                            var mutableArticle = article
                            mutableArticle.isBookmarked = self.bookMarkedArticles.contains(where: {$0.url == article.url})
                            return mutableArticle
                        }
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func toggleBookmark(for article: NewsArticle) {
        if let index = articles.firstIndex(where: { $0.url == article.url }) {
            articles[index].isBookmarked.toggle()
            updateBookmarks()
        }
    }
    
    func updateBookmarks() {
        bookMarkedArticles = articles.filter { $0.isBookmarked }
    }
    
    func loadBookmarks() {
        if let decoded = try? JSONDecoder().decode([NewsArticle].self, from: savedBookmarksData) {
            bookMarkedArticles = decoded
        }
    }
}
