//
//  DateFormatter.swift
//  StoriMovie
//
//  Created by MaurZac on 28/07/24.
//

import Foundation

class DateUtils {
    static func formatReleaseDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "es_ES")
        
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
}
//extension DateFormatter {
//    static let releaseDateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.locale = Locale(identifier: "es_ES")
//        return formatter
//    }()
//    
//    static let monthYearFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter
//    }()
//    
//    func formatReleaseDate(_ dateString: String) -> String {
//        guard let date = DateFormatter.releaseDateFormatter.date(from: dateString) else {
//            return dateString
//        }
//        
//        return DateFormatter.monthYearFormatter.string(from: date)
//    }
//}


