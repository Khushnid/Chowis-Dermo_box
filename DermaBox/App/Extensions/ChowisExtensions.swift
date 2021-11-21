//
//  ChowisExtensions.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/19.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension UILabel {
 
    func addAttribute(fullText: String, attributedText: String, atrributedColor: UIColor? = nil, attributedFont: UIFont? = nil) {
        
        self.text = fullText
        
        let attributedFullText = NSMutableAttributedString(attributedString: self.attributedText ?? NSMutableAttributedString(string: ""))
        let range = NSString(string: fullText.localized).range(of: attributedText.localized)
        if let color = atrributedColor {
            
            let attributes = [NSAttributedString.Key.foregroundColor: color]
            attributedFullText.addAttributes(attributes, range: range)
        }
        
        if let font = attributedFont {
            
            let attributes = [NSAttributedString.Key.font: font]
            attributedFullText.addAttributes(attributes as [NSAttributedString.Key : Any], range: range)
        }
        
        self.attributedText = attributedFullText
    }
}

extension Date {
    
    var toUnixTime:Int64 {

        return Int64(self.timeIntervalSince1970)
    }

    init(milliseconds:Int64) {

        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    var yesterday: Date {
       
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    }
    
    var getAge: Int {
        
        let calendar = NSCalendar(calendarIdentifier: .gregorian)
        let calcAge = calendar?.components(.year, from: self, to: Device.date, options: [])
        guard let age = calcAge?.year else { return 0 }
        return age
    }
    
    func formatDateToString(withString stringFormat: String) -> String {
        DateFormatterHelper.shared.dateFormatter.dateFormat = stringFormat
        let currentLanguage = defaults.value(forKey: CURRENT_LANGUAGE) as? String ?? "en"
        DateFormatterHelper.shared.dateFormatter.locale = Locale(identifier: currentLanguage)
        return DateFormatterHelper.shared.dateFormatter.string(from: self)
    }
}

class DateFormatterHelper {
    static let shared = DateFormatterHelper()
    let dateFormatter = DateFormatter()
}


extension String {
    
    var localized: String {
        return Util.shared.localize(key: self)
    }
}

extension UIView {
    
        @discardableResult
        func applyGradientForView(colours: [UIColor]) -> CAGradientLayer {
            return self.applyGradientForView(colours: colours, cornerRadius: 0.0)
        }

        @discardableResult
        func applyGradientForView(colours: [UIColor], cornerRadius: CGFloat) -> CAGradientLayer {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colours.map { $0.cgColor }
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
            gradient.cornerRadius = cornerRadius
            gradient.masksToBounds = false
            self.clipsToBounds = true
            self.layer.insertSublayer(gradient, at: 0)
            return gradient
        }
    
    func drawDot(withColor color:UIColor, isHorizontal: Bool)  {
    
        if let layers = self.layer.sublayers {

            for layer in layers {

                layer.removeFromSuperlayer()
            }
        }
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineDashPattern = [9,6]
        let frameSize = self.frame.size
        
        if isHorizontal {
            
            let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: 0)
            shapeLayer.bounds = shapeRect
            shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height)
            shapeLayer.lineWidth = frameSize.height
            shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: shapeRect.height, width: shapeRect.width, height: 0), cornerRadius: 0).cgPath
            
        } else {
            
            let shapeRect = CGRect(x: 0, y: 0, width: 0, height: frameSize.height)
            shapeLayer.bounds = shapeRect
            shapeLayer.position = CGPoint(x: frameSize.width, y: frameSize.height/2)
            shapeLayer.lineWidth = frameSize.width
            shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: shapeRect.width, y: 0, width: 0, height: shapeRect.height), cornerRadius: 0).cgPath
        }
    
        self.layer.addSublayer(shapeLayer)
    }
    
    // Using a function since `var image` might conflict with an existing variable
       // (like on `UIImageView`)
    //converting view as UIImage
    func asImage() -> UIImage {
           let renderer = UIGraphicsImageRenderer(bounds: bounds)
           return renderer.image { rendererContext in
               layer.render(in: rendererContext.cgContext)
           }
       }
}

extension UITextField {

    enum PaddingSide {
        
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}

extension NSMutableAttributedString {
    
    func setColorForText(_ textToFind: String, with color: UIColor) {
        
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
    
    func setBackgroundColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.backgroundColor, value: color, range: range)
        }
    }
} 

extension Optional {
    
    func getOrDefault<T>(_ value: T, isEmptyIncluded: Bool = false) -> T {
        switch(self) {
        case .none:
            return value
        case .some(let valued):
            return valued as! T
        }
    }
}

extension AVCaptureVideoOrientation {
    init?(deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeRight
        case .landscapeRight: self = .landscapeLeft
        default: return nil
        }
    }

    init?(interfaceOrientation: UIInterfaceOrientation) {
        switch interfaceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeLeft
        case .landscapeRight: self = .landscapeRight
        default: return nil
        }
    }
}

extension Bundle {
    
