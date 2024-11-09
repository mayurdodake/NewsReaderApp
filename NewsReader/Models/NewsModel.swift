//
//  NewsModel.swift
//  NewsReader
//
//  Created by Mayur on 09/11/24.
//

import Foundation

struct Response: Codable {
    let data: [NewsArticle]
    let pagination: Pagination
}

struct NewsArticle: Codable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let source: String
    let image: String?
    let publishedAt: String
    let category: String
    var isBookmarked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case author, title, description, url, source, image, category
        case publishedAt = "published_at"
    }
}

struct Pagination: Codable {
    let limit: Int
    let offset: Int
    let count: Int
    let total: Int
}

