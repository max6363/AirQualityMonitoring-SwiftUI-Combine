//
//  AirQualityIndexClassification.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import UIKit
import SwiftUI

/// Air quality classification.
///
/// Classification based on the Air Quality impacting on health.
public enum AirQualityIndexClassification {
    
    /// Air quality is satisfactory, and air pollution poses little or no risk.
    case good
    
    /// Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution.
    case satisfactory
    
    /// Members of sensitive groups may experience health effects. The general public is less likely to be affected.
    case moderate
    
    /// Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects.
    case poor
    
    /// Health alert: The risk of health effects is increased for everyone.
    case veryPoor
    
    /// Health warning of emergency conditions: everyone is more likely to be affected.
    case severe
    
    /// Out of Range
    case outOfRange
}

/// Air quality classifier
public class AirQualityIndexClassifier {
    
    /// Get `AirQualityIndexClassification`
    ///
    /// Use this method to get classification with the 'Air Quality Index - Double' value
    /// - Parameter aqi: air quality index value in `Double`
    /// - Returns: `AirQualityIndexClassification` value. i.e. Good, Satisfactory etc.
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

/// Air quality information classifier
public struct AirQualityIndexInfoClassifier {
    
    /// A method to get color indicator based on index
    /// - Parameter index: Air quality index range - `AirQualityIndexClassification`
    /// - Returns: `UIColor` value with provided classification value
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
    
    /// A method to get information text
    /// - Parameter index: Air quality index range - `AirQualityIndexClassification`
    /// - Returns: Air quality information text - `String`
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

/// `UIColor` extension
///
/// Helper methods
public extension UIColor {
    
    /// Initialize `UIColor` from given parameters
    /// - Parameters:
    ///   - hexString: a given color hexString - `String`
    ///   - alpha: a given alpha value - `CGFloat`
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

/// `UIColor` extension
///
/// Helper methods
public extension UIColor {
    /// The SwiftUI color associated with the receiver.
    var suColor: Color { Color(self) }
}
