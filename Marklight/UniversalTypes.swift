//
//  UniversalTypes.swift
//  Marklight
//
//  Created by Christian Tietze on 20.07.17.
//  Copyright © 2017 MacTeo. See LICENSE for details.
//

#if os(iOS)
    import UIKit

    public typealias MarklightColor = UIColor
    public typealias MarklightFont = UIFont
    public typealias MarklightFontDescriptor = UIFontDescriptor

    extension UIColor {
        typealias Name = String
        
        public convenience init?(named: String, bundle: Bundle?) {
					self.init(named: named, in: bundle, compatibleWith: nil)
				}
				
				static var textColor: UIColor {
					if #available(iOS 13.0, *) {
						return self.label
					} else {
						return self.black
					}
				}
    }
#elseif os(macOS)
    import AppKit

    public typealias MarklightColor = NSColor
    public typealias MarklightFont = NSFont
    public typealias MarklightFontDescriptor = NSFontDescriptor

    extension NSFont {
        static func italicSystemFont(ofSize size: CGFloat) -> NSFont {
            return NSFontManager().convert(NSFont.systemFont(ofSize: size), toHaveTrait: .italicFontMask)
        }
    }
#endif

class MarklightColorStub {}

public extension MarklightColor {
    static var syntaxColor: MarklightColor {
        return MarklightColor(named: MarklightColor.Name("Syntax"), bundle: Bundle(for: MarklightColorStub.self))!
    }

    static var codeColor: MarklightColor {
        return MarklightColor(named: MarklightColor.Name("Code"), bundle: Bundle(for: MarklightColorStub.self))!
    }

    static var quoteColor: MarklightColor {
        return MarklightColor(named: MarklightColor.Name("Quote"), bundle: Bundle(for: MarklightColorStub.self))!
    }
}
