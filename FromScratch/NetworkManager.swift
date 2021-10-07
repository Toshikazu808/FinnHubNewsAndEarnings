//
//  NetworkManager.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import Foundation

final class NetworkManager {
   static let shared = NetworkManager()
   private init() {}
   private var marketCategory = ""
   
   func performRequest<T: Codable>(urlString: String, returnType: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
      guard let url = URL(string: urlString) else { return }
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: url) { data, _, err in
         if let err = err { completion(.failure(err)) } else {
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
               let decodedData = try decoder.decode(T.self, from: data)
               DispatchQueue.main.async {
                  completion(.success(decodedData))
               }
            } catch let err {
               completion(.failure(err))
            }
         }
      }
      task.resume()
   }
   
   func getMarketUrl(_ category: String) -> String {
      var url = "https://finnhub.io/api/v1/news?"
      url += "category=\(category.lowercased())"
      url += Keys.apiKey
      return url
   }
   
   func getCompanyUrl(_ company: String) -> String {
      var url = "https://finnhub.io/api/v1/company-news?"
      url += "symbol=\(company)"
      let fromDate = getFromDate()
      let untilDate = getUntilDate()
      url += "&from=\(fromDate)&to=\(untilDate)"
      url += Keys.apiKey
      return url
   }
   
   func getEarningsUrl(_ company: String?) -> String {
      var url = "https://finnhub.io/api/v1/calendar/earnings?"
      let fromDate = getFromDate()
      let untilDate = getUntilDate()
      url += Keys.apiKey
      url += "&from=\(fromDate)&to=\(untilDate)"
      guard let company = company else {
         url += Keys.apiKey
         return url
      }
      url += "&symbol=\(company)"
      url += Keys.apiKey
      return url
   }
   
   func getFromDate() -> String {
      let day: Double = 864000
      let date = Date().timeIntervalSince1970 - (day * 7)
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      let converted = Date(timeIntervalSince1970: date)
      return formatter.string(from: converted)
   }
   
   func getUntilDate() -> String {
      let date = Date()
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      return formatter.string(from: date)
   }
}
