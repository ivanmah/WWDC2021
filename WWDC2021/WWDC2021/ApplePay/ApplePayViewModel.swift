//
//  ApplePayViewModel.swift
//  WWDC2021
//
//  Created by Ivan Mah on 25/7/21.
//

import PassKit

class ApplePayViewModel: NSObject {
    let supportedNetworks: [PKPaymentNetwork] = [.amex, .masterCard, .visa]
    let gstPercentage = 0.07

    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var shippingMethods: [PKShippingMethod] = []
    var selectedShippingMethod: PKShippingMethod?
    var shoppingCart: [ApplePayItem] = []
    var coupons: [ApplePayCoupon] = []
    var selectedCoupon: ApplePayCoupon?

    override init() {
        super.init()

        selectedShippingMethod = getSelfCollectionShippingMethod()

        updateShippingMethods()
        updateCoupons()
    }

    func addToShoppingCart(item: ApplePayItem) {
        shoppingCart.append(item)
    }

    func startPayment() {
        updatePaymentSummaryItems()

        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.com.ivanmah.demo"
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "SG"
        paymentRequest.currencyCode = "SGD"
        paymentRequest.supportedNetworks = supportedNetworks
        paymentRequest.shippingMethods = shippingMethods
        paymentRequest.supportsCouponCode = true
        paymentRequest.requiredShippingContactFields = [.name, .emailAddress, .postalAddress]

        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present()
    }

    func applePayStatus() -> (canMakePayments: Bool, canSetupCards: Bool) {
        return (PKPaymentAuthorizationController.canMakePayments(),
                PKPaymentAuthorizationController.canMakePayments(usingNetworks: supportedNetworks))
    }
}

extension ApplePayViewModel {
    private func updatePaymentSummaryItems() {
        var subTotal = NSDecimalNumber(string: "0.00")

        paymentSummaryItems = shoppingCart.map { item -> PKPaymentSummaryItem in
            let itemPrice = NSDecimalNumber(string: item.price)
            subTotal = subTotal.adding(itemPrice)

            return PKPaymentSummaryItem(label: item.name, amount: itemPrice)
        }

        if let selectedShippingMethod = selectedShippingMethod,
           selectedShippingMethod.amount.compare(NSDecimalNumber.zero) == .orderedDescending {
            paymentSummaryItems.append(PKPaymentSummaryItem(label: String(localized: "Shipping"),
                                                            amount: selectedShippingMethod.amount,
                                                            type: .final))

            subTotal = subTotal.adding(selectedShippingMethod.amount)
        }

        if let selectedCoupon = selectedCoupon {
            let selectedCouponDiscount = NSDecimalNumber(string: selectedCoupon.discount)

           if selectedCouponDiscount.compare(NSDecimalNumber.zero) == .orderedDescending {
               paymentSummaryItems.append(PKPaymentSummaryItem(label: String(localized: "Coupon '\(selectedCoupon.code)' Discount"),
                                                               amount: selectedCouponDiscount,
                                                               type: .final))

               subTotal = subTotal.subtracting(selectedCouponDiscount)
           }
        }

        let gstTotal = subTotal.multiplying(by: NSDecimalNumber(value: gstPercentage))
        let finalTotal = subTotal.adding(gstTotal)

        paymentSummaryItems.append(PKPaymentSummaryItem(label: String(localized: "GST"), amount: gstTotal))
        paymentSummaryItems.append(PKPaymentSummaryItem(label: String(localized: "Total"), amount: finalTotal, type: .final))
    }

    private func updateShippingMethods() {
        guard let selfCollectionShippingMethod = getSelfCollectionShippingMethod(),
              let deliveryShippingMethod = getDeliveryShippingMethod() else { return }

        shippingMethods = [selfCollectionShippingMethod, deliveryShippingMethod]
    }

    private func updateCoupons() {
        guard let dbs2020Coupon = getDBS2020Coupon(),
              let dbs2021Coupon = getDBS2021Coupon() else { return }

        coupons = [dbs2020Coupon, dbs2021Coupon]
    }

