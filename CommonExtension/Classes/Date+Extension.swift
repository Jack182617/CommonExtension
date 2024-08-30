//
//  Date+Extension.swift
//
//
//  Created by Jack on 2022-12-04.
//

import Foundation

public extension Date {
    var components: DateComponents? {
        let calendar = Calendar(identifier: .gregorian)
        guard let timeZone = TimeZone(identifier: TimeZone.current.identifier) else { return nil }
        return calendar.dateComponents(in: timeZone, from: self)
    }
    
    var yearString: String? {
        guard let component = self.components, let year = component.year else { return nil }
        return String(year)
    }
    
    var monthString: String? {
        guard let component = self.components, let month = component.month else { return nil }
        return String(month)
    }
    
    var dayString: String? {
        guard let component = self.components, let day = component.day else { return nil }
        return String(day)
    }
    
    func diffTime() -> TimeInterval {
        let timeStamp = (self.timeIntervalSince1970)
        let nowTimeStamp = round(Date().timeIntervalSince1970 )
        let differTime = (nowTimeStamp - timeStamp)
        return differTime
    }
    
    func dateString(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        return dateString
    }
}
