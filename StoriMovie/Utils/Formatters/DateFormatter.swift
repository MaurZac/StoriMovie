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



