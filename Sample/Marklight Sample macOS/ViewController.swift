//
//  ViewController.swift
//  Marklight Sample macOS
//
//  Created by Christian Tietze on 2017-07-19.
//  Copyright © 2017 MacTeo. All rights reserved.
//

import Cocoa
import Marklight

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    let textStorage = MarklightTextStorage()

    override func viewDidLoad() {
        super.viewDidLoad()

        textStorage.marklightTextProcessor.codeColor = NSColor.systemOrange
        textStorage.marklightTextProcessor.quoteColor = NSColor.systemGreen
        textStorage.marklightTextProcessor.syntaxColor = NSColor.systemBlue
        textStorage.marklightTextProcessor.codeFontName = "Courier"
        textStorage.marklightTextProcessor.textSize = 18.0
        textStorage.marklightTextProcessor.hideSyntax = false

        textView.layoutManager?.replaceTextStorage(textStorage)

        textView.textContainerInset = NSSize(width: 10, height: 8)
        textView.isAutomaticQuoteSubstitutionEnabled = false
        textView.isAutomaticDashSubstitutionEnabled = false

        if let samplePath = Bundle.main.path(forResource: "Sample", ofType: "md"),
            let string = try? String(contentsOfFile: samplePath) {
            let attributedString = NSAttributedString(string: string)
            textStorage.append(attributedString)
        }
    }
    
    func isDarkMode(view: NSView?) -> Bool {
        if #available(OSX 10.14, *) {
            let appearance = view?.effectiveAppearance ?? NSAppearance.current!
            return (appearance.name == .darkAqua)
        }
        return false
    }
}
