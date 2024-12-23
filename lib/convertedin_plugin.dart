
import 'package:convertedin_plugin/convertedin_product.dart';
import 'convertedin_platform_interface.dart';

class Convertedin {
  
  /// Returns true if the SDK is initialized
  bool get isInitialized => ConvertedinPlatform.instance.isInitialized();

  /// Initialize the SDK
  Future<String?> initialize({required  String pixelId, required String storeUrl}) {
    return ConvertedinPlatform.instance.initialize(pixelId: pixelId, storeUrl: storeUrl);
  }

  /// Identifies the user using either [email] or [phone] with an optional [countryCode].
  Future<String?> identifyUser({String? email, String? phone, String? countryCode}) {
    return ConvertedinPlatform.instance.identifyUser(email: email, phone: phone, countryCode: countryCode);
  }

  /// Identifies the user using [email].
  Future<String?> registerUser(String email) {
    return ConvertedinPlatform.instance.registerUser(email);
  }

  /// Logs a page view event
  Future<String?> pageViewEvent() {
    return ConvertedinPlatform.instance.pageViewEvent();
  }

  /// Logs a view content event
  Future<String?> viewContentEvent({required String currency, required String total, required List<ConvertedInProduct> products}) {
    return ConvertedinPlatform.instance.viewContentEvent(currency: currency, total: total, products: products);
  }

  /// Logs an add-to-cart event
  Future<String?> addToCartEvent({required String currency, required String total, required List<ConvertedInProduct> products}) {
    return ConvertedinPlatform.instance.addToCartEvent(currency: currency, total: total, products: products);
  }

  /// Logs an initiate checkout event
  Future<String?> initiateCheckoutEvent({required String currency, required String total, required List<ConvertedInProduct> products}) {
    return ConvertedinPlatform.instance.initiateCheckoutEvent(currency: currency, total: total, products: products);
  }

  /// Logs a purchase event
  Future<String?> purchaseEvent({required String currency, required String total, required List<ConvertedInProduct> products, required String orderId}) {
    return ConvertedinPlatform.instance.purchaseEvent(currency: currency, total: total, products: products, orderId: orderId);
  }

  /// Logs a custom event
  Future<String?> customEvent(String eventName, String currency, String total, List<ConvertedInProduct> products) {
    return ConvertedinPlatform.instance.customEvent(eventName:eventName, currency:currency, total:total, products:products);
  }

  /// Save device token for push notifications
  Future<String?> saveDeviceToken(String token) {
    return ConvertedinPlatform.instance.saveDeviceToken(token);
  }

  /// Deletes the saved device token
  Future<String?> deleteDeviceToken() {
    return ConvertedinPlatform.instance.deleteDeviceToken();
  }

  /// Logs push notification clicked event
  Future<String?> onPushNotificationClicked(String campaignId) {
    return ConvertedinPlatform.instance.onPushNotificationClicked(campaignId);
  }

}
