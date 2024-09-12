//
//  UITapGestureRecognizer+Extension.swift
//
//
//  Created by Jack on 2022/10/18.
//

import Foundation

public extension UITapGestureRecognizer {
    
    func getTappedCharacterIndex(in label: UILabel, at location: CGPoint) -> Int? {
        // AttributedText is used first. If attributedText is not set, text is used.
        guard let attributedText = label.attributedText ?? (label.text != nil ? NSAttributedString(string: label.text!) : nil) else { return nil }
        
        // create NSTextStorage, NSLayoutManager and NSTextContainer
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        
        textContainer.lineFragmentPadding = 0.0
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.lineBreakMode = label.lineBreakMode
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(
            x: (label.bounds.size.width - textBoundingBox.size.width) / 2 - textBoundingBox.origin.x,
            y: (label.bounds.size.height - textBoundingBox.size.height) / 2 - textBoundingBox.origin.y
        )
        
        let adjustedLocation = CGPoint(
            x: location.x - textContainerOffset.x,
            y: location.y - textContainerOffset.y
        )
        
        // To determine whether the click position is within the text area
        if !textBoundingBox.contains(adjustedLocation) {
            return nil
        }
        
        // Find the character index of the click position
        let glyphIndex = layoutManager.glyphIndex(for: adjustedLocation, in: textContainer, fractionOfDistanceThroughGlyph: nil)
        let characterIndex = layoutManager.characterIndexForGlyph(at: glyphIndex)
        
        return characterIndex
    }
    
}
