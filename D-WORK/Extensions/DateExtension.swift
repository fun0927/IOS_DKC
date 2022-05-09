//
//  DateExtension.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/06.
//

import Foundation
extension Date {
//Extension을 활용해 상황에 맞는 Date.method를 사용해줍니다.

    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }

    func toStringKST( dateFormat format: String ) -> String {
        return self.toString(dateFormat: format)
    }

    func toStringUTC(_ timezone: Int ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h:m"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        return dateFormatter.string(from: self)
    }
}
