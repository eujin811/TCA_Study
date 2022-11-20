//
//  String+Extension.swift
//  TCA_Notice_ex
//
//  Created by YoujinMac on 2022/11/20.
//

import Foundation

extension String {
    func toDate(dateFormat: DateConstants) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = dateFormat.rawValue
        
        return dateFormatter.date(from: self)
    }
}
