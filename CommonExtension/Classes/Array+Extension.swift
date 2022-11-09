//
//  Array+Extension.swift
//  SpeedR_Extension
//
//  Created by 袁杰 on 2022/11/3.
//

import Foundation

public extension Array {
    func toJsonString() -> String {
        guard JSONSerialization.isValidJSONObject(self) else { return "" }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return "" }
        guard let JSONString = String(data: data, encoding: .utf8) else { return "" }
        return JSONString
    }
}
