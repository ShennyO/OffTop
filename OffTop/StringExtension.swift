//
//  StringExtension.swift
//  OffTop
//
//  Created by Sunny Ouyang on 1/10/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import Foundation

extension StringProtocol where Index == String.Index {
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}
