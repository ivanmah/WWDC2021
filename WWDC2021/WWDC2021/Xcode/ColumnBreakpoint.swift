//
//  ColumnBreakpoint.swift
//  WWDC2021
//
//  Created by Ivan Mah on 24/7/21.
//

struct ColumnBreakpoint {
    init() { }

    func parseArray(values: [String]) -> [Int] {
        let parsedValues = values.compactMap { $0 }.filter { !$0.isEmpty }.map { $0.count }

        return parsedValues
    }
}

extension ColumnBreakpoint {
    private func getInts() -> String {
        let ints = get1() + get2() + get3()

        return ints
    }
}

extension ColumnBreakpoint {
    private func get1() -> String { return "1" }
    private func get2() -> String { return "2" }
    private func get3() -> String { return "3" }
}
