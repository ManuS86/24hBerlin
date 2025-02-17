//
//  UIDevice Extension.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 03.02.25.
//

import UIKit

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)
        let identifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToModel(identifier: String) -> String {
            switch identifier {
            case "iPhone10,1", "iPhone10,4": return "iPhone X"
            case "iPhone11,2": return "iPhone XS"
            case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
            case "iPhone12,1": return "iPhone 11"
            case "iPhone12,3": return "iPhone 11 Pro"
            case "iPhone12,5": return "iPhone 11 Pro Max"
            default: return identifier
            }
        }

        return mapToModel(identifier: identifier)
    }
}
