//
//  String+Extension.swift
//  SpeedR_Extension
//
//  Created by 袁杰 on 2022/9/27.
//

import Foundation
import CommonCrypto

let KUrlCodingReservedCharacters = "!*'();:|@&=+$,/?%#[]{}"

// MARK: - String扩展
public extension String{
    // String转float
    var floatValue: Float {
        return (self as NSString).floatValue
    }

    var doubleValue: Double {
        return (self as NSString).doubleValue
    }

    var intValue: Int {
        return (self as NSString).integerValue
    }
    var md5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return String(format: hash as String)
    }

    /// url编码
    ///
    /// - Returns: NSString
    func urlEncode() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: KUrlCodingReservedCharacters).inverted)!

    }

    /// url解码
    ///
    /// - Returns: NSString
    func urlDecode() -> String? {
        return self.removingPercentEncoding
    }

    // 保留两位小数
    func remainTwoDecimal() -> String {
        return String(format: "%.2f", floatValue)
    }

    // 保留五位小数
    func remainFiveDecimal() -> String {
        return String(format: "%.5f", floatValue)
    }

    // 判断纯中文
    func isOnlyChinese() -> Bool{
        let match: String = "(^[\\u4e00-\\u9fa5]+$)"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }

    // 判断纯数字
    func isOnlyNumbers() -> Bool{
        let match: String = "[0-9]*"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }

    // 判断纯字母
    func isOnlyLetters() -> Bool{
        let match: String = "[a-zA-Z]*"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }

    // 判断只有字母或数字
    func isOnlyAlphaNumeric() -> Bool{
        let match: String = "[a-zA-Z0-9]*"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }

    // MARK: - 时间戳相关
    func formatTimeWithRex(rex: String) -> String {
        let string = NSString.init(string: self)
        let timeSta: TimeInterval = string.doubleValue
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = rex
        let date = Date.init(timeIntervalSince1970: timeSta)
        return timeFormatter.string(from: date)
    }

    // 根据时间格式把当前时间戳转为时间
    func getCurrentTime() -> String {
        let date = Date()
        let timeFormatter = DateFormatter()
        //        timeFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm:ss.SSS"
        timeFormatter.dateFormat = self
        let strNowTime = timeFormatter.string(from: date) as String
        //        print("系统当前时间：\(strNowTime)")
        //        print("系统当前时间戳：\(date.timeIntervalSince1970)")
        return strNowTime
    }

    /**
     根据字体和宽度计算文字高度

     - parameter width: 约束宽度
     - parameter font:  字体大小

     - returns: 高度
     */
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)

        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return boundingBox.height
    }

    func heightWithConstrainedWidth(width: CGFloat, attr: [NSAttributedString.Key: Any]?) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)

        let boundingBox = self.boundingRect(with: constraintRect, options: [NSStringDrawingOptions.usesLineFragmentOrigin], attributes: attr, context: nil)

        return boundingBox.height
    }

    /**
     根据字体和宽度计算文字宽度

     - parameter width: 约束宽度
     - parameter font:  字体大小

     - returns: 宽度
     */
    func widthWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)

        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return boundingBox.width
    }

    func widthWithConstrainedWidth(width: CGFloat, attr: [NSAttributedString.Key: Any]?) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)

        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attr, context: nil)

        return boundingBox.width
    }

    /**
     将json字符串转dic
     */
    func getDictionaryFromJSONString() -> NSDictionary{

        let jsonData:Data = self.data(using: .utf8)!

        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()


    }
    /**
     将json字符串转数组
     */
    func getArrayFromJSONString() -> NSArray{

        let jsonData:Data = self.data(using: .utf8)!

        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! NSArray
        }
        return array as! NSArray

    }
}