    var releaseVersionNumber: String? {
        
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone5,1": return "iPhone 5 (GSM)"
        case "iPhone5,2": return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3": return "iPhone 5c (GSM)"
        case "iPhone5,4": return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1": return "iPhone 5s (GSM)"
        case "iPhone6,2": return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1": return "iPhone 7"
        case "iPhone9,3": return "iPhone 7"
        case "iPhone9,2": return "iPhone 7 Plus"
        case "iPhone9,4": return "iPhone 7 Plus"
        case "iPhone10,1": return "iPhone 8"
        case "iPhone10,2": return "iPhone 8 Plus"
        case "iPhone10,3": return "iPhone X"
        case "iPhone10,4": return "iPhone 8"
        case "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,6": return "iPhone X"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4": return "iPhone XS MAX"
        case "iPhone11,6": return "iPhone XS MAX"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone12,8": return "iPhone SE 2nd Gen"
        case "iPhone13,1": return "iPhone 12 Mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1": return "2nd Gen iPad"
        case "iPad2,2": return "2nd Gen iPad GSM"
        case "iPad2,3": return "2nd Gen iPad CDMA"
        case "iPad2,4": return "2nd Gen iPad New Revision"
        case "iPad3,1": return "3rd Gen iPad"
        case "iPad3,2": return "3rd Gen iPad CDMA"
        case "iPad3,3": return "3rd Gen iPad GSM"
        case "iPad2,5": return "iPad mini"
        case "iPad2,6": return "iPad mini GSM+LTE"
        case "iPad2,7": return "iPad mini CDMA+LTE"
        case "iPad3,4": return "4th Gen iPad"
        case "iPad3,5": return "4th Gen iPad GSM+LTE"
        case "iPad3,6": return "4th Gen iPad CDMA+LTE"
        case "iPad4,1": return "iPad Air (WiFi)"
        case "iPad4,2": return "iPad Air (GSM+CDMA)"
        case "iPad4,3": return "1st Gen iPad Air (China)"
        case "iPad4,4": return "iPad mini Retina (WiFi)"
        case "iPad4,5": return "iPad mini Retina (GSM+CDMA)"
        case "iPad4,6": return "iPad mini Retina (China)"
        case "iPad4,7": return "iPad mini 3 (WiFi)"
        case "iPad4,8": return "iPad mini 3 (GSM+CDMA)"
        case "iPad4,9": return "iPad Mini 3 (China)"
        case "iPad5,1": return "iPad mini 4 (WiFi)"
        case "iPad5,2": return "4th Gen iPad mini (WiFi+Cellular)"
        case "iPad5,3": return "iPad Air 2 (WiFi)"
        case "iPad5,4": return "iPad Air 2 (Cellular)"
        case "iPad6,3": return "iPad Pro (9.7 inch, WiFi)"
        case "iPad6,4": return "iPad Pro (9.7 inch, WiFi+LTE)"
        case "iPad6,7": return "iPad Pro (12.9 inch, WiFi)"
        case "iPad6,8": return "iPad Pro (12.9 inch, WiFi+LTE)"
        case "iPad6,11": return "iPad (2017)"
        case "iPad6,12": return "iPad (2017)"
        case "iPad7,1": return "iPad Pro 2nd Gen (WiFi)"
        case "iPad7,2": return "iPad Pro 2nd Gen (WiFi+Cellular)"
        case "iPad7,3": return "iPad Pro 10.5-inch"
        case "iPad7,4": return "iPad Pro 10.5-inch"
        case "iPad7,5": return "iPad 6th Gen (WiFi)"
        case "iPad7,6": return "iPad 6th Gen (WiFi+Cellular)"
        case "iPad7,11": return "iPad 7th Gen 10.2-inch (WiFi)"
        case "iPad7,12": return "iPad 7th Gen 10.2-inch (WiFi+Cellular)"
        case "iPad8,1": return "iPad Pro 11 inch 3rd Gen (WiFi)"
        case "iPad8,2": return "iPad Pro 11 inch 3rd Gen (1TB, WiFi)"
        case "iPad8,3": return "iPad Pro 11 inch 3rd Gen (WiFi+Cellular)"
        case "iPad8,4": return "iPad Pro 11 inch 3rd Gen (1TB, WiFi+Cellular)"
        case "iPad8,5": return "iPad Pro 12.9 inch 3rd Gen (WiFi)"
        case "iPad8,6": return "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi)"
        case "iPad8,7": return "iPad Pro 12.9 inch 3rd Gen (WiFi+Cellular)"
        case "iPad8,8": return "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi+Cellular)"
        case "iPad8,9": return "iPad Pro 11 inch 4th Gen (WiFi)"
        case "iPad8,10": return "iPad Pro 11 inch 4th Gen (WiFi+Cellular)"
        case "iPad8,11": return "iPad Pro 12.9 inch 4th Gen (WiFi)"
        case "iPad8,12": return "iPad Pro 12.9 inch 4th Gen (WiFi+Cellular)"
        case "iPad11,1": return "iPad mini 5th Gen (WiFi)"
        case "iPad11,2": return "iPad mini 5th Gen"
        case "iPad11,3": return "iPad Air 3rd Gen (WiFi)"
        case "iPad11,4": return "iPad Air 3rd Gen"
        case "iPad11,6": return "iPad 8th Gen (WiFi)"
        case "iPad11,7": return "iPad 8th Gen (WiFi+Cellular)"
        case "iPad13,1": return "iPad air 4th Gen (WiFi)"
        case "iPad13,2": return "iPad air 4th Gen (WiFi+Cellular)"
        default: return identifier
        }
    }
    
    var resolution: String {
        let bounds: CGRect = UIScreen.main.bounds
        let width = Int(bounds.size.width)
        let height = Int(bounds.size.height)
        let resolutionsize = "\(width)x\(height)"
        return resolutionsize
    }
}

extension UIButton {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, cornerRadius: 0.0)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], cornerRadius: CGFloat) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = cornerRadius
        gradient.masksToBounds = false
        self.clipsToBounds = true
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

public func openWifiSettings() {
    let shared = UIApplication.shared
    let url = URL(string: UIApplication.openSettingsURLString)!
    shared.open(url)
}

 
