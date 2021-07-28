//
//  ApplePayCoupon.swift
//  WWDC2021
//
//  Created by Ivan Mah on 25/7/21.
//

import Foundation

struct ApplePayCoupon {
    var code: String
    var expiryDate: Date
    var discount: String

    func isExpired() -> Bool {
        return Date.now > expiryDate
    }
}
