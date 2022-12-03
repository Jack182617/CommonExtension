//
//  Date+Extension.swift
//  CommonExtension
//
//  Created by 袁杰 on 2022-12-04.
//

import Foundation

public extension Date {
    var components: DateComponents? {
        let calendar = Calendar(identifier: .gregorian)
        guard let timeZone = TimeZone(identifier: TimeZone.current.identifier) else { return nil }
        return calendar.dateComponents(in: timeZone, from: self)
    }

    var yearString: String? {
        guard let compoment = self.components, let year = compoment.year else { return nil }
        return String(year)
    }

    var monthString: String? {
        guard let compoment = self.components, let month = compoment.month else { return nil }
        return String(month)
    }

    var dayString: String? {
        guard let compoment = self.components, let day = compoment.day else { return nil }
        return String(day)
    }

    /// 通用时间 String ，1 小时以内显示刚刚
    var simpleString: String? {
        let differTime = self.diffTime()
        guard differTime > 0 else {
            return ""
        }

        var dateString: String?

        if differTime < 60 * 60 {
            dateString = "刚刚"
        } else if (differTime > 60 * 60) && (differTime < 60 * 60 * 24) {
            let hour:Int = Int(floor(differTime / (60 * 60)))
            dateString = "\(hour)小时前"
        } else if (differTime > 60 * 60 * 24) && (differTime < 60 * 60 * 24 * 3) {
            let day:Int = Int(ceil(differTime / (60 * 60 * 24)))
            dateString = "\(day)天前"
        } else if (differTime > 60 * 60 * 24 * 3){
            let converFormatter = DateFormatter()
            converFormatter.dateFormat = "yyyy-MM-dd"
            dateString = converFormatter.string(from: self)
        }
        return dateString
    }

    /// 通用时间 String ，5 分钟以内显示刚刚
    var chatMessageString: String? {
        let differTime = self.diffTime()
        guard differTime > 0 else {
            return ""
        }
        var dateString: String?
        if differTime > 60 * 60 {
            dateString = simpleString
        }else {
            if differTime > 5 * 60 {
                let minute:Int = Int(floor(differTime / (60)))
                dateString = "\(minute)分钟前"
            }else {
                dateString = "刚刚"
            }
        }
        return dateString
    }

    private func diffTime() -> TimeInterval {
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
