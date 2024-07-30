//
//  Global.swift
//  CommonExtension
//
//  Created by 袁杰 on 2024/7/30.
//

import Foundation

func generateStructFromJSON(jsonString: String, structName: String, protocolName: String) -> String {
    // Parse JSON string into data
    guard let jsonData = jsonString.data(using: .utf8) else {
        return "Invalid JSON string"
    }
    
    // Use JSONSerialization to parse JSON data into dictionary
    guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
        return "Failed to parse JSON data"
    }
    
    // Helper function to recursively generate struct properties
    func generateProperties(from dictionary: [String: Any], indentation: Int) -> String {
        var properties = ""
        
        for (key, value) in dictionary {
            var propertyType = ""
            var defaultValue = ""
            
            switch value {
            case is Int:
                propertyType = "Int"
                defaultValue = " = 0"
            case is String:
                propertyType = "String"
                defaultValue = " = \"\""
            case is Double:
                propertyType = "Double"
                defaultValue = " = 0.0"
            case is Bool:
                propertyType = "Bool"
                defaultValue = " = false"
            case is [String: Any]:
                let nestedStructName = "\(key.capitalized)"
                properties += String(repeating: "    ", count: indentation)
                properties += "struct \(nestedStructName): \(protocolName) {\n"
                properties += generateProperties(from: value as! [String: Any], indentation: indentation + 1)
                properties += String(repeating: "    ", count: indentation)
                properties += "}\n"
                propertyType = nestedStructName
            case is [[String: Any]]:
                if let firstElement = (value as! [[String: Any]]).first {
                    let nestedStructName = "\(key.capitalized)Element"
                    properties += String(repeating: "    ", count: indentation)
                    properties += "struct \(nestedStructName): \(protocolName) {\n"
                    properties += generateProperties(from: firstElement, indentation: indentation + 1)
                    properties += String(repeating: "    ", count: indentation)
                    properties += "}\n"
                    propertyType = "[\(nestedStructName)]"
                } else {
                    propertyType = "[Any]"
                    defaultValue = " = []"
                }
            default:
                propertyType = "Any"
                defaultValue = " = nil"
            }
            
            properties += String(repeating: "    ", count: indentation)
            properties += "var \(key): \(propertyType)\(defaultValue)\n"
        }
        
        return properties
    }
    
    // Generate properties from top-level dictionary
    let structProperties = generateProperties(from: jsonObject, indentation: 1)
    
    // Construct the final struct string
    var structString = "struct \(structName): \(protocolName) {\n"
    structString += structProperties
    structString += "}\n"
    
    // Fix data array initialization
    structString = structString.replacingOccurrences(of: "var data: [DataElement]", with: "var data: [DataElement] = [DataElement]()")
    
    return structString
}
