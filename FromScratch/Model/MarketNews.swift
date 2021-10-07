//
//  MarketNews.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import Foundation

struct MarketNews: Codable {
   let category: String
   let datetime: TimeInterval
   let headline: String
   let id: Int
   let image: String // image url
   let related: String
   let source: String
   let summary: String
   let url: String
}
