import 'package:convertedin_plugin/convertedin_product.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'convertedin_method_channel.dart';

abstract class ConvertedinPlatform extends PlatformInterface {
  /// Constructs a ConvertedinPlatform.
  ConvertedinPlatform() : super(token: _token);

  static final Object _token = Object();

  static ConvertedinPlatform _instance = MethodChannelConvertedin();

  /// The default instance of [ConvertedinPlatform] to use.
  ///
  /// Defaults to [MethodChannelConvertedin].
  static ConvertedinPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ConvertedinPlatform] when
  /// they register themselves.
  static set instance(ConvertedinPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
  bool isInitialized();
  /// Initializes the SDK
  Future<String?> initialize({required  String pixelId, required String storeUrl});

  /// Identifies the user using either [email] or [phone] with an optional [countryCode].
  Future<String?> identifyUser({String? email, String? phone, String? countryCode});

  /// Identifies the user using [email].
  Future<String?> registerUser(String email);

  /// Logs a page view event
  Future<String?> pageViewEvent();

  /// Logs a view content event
  Future<String?> viewContentEvent({required String currency, required String total, required List<ConvertedInProduct> products});

  /// Logs an add-to-cart event
  Future<String?> addToCartEvent({required String currency, required String total, required List<ConvertedInProduct> products});

  /// Logs an initiate checkout event
  Future<String?> initiateCheckoutEvent({required String currency, required String total, required List<ConvertedInProduct> products});

  /// Logs a purchase event
  Future<String?> purchaseEvent({required String currency, required String total, required List<ConvertedInProduct> products, required String orderId});

  /// Logs a custom event
  Future<String?> customEvent({required String eventName, required String currency, required String total, required List<ConvertedInProduct> products});

  /// Saves the device token for push notifications
  Future<String?> saveDeviceToken(String token);

  /// Deletes the saved device token
  Future<String?> deleteDeviceToken();

  /// Logs push notification clicked event
  Future<String?> onPushNotificationClicked(String campaignId);
}
