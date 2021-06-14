//
//  DocCDocumentation.swift
//  WWDC2021
//
//  Created by Ivan Mah on 14/6/21.
//

import Foundation

/// Testing DocC Documentation
public class DocCDocumentation {
    /// This is a summary.
    ///
    /// This goes into the `Discussion` section and supports `MarkDown`.
    ///
    /// ```swift
    /// let dbsAccount = DBSAccount()
    /// ```
    public struct DBSAccount {
        /// The balance remaining in the account.
        public var balance = 5.00

        /// Debits a specified amount of money from the account.
        ///
        /// - Parameter amount: The amount of money to debit.
        /// - Returns: A `bool` indicating if the amount was successfully debited.
        mutating public func debit(amount: Double) -> Bool {
            return true
        }

        /// Debits a specified amount of money from the account.
        ///
        /// ```swift
        /// let dbsAccount = DBSAccount( )
        /// let idr = Currency()
        /// let debitSuccessful = dbsAccount.debit(amount: 1.00, currency: idr)
        /// ```
        /// Each time an amount is debited, the ``balance`` decreases by the debited amount.
        ///
        /// - Parameter
        ///   - amount: The amount of money to debit.
        ///   - currency: The currency of the amount to be debited.
        /// - Returns: A `bool` indicating if the amount was successfully debited.
        mutating public func debit(amount: Double, currency: Currency) -> Bool {
            return true
        }

        mutating public func credit(amount: Double, currency: Currency) -> Bool {
            return true
        }
    }

    public struct Currency {
        let exchangeRate = 10000.0
    }
}
