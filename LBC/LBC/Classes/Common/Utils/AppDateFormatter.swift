//
//  AppDateFormatter.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 06/03/2021.
//

import Foundation

class AppDateFormatter {
    static let shared = AppDateFormatter()
    
    private init() {}
    
    private let isoDateFormatter: ISO8601DateFormatter = {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate, .withFullTime]
        return isoDateFormatter
    }()
    
    private let longDateShortTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale.autoupdatingCurrent
        return dateFormatter
    }()

    func isoDate(from string: String) -> Date? {
        return isoDateFormatter.date(from: string)
    }
    
    func isoDateString(from date: Date) -> String {
        return isoDateFormatter.string(from: date)
    }
    
    func longDateShortTimeString(from date: Date) -> String {
        return longDateShortTimeFormatter.string(from: date)
    }
}
