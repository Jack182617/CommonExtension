//
//  String+Extension.swift
//  SpeedR_Extension
//
//  Created by 袁杰 on 2022/9/27.
//

import Foundation
import CommonCrypto
import CoreLocation

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

    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }

    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }

    /*
     *去掉所有空格
     */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /*
     *去掉所有换行
     */
    var removeAllLine: String {
        return self.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
    }

    /// url编码
    func urlEncode() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: KUrlCodingReservedCharacters).inverted)!

    }

    /// url解码
    func urlDecode() -> String? {
        return self.removingPercentEncoding
    }

    // 保留小数
    func remainDecimal(position: Int) -> String {
        return String(format: "%.\(position)f", floatValue)
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

    /**
     判断是否包含该中文
     */
    func containChinese(str:NSString) -> Bool{
        for i in 0 ..< str.length {
            let a = str.character(at: i)
            if a > 0x4e00 && a < 0x9fff {
                return true
            }
        }
        return false
    }

    // MARK:- 判断是否满足正则表达式
    func fulfilRegularExpression(regex:String) -> Bool {
        var result = false
        let test = NSPredicate(format: "SELF MATCHES %@" , regex)

        result = (test.evaluate(with: self))

        return result;
    }

    //判断是否是URL地址
    func isURL() -> Bool {

        var result1 = false
        var result2 = false

        let urlRegex1 = "^https://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
        let urlTest1 = NSPredicate(format: "SELF MATCHES %@" , urlRegex1)

        result1 = (urlTest1.evaluate(with: self))

        let urlRegex2 = "^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
        let urlTest2 = NSPredicate(format: "SELF MATCHES %@" , urlRegex2)

        result2 = (urlTest2.evaluate(with: self))

        return result1 || result2
    }

    //验证电话号码
    func isPhoneNumber() -> Bool {

        var result = false

        let phoneRegex = "^((13[0-9])|(17[0-9])|(19[0-9])|(14[^4,\\D])|(15[^4,\\D])|(18[0-9]))\\d{8}$|^1(7[0-9])\\d{8}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@" , phoneRegex)

        result = (phoneTest.evaluate(with: self))

        return result;
    }

    //验证邮箱格式
    func isZipCodeNumber() -> Bool {
        if self.count == 0 {
            return false
        }
        let zipCodeNumber = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let regexCodeNumber = NSPredicate(format: "SELF MATCHES %@",zipCodeNumber)
        if regexCodeNumber.evaluate(with: self) == true {
            return true
        }else
        {
            return false
        }
    }

    //判断是否是身份证号
    func isUserIdCard() -> Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }

    // 富文本字符串
    func attributedString(attrs: [NSAttributedString.Key : Any], range: NSRange, lineSpace: CGFloat? = 0.0, alignment: NSTextAlignment? = .left) -> NSMutableAttributedString{
        let attributeStr = NSMutableAttributedString.init(string: self)
        let paragrapStyle = NSMutableParagraphStyle.init()
        paragrapStyle.alignment = alignment!
        paragrapStyle.lineSpacing = lineSpace!
        var attArr = attrs
        attArr[NSAttributedString.Key.paragraphStyle] = paragrapStyle
        attributeStr.addAttributes(attrs, range: range)

        return attributeStr
    }

    //打电话
    func callPhone() {
        let urlString = "tel://" + self
        if let url = URL(string: urlString) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                    (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    //截取字符串
    func subStrToIndex(index: Int) -> String {
        return (self as NSString).substring(to: index)
    }

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
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

    //计算两个经纬度点的直线距离
    func getDistanceBetweenFromCoor(coor1: CLLocationCoordinate2D, coor2: CLLocationCoordinate2D) -> Double{
        let curLocation = CLLocation.init(latitude: coor1.latitude, longitude: coor1.longitude)
        let otherLocation = CLLocation.init(latitude: coor2.latitude, longitude: coor2.longitude)
        return curLocation.distance(from: otherLocation)
    }

    //非对称加密算法
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))

        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)

        let digest = stringFromResult(result: result, length: digestLen)

        result.deallocate()
        return digest
    }

    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash).lowercased()
    }

    //非对称加密算法相关
    enum CryptoAlgorithm {
        case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

        var HMACAlgorithm: CCHmacAlgorithm {
            var result: Int = 0
            switch self {
            case .MD5:      result = kCCHmacAlgMD5
            case .SHA1:     result = kCCHmacAlgSHA1
            case .SHA224:   result = kCCHmacAlgSHA224
            case .SHA256:   result = kCCHmacAlgSHA256
            case .SHA384:   result = kCCHmacAlgSHA384
            case .SHA512:   result = kCCHmacAlgSHA512
            }
            return CCHmacAlgorithm(result)
        }

        var digestLength: Int {
            var result: Int32 = 0
            switch self {
            case .MD5:      result = CC_MD5_DIGEST_LENGTH
            case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
            case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
            case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
            case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
            case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
            }
            return Int(result)
        }
    }
}


