import 'dart:developer';
import 'package:convertedin_plugin/convertedin_product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'convertedin_platform_interface.dart';

/// An implementation of [ConvertedinPlatform] that uses method channels.
class MethodChannelConvertedin extends ConvertedinPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('convertedin');

  /// Tracks whether the SDK is initialized.
  bool _isInitialized = false;

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
          "SDK not initialized. Please call 'initialize' before using this method.");
    }
  }

  @override
  bool isInitialized() {
    return _isInitialized;
  }

  @override
  Future<String?> initialize(
      {required String pixelId, required String storeUrl}) async {
    if (_isInitialized) {
      log("SDK already initialized. Skipping reinitialization.");
      return "SDK already initialized";
    }
    try {
      final String? result = await methodChannel.invokeMethod('initialize', {
        'pixelId': pixelId,
        'storeUrl': storeUrl,
      });
      if (result != null && result.toLowerCase().contains('success')) {
        _isInitialized = true;
        log("SDK initialization result: $result");
        return result;
      } else {
        log("Failed to initialize SDK");
        return null;
      }
    } on PlatformException catch (e) {
      log("Failed to initialize SDK: ${e.message}");
      return 'Failed to initialize SDK: ${e.message}';
    }
  }

  @override
  Future<String?> identifyUser(
      {String? email, String? phone, String? countryCode}) async {
    _ensureInitialized();
    if ((email == null && phone == null) || (email != null && phone != null)) {
      throw ArgumentError(
        'Invalid input: Either email or phone (but not both) must be provided.',
      );
    }
    try {
      final String? result = await methodChannel.invokeMethod('identifyUser', {
        'email': email,
        'phone': phone,
        'countryCode': countryCode,
      });
      log("Identify User event logged successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to identify user: ${e.message}");
      return 'Failed to identify user: ${e.message}';
    }
  }

  @override
  Future<String?> registerUser(String email) async {
    _ensureInitialized();    
    try {
      final String? result = await methodChannel.invokeMethod('registerEvent', {
        'email': email,
      });
      log("Register User event logged successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to register user: ${e.message}");
      return 'Failed to register user: ${e.message}';
    }
  }

  @override
  Future<String?> pageViewEvent() async {
    _ensureInitialized();
    try {
      final String? result = await methodChannel.invokeMethod('pageViewEvent');
      log("Page View event logged successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to log page view event: ${e.message}");
      return 'Failed to log page view event: ${e.message}';
    }
  }

  @override
  Future<String?> viewContentEvent(
      {required String currency,
      required String total,
      required List<ConvertedInProduct> products}) async {
    _ensureInitialized();
    try {
      final String? result = await methodChannel.invokeMethod(
          'viewContentEvent', _convertCartToMap(currency, total, products));
      log("View Content event logged successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to log view content event: ${e.message}");
      return 'Failed to log view content event: ${e.message}';
    }
  }

  @override
  Future<String?> addToCartEvent(
      {required String currency,
      required String total,
      required List<ConvertedInProduct> products}) async {
    _ensureInitialized();
    try {
      final String? result = await methodChannel.invokeMethod(
          'addToCartEvent', _convertCartToMap(currency, total, products));
      log("Add to Cart event logged successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to log add to cart event: ${e.message}");
      return 'Failed to log add to cart event: ${e.message}';
    }
  }

  @override
  Future<String?> initiateCheckoutEvent(
      {required String currency,
      required String total,
      required List<ConvertedInProduct> products}) async {
    _ensureInitialized();
    try {
      final String? result = await methodChannel.invokeMethod(
          'initiateCheckoutEvent',
          _convertCartToMap(currency, total, products));
      log("Initiate Checkout event logged successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to log initiate checkout event: ${e.message}");
      return 'Failed to log initiate checkout event: ${e.message}';
    }
  }

  @override
  Future<String?> purchaseEvent(
      {required String currency,
      required String total,
      required List<ConvertedInProduct> products,
      required String orderId}) async {
    _ensureInitialized();
    try {
      final Map<String, dynamic> purchaseMap =
          _convertCartToMap(currency, total, products);
      purchaseMap.addEntries({'orderId': orderId}.entries);
      final String? result =
          await methodChannel.invokeMethod('purchaseEvent', purchaseMap);
      log("Purchase event logged successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to log purchase event: ${e.message}");
      return 'Failed to log purchase event: ${e.message}';
    }
  }

  @override
  Future<String?> customEvent(
      {required String eventName,
      required String currency,
      required String total,
      required List<ConvertedInProduct> products}) async {
    _ensureInitialized();
    try {
      final Map<String, dynamic> customEventMap =
          _convertCartToMap(currency, total, products);
      customEventMap.addEntries({'eventName': eventName}.entries);
      final String? result =
          await methodChannel.invokeMethod('addEvent', customEventMap);
      log("$eventName event logged successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to log custom event: ${e.message}");
      return 'Failed to log custom event: ${e.message}';
    }
  }

  @override
  Future<String?> saveDeviceToken(String token) async {
    _ensureInitialized();
    try {
      final String? result =
          await methodChannel.invokeMethod('saveDeviceToken', {'token': token});
      log("Device token saved successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to save device token: ${e.message}");
      return 'Failed to save device token: ${e.message}';
    }
  }

  @override
  Future<String?> deleteDeviceToken() async {
    _ensureInitialized();
    try {
      final String? result =
          await methodChannel.invokeMethod('deleteDeviceToken');
      log("Device token deleted successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to delete device token: ${e.message}");
      return 'Failed to delete device token: ${e.message}';
    }
  }

  @override
  Future<String?> onPushNotificationClicked(String campaignId) async {
    _ensureInitialized();
    try {
      final String? result = await methodChannel.invokeMethod(
          'onPushNotificationClicked', {'campaignId': campaignId});
      log("Push notification clicked event logged successfully with result: $result");
      return result;
    } on PlatformException catch (e) {
      log("Failed to log push notification clicked event: ${e.message}");
      return 'Failed to log push notification clicked event: ${e.message}';
    }
  }

  Map<String, dynamic> _convertCartToMap(
      String currency, String total, List<ConvertedInProduct> products) {
    final productsMap =
        products.map((product) => ConvertedInProduct.toMap(product)).toList();
    return {'currency': currency, 'total': total, 'products': productsMap};
  }
}
