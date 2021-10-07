//
//  EarningsData.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import Foundation

struct EarningsData: Codable {
   let earningsCalendar: [EarningsCalendar]
}

struct EarningsCalendar: Codable {
   let date: String
   let epsActual: Double?
   let epsEstimate: Double?
   let hour: String
   let quarter: Int
   let revenueActual: Double?
   let revenueEstimate: Double?
   let symbol: String
   let year: Int
}

struct EarningsDetail {
   let lable: String
   let value: String
}
