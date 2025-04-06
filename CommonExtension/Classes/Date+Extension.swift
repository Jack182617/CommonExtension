//
//  Date+Extension.swift
//
//
//  Created by Jack on 2022-12-04.
//

import Foundation

public extension Date {
    private static let sharedCalendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone.current
        return calendar
    }()
    
    private var calendar: Calendar {
        return Self.sharedCalendar
    }
    
    var components: DateComponents {
        return calendar.dateComponents([.year, .month, .day], from: self)
    }
    
    var yearString: String? {
        guard let year = components.year else { return nil }
        return "\(year)"
    }
    
    var monthString: String? {
        guard let month = components.month else { return nil }
        return "\(month)"
    }
    
    var dayString: String? {
        guard let day = components.day else { return nil }
        return "\(day)"
    }
    
    /// 当前时间 - self 的时间差（秒）
    func diffTime() -> TimeInterval {
        return Date().timeIntervalSince(self)
    }
    
    /// 格式化日期为字符串
    func dateString(with format: String = "yyyy-MM-dd 'at' HH:mm:ss.SSS") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        return dateString
    }
}
