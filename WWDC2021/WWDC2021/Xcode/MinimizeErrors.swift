//
//  MinimizeErrors.swift
//  WWDC2021
//
//  Created by Ivan Mah on 24/7/21.
//

struct MinimizeErrors {
    let importantVar = 42

    private func importantFunc() -> String {
        return String(importantVar)
    }

    private func criticalFunc() -> Bool {
        return importantVar == 42
    }

    private func vitalFunc() -> [Int] {
        return [importantVar]
    }
}
