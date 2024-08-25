//
//  Date+Format.swift
//  ToyProject
//
//  Created by jieunchoi on 8/20/24.
//

import Foundation

extension Date {
  
  func toString(format: String = "yyyy-MM-dd HH:mm:ss",timeZone: TimeZone) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = timeZone
    return formatter.string(from: self)
  }
  
}
