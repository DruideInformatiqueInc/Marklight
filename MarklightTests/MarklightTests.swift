//
//  MarklightTests.swift
//  MarklightTests
//
//  Created by Matteo Gavagnin on 30/12/15.
//  Copyright © 2016 MacTeo. All rights reserved.
//

import XCTest
@testable import Marklight

class MarklightTests: XCTestCase {
    let textStorage = MarklightTextStorage()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testAtxH1() {
        let string = ["# Header", ""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
    }
    
    func testAtxH2() {
        let string = ["## Header ##", ""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 2)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.font, at: 2, effectiveRange: &range!) as? MarklightFont {
            XCTAssert(attribute == MarklightFont.monospacedBoldFont)
            XCTAssert(range?.length == 8)
        } else {
            XCTFail()
        }
    }
    
    func testSetexH1() {
        let string = ["Header", "========", ""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.font, at: 2, effectiveRange: &range!) as? MarklightFont {
            XCTAssert(attribute == MarklightFont.monospacedBoldFont)
            XCTAssert(range?.length == 7)
        } else {
            XCTFail()
        }
    }
    
    func testSetexH2() {
        let string = ["Header", "------", ""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.font, at: 2, effectiveRange: &range!) as? MarklightFont {
            XCTAssert(attribute == MarklightFont.monospacedBoldFont)
            XCTAssert(range?.length == 7)
        } else {
            XCTFail()
        }
    }
    
    func testReferenceLinks() {
        let string = ["[Example][1]","", "[1]: http://example.com/", ""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 8, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 2)
        } else {
            XCTFail()
        }
        // TODO: test following attributes
    }
    
    func testList() {
        let string = ["* First", "* Second", "* Third"].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, string.lengthOfBytes(using: .utf8))
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 8, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
    }
    
    func testAnchor() {
        let string = ["[Example](http://www.example.com)",""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(.link, at: 1, effectiveRange: &range!) as? String {
            XCTAssert(attribute == "http://www.example.com")
            XCTAssert(range?.length == 7)
        } else {
            XCTFail()
        }
				if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 8, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            // TODO: exetend test
            XCTAssert(range?.length == 2)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(.link, at: 10, effectiveRange: &range!) as? String {
            XCTAssert(attribute == "http://www.example.com")
            XCTAssert(range?.length == 22)
        } else {
            XCTFail()
        }
				if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 32, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            // TODO: exetend test
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
    }

    func testAnchorMailTo() {
        let string = ["[Example](mailto:test@example.com)",""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(.link, at: 1, effectiveRange: &range!) as? String {
            XCTAssert(attribute == "mailto:test@example.com")
            XCTAssert(range?.length == 7)
        } else {
            XCTFail()
        }
				if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 8, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            // TODO: exetend test
            XCTAssert(range?.length == 2)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(.link, at: 10, effectiveRange: &range!) as? String {
            XCTAssert(attribute == "mailto:test@example.com")
            XCTAssert(range?.length == 23)
        } else {
            XCTFail()
        }
				if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 33, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            // TODO: exetend test
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
    }
    // TODO: test anchor inline?
    
    func testImage() {
        let string = ["![Example](http://www.example.com/image.png)",""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, string.lengthOfBytes(using: .utf8))
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 2)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 9, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            // TODO: exetend test
            XCTAssert(range?.length == 2)
        } else {
            XCTFail()
        }
    }
    
    func testCodeBlock() {
        let string = ["```","func testCodeBlock()","```",""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 3)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.font, at: 3, effectiveRange: &range!) as? MarklightFont {
            XCTAssert(attribute == MarklightFont.monospacedFont)
            XCTAssert(range?.length == 22)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 25, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 3)
        } else {
            XCTFail()
        }
    }
    
    func testIndentedCodeBlock() {
        let string = ["    func testCodeBlock() {","    }",""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.codeColor)
            XCTAssert(range?.length == 33)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.font, at: 0, effectiveRange: &range!) as? MarklightFont {
            XCTAssert(attribute == MarklightFont.monospacedFont)
            XCTAssert(range?.length == 33)
        } else {
            XCTFail()
        }
    }
    
    func testCodeSpan() {
        let string = ["This is a phrase with inline `code`",""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 29, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.font, at: 30, effectiveRange: &range!) as? MarklightFont {
            XCTAssert(attribute == MarklightFont.monospacedFont)
            XCTAssert(range?.length == 4)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 34, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
    }
    
    func testQuote() {
        let string = ["> This is a quoted line","> This another one", ""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, 1)
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 2)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 24, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 2)
        } else {
            XCTFail()
        }
    }
    
    func testItalic() {
        let string = ["*italic* word", ""].joined(separator: "\n")
        let attributedString = NSAttributedString(string: string)
        self.textStorage.replaceCharacters(in: NSMakeRange(0, 0), with: attributedString)
        var range : NSRange? = NSMakeRange(0, string.lengthOfBytes(using: .utf8))
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.font, at: 1, effectiveRange: &range!) as? MarklightFont {
            XCTAssert(attribute == MarklightFont.monospacedItalicFont)
            XCTAssert(range?.length == 6)
        } else {
            XCTFail()
        }
        if let attribute = self.textStorage.attribute(NSAttributedString.Key.foregroundColor, at: 7, effectiveRange: &range!) as? MarklightColor {
            XCTAssert(attribute == MarklightColor.syntaxColor)
            XCTAssert(range?.length == 1)
        } else {
            XCTFail()
        }
    }
    
    // TODO: test the remaining markdown syntax
}