    private func getSelfCollectionShippingMethod() -> PKShippingMethod? {
        let selfCollectionShippingMethod = PKShippingMethod(label: String(localized: "Self-Collection"), amount: .zero)
        selfCollectionShippingMethod.identifier = "SELFCOLLECTION"

        return selfCollectionShippingMethod
    }

    private func getDeliveryShippingMethod() -> PKShippingMethod? {
        let today = Date()
        let calendar = Calendar.current

        guard let shippingStart = calendar.date(byAdding: .day, value: 3, to: today),
              let shippingEnd = calendar.date(byAdding: .day, value: 5, to: today) else { return nil }

        let startComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingStart)
        let endComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingEnd)

        let deliveryShippingMethod = PKShippingMethod(label: String(localized: "Delivery"), amount: NSDecimalNumber(string: "5.00"))
        deliveryShippingMethod.identifier = "DELIVERY"
        deliveryShippingMethod.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)

        return deliveryShippingMethod
    }

    private func getDBS2020Coupon() -> ApplePayCoupon? {
        var expiryDate: Date!

        do {
            expiryDate = try Date("31 December 2020", strategy: Date.FormatStyle().year().month().day())
        } catch { return nil }

        return ApplePayCoupon(code: "DBS2020", expiryDate: expiryDate, discount: "5.00")
    }

    private func getDBS2021Coupon() -> ApplePayCoupon? {
        var expiryDate: Date!

        do {
            expiryDate = try Date("31 December 2021", strategy: Date.FormatStyle().year().month().day())
        } catch { return nil }

        return ApplePayCoupon(code: "DBS2021", expiryDate: expiryDate, discount: "6.00")
    }

    private func validateShippingMethod(shippingMethod: PKShippingMethod) -> PKPaymentRequestShippingMethodUpdate? {
        selectedShippingMethod = shippingMethod

        updatePaymentSummaryItems()

        return PKPaymentRequestShippingMethodUpdate(paymentSummaryItems: paymentSummaryItems)
    }

    private func validateCoupons(couponCode: String) -> PKPaymentRequestCouponCodeUpdate? {
        var couponError: Error?

        if couponCode.isEmpty {
            selectedCoupon = nil
        } else {
            let matchedCoupons = coupons.filter { $0.code.uppercased() == couponCode.uppercased() }

            if matchedCoupons.isEmpty {
                selectedCoupon = nil

                couponError = PKPaymentRequest.paymentCouponCodeInvalidError(localizedDescription: String(localized: "Invalid Coupon Code"))
            } else if let firstCoupon = matchedCoupons.first {
                if firstCoupon.isExpired() {
                    selectedCoupon = nil

                    couponError = PKPaymentRequest.paymentCouponCodeExpiredError(localizedDescription: String(localized: "Expired Coupon Code"))
                } else {
                    selectedCoupon = firstCoupon
                }
            }
        }

        updatePaymentSummaryItems()

        if let couponError = couponError {
            return PKPaymentRequestCouponCodeUpdate(errors: [couponError],
                                                    paymentSummaryItems: paymentSummaryItems,
                                                    shippingMethods: shippingMethods)
        } else {
            return PKPaymentRequestCouponCodeUpdate(paymentSummaryItems: paymentSummaryItems)
        }
    }
}

extension ApplePayViewModel: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss()
    }

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController,
                                        didAuthorizePayment payment: PKPayment,
                                        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let result = PKPaymentAuthorizationResult()
        result.status = .success

        completion(result)
    }

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController,
                                        didChangeCouponCode couponCode: String,
                                        handler completion: @escaping (PKPaymentRequestCouponCodeUpdate) -> Void) {
        if let requestCouponCodeUpdate = validateCoupons(couponCode: couponCode) {
            completion(requestCouponCodeUpdate)
        }
    }

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController,
                                        didSelectShippingMethod shippingMethod: PKShippingMethod,
                                        handler completion: @escaping (PKPaymentRequestShippingMethodUpdate) -> Void) {
        if let shippingMethodUpdate = validateShippingMethod(shippingMethod: shippingMethod) {
            completion(shippingMethodUpdate)
        }
    }
}
