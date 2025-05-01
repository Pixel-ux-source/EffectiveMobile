//
//  Date.swift
//  EffectiveMobile
//
//  Created by Алексей on 01.05.2025.
//

import UIKit

extension Date? {
    func formattedDate() -> String {
        guard let self else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        
        return formatter.string(from: self)
    }
}
