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

    extension UIFont {
    		func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
    				let descriptor = fontDescriptor.withSymbolicTraits(traits)
    				return UIFont(descriptor: descriptor!, size: self.pointSize) //size 0 means keep the size as it is
				}
				func italic() -> UIFont {
						return self.withTraits(traits: .traitItalic)
				}
				func bold() -> UIFont {
						return self.withTraits(traits: .traitBold)
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

				func italic() -> NSFont {
						return NSFontManager().convert(self, toHaveTrait: .italicFontMask)
				}

				func bold() -> NSFont {
						return NSFontManager().convert(self, toHaveTrait: .boldFontMask)
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

public extension MarklightFont {
    static var monospacedFont: MarklightFont {
        if #available(OSX 10.15, iOS 13.0, *) {
            return MarklightFont.monospacedSystemFont(ofSize: MarklightFont.systemFontSize, weight: .regular)
        }
#if os(macOS)
        if let font = MarklightFont.userFixedPitchFont(ofSize: MarklightFont.systemFontSize) {
            return font
        }
#endif
        return MarklightFont.systemFont(ofSize: MarklightFont.systemFontSize)
    }

    static var monospacedBoldFont: MarklightFont {
        return self.monospacedFont.bold()
		}

    static var monospacedItalicFont: MarklightFont {
        return self.monospacedFont.italic()
    }

    static var boldFont: MarklightFont {
        return MarklightFont.boldSystemFont(ofSize: MarklightFont.systemFontSize)
    }

    static var italicFont: MarklightFont {
        return MarklightFont.italicSystemFont(ofSize: MarklightFont.systemFontSize)
    }
}
