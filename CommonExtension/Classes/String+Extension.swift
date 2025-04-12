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
public extension String {
    var intValue: Int { (self as NSString).integerValue }
    var floatValue: Float { (self as NSString).floatValue }
    var doubleValue: Double { (self as NSString).doubleValue }
}
public extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimmedSpaces: String {
        trimmingCharacters(in: .whitespaces)
    }
    
    var removedAllSpaces: String {
        replacingOccurrences(of: " ", with: "")
    }
    
    var removedAllNewLines: String {
        replacingOccurrences(of: "\n", with: "")
    }
}
public extension String {
    func matches(regex: String) -> Bool {
        var result = false
        let test = NSPredicate(format: "SELF MATCHES %@" , regex)
        
        result = (test.evaluate(with: self))
        
        return result
    }
    var isOnlyChinese: Bool {
        let match: String = "(^[\\u4e00-\\u9fa5]+$)"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }
    var isOnlyNumbers: Bool {
        let match: String = "[0-9]*"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }
    var isOnlyLetters: Bool {
        let match: String = "[a-zA-Z]*"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }
    var isEmail: Bool {
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
    var isIDCardNumber: Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }
    var isURL: Bool {
        
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
    func containsChinese() -> Bool {
        for i in 0 ..< (self as NSString).length {
            let a = (self as NSString).character(at: i)
            if a > 0x4e00 && a < 0x9fff {
                return true
            }
        }
        return false
    }
}
public extension String {
    var urlEncoded: String? {
        addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: KUrlCodingReservedCharacters).inverted)
    }
    
    var urlDecoded: String? {
        removingPercentEncoding
    }
}
public extension String {
    func toAttributedString(
        attributes: [NSAttributedString.Key: Any],
        range: NSRange,
        lineSpacing: CGFloat = 0,
        alignment: NSTextAlignment = .left
    ) -> NSMutableAttributedString {
        let attributeStr = NSMutableAttributedString.init(string: self)
        let paragrapStyle = NSMutableParagraphStyle.init()
        paragrapStyle.alignment = alignment
        paragrapStyle.lineSpacing = lineSpacing
        var attArr = attributes
        attArr[NSAttributedString.Key.paragraphStyle] = paragrapStyle
        attributeStr.addAttributes(attributes, range: range)
        
        return attributeStr
    }
}
public extension String {
    func formatTimestamp(using format: String) -> String {
        let string = NSString.init(string: self)
        let timeSta: TimeInterval = string.doubleValue
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = format
        let date = Date.init(timeIntervalSince1970: timeSta)
        return timeFormatter.string(from: date)
    }
}
public extension String {
    ///
    func height(forWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        
        let boundingBox = self.boundingRect(
            with: constraintSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return ceil(boundingBox.height)
    }
    
    ///
    func width(forHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: .greatestFiniteMagnitude, height: height)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        
        let boundingBox = self.boundingRect(
            with: constraintSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return ceil(boundingBox.width)
    }
    func size(constrainedTo width: CGFloat, attributes: [NSAttributedString.Key: Any]?) -> CGSize {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: [NSStringDrawingOptions.usesLineFragmentOrigin], attributes: attributes, context: nil)
        
        return boundingBox.size
    }
}
public extension String {
    var jsonToDictionary: [String: Any]? {
        guard let data = self.data(using: .utf8),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return dict
    }
    
    var jsonToArray: [Any]? {
        guard let data = self.data(using: .utf8),
              let array = try? JSONSerialization.jsonObject(with: data) as? [Any] else {
            return nil
        }
        return array
    }
}
public extension String {
    func subStrToIndex(index: Int) -> String {
        return (self as NSString).substring(to: index)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        } catch {
            return NSAttributedString()
        }
    }
    
    func toBase64() -> String{
        if let data = self.data(using: .utf8) {
            let base64String = data.base64EncodedString()
            return base64String
        } else {
            return ""
        }
    }
    
    func fromBase64() -> String{
        if let data = Data(base64Encoded: self) {
            if let decodedString = String(data: data, encoding: .utf8) {
                return decodedString
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
}
public extension String {
    func callPhoneNumber() {
        guard let url = URL(string: "tel://\(self)") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
public extension String {
    static func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let loc1 = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let loc2 = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return loc1.distance(from: loc2)
    }
}
public extension String {
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
    
    func aesCBCDecrypt(key: Data, iv: Data) -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        
        let bufferSize = data.count + kCCBlockSizeAES128
        var buffer = [UInt8](repeating: 0, count: bufferSize)
        
        var numBytesDecrypted = 0
        
        let cryptStatus = key.withUnsafeBytes { keyBytes in
            iv.withUnsafeBytes { ivBytes in
                data.withUnsafeBytes { dataBytes in
                    CCCrypt(
                        CCOperation(kCCDecrypt),
                        CCAlgorithm(kCCAlgorithmAES128),
                        CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress,
                        key.count,
                        ivBytes.baseAddress,
                        dataBytes.baseAddress,
                        data.count,
                        &buffer,
                        bufferSize,
                        &numBytesDecrypted
                    )
                }
            }
        }
        
        if cryptStatus == kCCSuccess {
            let decryptedData = Data(buffer[..<numBytesDecrypted])
            return String(data: decryptedData, encoding: .utf8)
        } else {
            return nil
        }
    }
}
