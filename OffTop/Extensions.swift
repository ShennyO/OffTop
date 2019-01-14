//
//  Extensions.swift
//  OffTop
//
//  Created by Sunny Ouyang on 1/13/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import Foundation
import UIKit


extension StringProtocol where Index == String.Index {
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}

extension String {
    var isEmptyOrWhitespace: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespaces) == ""
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
