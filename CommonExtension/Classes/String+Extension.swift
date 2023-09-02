//
//  String+Extension.swift
//  
//
//  Created by Jack on 2022/9/27.
//

import Foundation
import CommonCrypto
import CoreLocation

let KUrlCodingReservedCharacters = "!*'();:|@&=+$,/?%#[]{}"

// MARK: - String
public extension String{
    // String to float
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
     *Remove first and last spaces
     */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }

    /*
     *
     Remove the first and last spaces, including the following line breaks n
     */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }

    /*
     *Remove all spaces
     */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /*
     *Remove all line breaks
     */
    var removeAllLine: String {
        return self.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
    }

    /// url code
    func urlEncode() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: KUrlCodingReservedCharacters).inverted)!

    }

    /// url decode
    func urlDecode() -> String? {
        return self.removingPercentEncoding
    }

    // Retain Decimals
    func remainDecimal(position: Int) -> String {
        return String(format: "%.\(position)f", floatValue)
    }

    // Judging pure Chinese
    func isOnlyChinese() -> Bool{
        let match: String = "(^[\\u4e00-\\u9fa5]+$)"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }

    // Judge pure numbers
    func isOnlyNumbers() -> Bool{
        let match: String = "[0-9]*"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }

    // Judge pure letters
    func isOnlyLetters() -> Bool{
        let match: String = "[a-zA-Z]*"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }

    // Determine if there are only letters or numbers
    func isOnlyAlphaNumeric() -> Bool{
        let match: String = "[a-zA-Z0-9]*"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }

    /**
     Determine if the Chinese language is included
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

    // MARK:- Determine whether the regular expression is met
    func fulfilRegularExpression(regex:String) -> Bool {
        var result = false
        let test = NSPredicate(format: "SELF MATCHES %@" , regex)

        result = (test.evaluate(with: self))

        return result;
    }

    // Determine if it is a URL address
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

    // Verify phone number
    func isPhoneNumber() -> Bool {

        var result = false

        let phoneRegex = "^((13[0-9])|(17[0-9])|(19[0-9])|(14[^4,\\D])|(15[^4,\\D])|(18[0-9]))\\d{8}$|^1(7[0-9])\\d{8}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@" , phoneRegex)

        result = (phoneTest.evaluate(with: self))

        return result;
    }

    // Verify email format
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

    // Judge whether it is ID number
    func isUserIdCard() -> Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }

    // Rich Text String
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

    // call
    func callPhone() {
        let urlString = "tel://" + self
        if let url = URL(string: urlString) {
            //
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

    //
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

    // MARK: - Timestamp related
    func formatTimeWithRex(rex: String) -> String {
        let string = NSString.init(string: self)
        let timeSta: TimeInterval = string.doubleValue
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = rex
        let date = Date.init(timeIntervalSince1970: timeSta)
        return timeFormatter.string(from: date)
    }

    //
    func getCurrentTime() -> String {
        let date = Date()
        let timeFormatter = DateFormatter()
        //        timeFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm:ss.SSS"
        timeFormatter.dateFormat = self
        let strNowTime = timeFormatter.string(from: date) as String
        return strNowTime
    }

    /**
     Calculate text height based on font and width

     - parameter width
     - parameter font

     - returns
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
     Calculate text width based on font and width

     - parameter width
     - parameter font

     - returns
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
     Convert JSON string to DIC
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
     Convert JSON strings into arrays
     */
    func getArrayFromJSONString() -> NSArray{

        let jsonData:Data = self.data(using: .utf8)!

        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! NSArray
        }
        return array as! NSArray

    }

    // Calculate the straight-line distance between two latitude and longitude points
    func getDistanceBetweenFromCoor(coor1: CLLocationCoordinate2D, coor2: CLLocationCoordinate2D) -> Double{
        let curLocation = CLLocation.init(latitude: coor1.latitude, longitude: coor1.longitude)
        let otherLocation = CLLocation.init(latitude: coor2.latitude, longitude: coor2.longitude)
        return curLocation.distance(from: otherLocation)
    }

    // Asymmetric encryption algorithm
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

    // Asymmetric encryption algorithm related
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
    
    // AESSBC encryption
    func aesCBCEncrypt(key: Data, iv: Data) -> Data? {
        let data = self.data(using: .utf8)
        let bufferSize = data!.count + kCCBlockSizeAES128
        var buffer = [UInt8](repeating: 0, count: bufferSize)

        var numBytesEncrypted = 0

        let cryptStatus = key.withUnsafeBytes { keyBytes in
            iv.withUnsafeBytes { ivBytes in
                data!.withUnsafeBytes { dataBytes in
                    CCCrypt(
                        CCOperation(kCCEncrypt),
                        CCAlgorithm(kCCAlgorithmAES128),
                        CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress,
                        key.count,
                        ivBytes.baseAddress,
                        dataBytes.baseAddress,
                        data!.count,
                        &buffer,
                        bufferSize,
                        &numBytesEncrypted
                    )
                }
            }
        }

        if cryptStatus == kCCSuccess {
            return Data(buffer[..<numBytesEncrypted])
        } else {
            return nil
        }
    }
}


