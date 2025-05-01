//
//  RussianWordHelper.swift
//  EffectiveMobile
//
//  Created by Алексей on 30.04.2025.
//

import Foundation

struct RussianWordHelper {
    // MARK: – Task Word Form
    static func taskWordForm(for count: Int) -> String {
        let remainder10 = count % 10
        let remainder100 = count % 100
        
        if remainder10 == 1 && remainder100 != 11 {
            return "Задача"
        } else if (2...4).contains(remainder10) && !(12...14).contains(remainder100) {
            return "Задачи"
        } else {
            return "Задач"
        }
    }
}
