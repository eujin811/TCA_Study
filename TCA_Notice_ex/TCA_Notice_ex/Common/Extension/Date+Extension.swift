//
//  Date+Extension.swift
//  TCA_Notice_ex
//
//  Created by YoujinMac on 2022/11/20.
//

import Foundation

extension Date {
    func toString(dateFormat: DateConstants) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }
}
