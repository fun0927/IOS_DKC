//
//  StringExtension.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/27.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
//    subscript(_ index: Int) -> Character {
//        return self[self.index(self.startIndex, offsetBy: index)]
//    }
//    subscript(_ range: Range<Int>) -> String {
//        let fromIndex = self.index(self.startIndex, offsetBy: range.startIndex)
//        let toIndex = self.index(self.startIndex, offsetBy: range.endIndex)
//        return String(self[fromIndex..<toIndex])
//    }
    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
    func left(_ len: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: 0)
        let endIndex = self.index(self.startIndex, offsetBy: len-1)
        return String(self[startIndex...endIndex])
    }
    func right(_ len: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: self.count - len-1)
        let endIndex = self.index(self.startIndex, offsetBy: self.count-1)
        return String(self[startIndex...endIndex])
    }
}



