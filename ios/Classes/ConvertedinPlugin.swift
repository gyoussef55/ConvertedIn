import Flutter
import UIKit
import ConvertedinMobileSDK


public class ConvertedinPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "convertedin", binaryMessenger: registrar.messenger())
        let instance = ConvertedinPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            if let args = call.arguments as? [String: Any],
               let pixelId = args["pixelId"] as? String,
               let storeUrl = args["storeUrl"] as? String {
                ConvertedinMobileSDK.configure(
                pixelId: pixelId,
                storeUrl: storeUrl
                )
                result("SDK initialize success")
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Arguments for pixelId and storeUrl are required",
                    details: nil
                ))
            }          
            
            
        case "identifyUser":
            if let args = call.arguments as? [String: Any] {
                let email = args["email"] as? String
                let countryCode = args["countryCode"] as? String
                let phone = args["phone"] as? String
                if let email = email, !email.isEmpty {
                    ConvertedinMobileSDK.setUserData(email: email)
                } else if let phone = phone, !phone.isEmpty {
                    ConvertedinMobileSDK.setUserData(phone: phone, countryCode: countryCode)
                }
                result("User identified")
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Email, countryCode, and phone are required",
                    details: nil
                ))
            }

        case "registerEvent":
            if let args = call.arguments as? [String: Any],
               let email = args["email"] as? String {
                ConvertedinMobileSDK.register(email: email)
                result("Register event logged")
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Email is required",
                    details: nil
                ))
            }

        case "addToCartEvent":
            if let args = call.arguments as? [String: Any],
               let currency = args["currency"] as? String,
               let total = args["total"] as? String,
               let productArray = args["products"] as? [[String: String]] {
                let products = productArray.map { product in
                    ConvertedinMobileSDK.ConvertedinProduct(
                        id: Int(product["id"] ?? "") ?? 0,
                        quantity: Int(product["quantity"] ?? "") ?? 0,
                        name: product["name"] ?? ""
                    )
                }
                ConvertedinMobileSDK.addToCartEvent(
                    currency: currency,
                    total: total,
                    products: products
                )
                result("Add to cart event logged")
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Arguments for currency, total, and products are required",
                    details: nil
                ))
            }

        case "initiateCheckoutEvent":
            if let args = call.arguments as? [String: Any],
               let currency = args["currency"] as? String,
               let total = args["total"] as? String,
               let productArray = args["products"] as? [[String: String]] {
                let products = productArray.map { product in
                    ConvertedinMobileSDK.ConvertedinProduct(
                        id: Int(product["id"] ?? "") ?? 0,
                        quantity: Int(product["quantity"] ?? "") ?? 0,
                        name: product["name"] ?? ""
                    )
                }
                ConvertedinMobileSDK.initiateCheckoutEvent(
                    currency: currency,
                    total: total,
                    products: products
                )
                result("Initiate checkout event logged")
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Arguments for currency, total, and products are required",
                    details: nil
                ))
            }

        case "purchaseEvent":
            if let args = call.arguments as? [String: Any],
               let currency = args["currency"] as? String,
               let total = args["total"] as? String,
               let orderId = args["orderId"] as? String,
               let productArray = args["products"] as? [[String: String]] {
                let products = productArray.map { product in
                    ConvertedinMobileSDK.ConvertedinProduct(
                        id: Int(product["id"] ?? "") ?? 0,
                        quantity: Int(product["quantity"] ?? "") ?? 0,
                        name: product["name"] ?? ""
                    )
                }
                ConvertedinMobileSDK.purchaseEvent(
                    orderId: orderId,
                    currency: currency,
                    total: total,
                    products: products
                )
                result("Purchase event logged")
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Arguments for currency, total, orderId, and products are required",
                    details: nil
                ))
            }

        case "pageViewEvent":
            ConvertedinMobileSDK.pageViewEvent()
            result("Page view event logged")

        case "viewContentEvent":
            if let args = call.arguments as? [String: Any],
               let currency = args["currency"] as? String,
               let total = args["total"] as? String,
               let productArray = args["products"] as? [[String: String]] {
                let products = productArray.map { product in
                    ConvertedinMobileSDK.ConvertedinProduct(
                        id: Int(product["id"] ?? "") ?? 0,
                        quantity: Int(product["quantity"] ?? "") ?? 0,
                        name: product["name"] ?? ""
                    )
                }
                ConvertedinMobileSDK.viewContentEvent(
                    currency: currency,
                    total: total,
                    products: products
                )
                result("View content event logged")
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Arguments for currency, total, and products are required",
                    details: nil
                ))
            }

        case "addEvent":
            if let args = call.arguments as? [String: Any],
               let eventName = args["eventName"] as? String,
               let currency = args["currency"] as? String,
               let total = args["total"] as? String,
               let productArray = args["products"] as? [[String: String]] {
                let products = productArray.map { product in
                    ConvertedinMobileSDK.ConvertedinProduct(
                        id: Int(product["id"] ?? "") ?? 0,
                        quantity: Int(product["quantity"] ?? "") ?? 0,
                        name: product["name"] ?? ""
                    )
                }
                ConvertedinMobileSDK.addEvent(
                    eventName: eventName,
                    currency: currency,
                    total: total,
                    products: products
                )
                result("Event added")
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Arguments for eventName, currency, total, and products are required",
                    details: nil
                ))
            }

        case "saveDeviceToken":
            if let args = call.arguments as? [String: Any],
               let token = args["token"] as? String {
                ConvertedinMobileSDK.setFcmToken(token: token)
                result("Device token saved with result: \(token)")
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Token is required",
                    details: nil
                ))
            }

        case "onPushNotificationClicked":
            if let args = call.arguments as? [String: Any],
               let campaignId = args["campaignId"] as? String {
                ConvertedinMobileSDK.onPushNotificationClicked(campaignId: campaignId)
                result("Push notification clicked")
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Campaign Id is required",
                    details: nil
                ))
            }

        case "deleteDeviceToken":
            ConvertedinMobileSDK.deleteDeviceToken()
            result("Device token deleted")

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
