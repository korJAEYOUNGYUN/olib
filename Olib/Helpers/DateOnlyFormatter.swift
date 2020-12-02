//
//  DateOnlyFormatter.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/09.
//

import Foundation

struct DateOnlyFormatter {
    
    let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    func today() -> Date {
        dateFormatter.date(from: dateFormatter.string(from: Date()))!
    }
    
    func date(from: String) -> Date? {
        dateFormatter.date(from: from)
    }
    
    func string(from: Date) -> String {
        dateFormatter.string(from: from)
    }
}
