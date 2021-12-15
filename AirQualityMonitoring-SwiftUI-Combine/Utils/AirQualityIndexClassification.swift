//
//  AirQualityIndexClassification.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import UIKit
import SwiftUI

enum AirQualityIndexClassification {
    case good
    case satisfactory
    case moderate
    case poor
    case veryPoor
    case severe
    case outOfRange
}

class AirQualityIndexClassifier {
    static func classifyAirQualityIndex(aqi: Double) -> AirQualityIndexClassification {
        switch aqi {
        
        case 0...50:
            return .good
        
        case 50...100:
            return .satisfactory
        
        case 100...200:
            return .moderate
        
        case 200...300:
            return .poor
        
        case 300...400:
            return .veryPoor
        
        case 400...500:
            return .severe
        
        default:
            return .outOfRange
        }
    }
}

struct AirQualityIndexInfoClassifier {
    static func color(index: AirQualityIndexClassification) -> UIColor {
        switch index {
       
        case .good:
            return UIColor(hexString: "#55A84F")
            
        case .satisfactory:
            return UIColor(hexString: "#A3C853")
            
        case .moderate:
            return UIColor(hexString: "#FCF834")
            
        case .poor:
            return UIColor(hexString: "#EE9A32")
            
        case .veryPoor:
            return UIColor(hexString: "#DE3B30")
            
        case .severe:
            return UIColor(hexString: "#A72B22")
            
        case .outOfRange:
            return UIColor(hexString: "#A72B22")
            
        }
    }
    
    static func text(index: AirQualityIndexClassification) -> String {
        switch index {
       
        case .good:
            return "Good"
            
        case .satisfactory:
            return "Satisfactory"
            
        case .moderate:
            return "Moderate"
            
        case .poor:
            return "Poor"
            
        case .veryPoor:
            return "Very Poor"
            
        case .severe:
            return "Severe"
            
        case .outOfRange:
            return "Out Of Range"
            
        }
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

extension UIColor {
    /// The SwiftUI color associated with the receiver.
    var suColor: Color { Color(self) }
}
