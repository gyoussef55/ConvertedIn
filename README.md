# convertedin_plugin

`convertedin_plugin` is a Flutter plugin that integrates with Convertedin, a powerful marketing operating system designed to boost customer engagement and maximize ROI for e-commerce businesses. This plugin allows developers to easily track key user events and interact with the Convertedin SDK for personalized multi-channel marketing based on user data and insights.

## Features

This plugin enables developers to:
- Initialize the Convertedin SDK with platform credentials.
- Track a wide range of user events, including:
  - User identification (via email or phone).
  - User registration.
  - Page view tracking.
  - Content view tracking.
  - Add-to-cart tracking.
  - Checkout initiation tracking.
  - Purchase tracking.
  - Custom event tracking.
  - Push notification event tracking.
- Manage device tokens for push notifications.

## Installation

To install the plugin, add it to your `pubspec.yaml`:

```yaml
dependencies:
  convertedin_plugin: ^0.0.1
```

Run the following command to fetch the dependencies:

```bash
flutter pub get
```

## Usage

### Import the Plugin
Start by importing the `convertedin_plugin` package in your Dart file:

```dart
import 'package:convertedin_plugin/convertedin_plugin.dart';
```

### Initialize the SDK
Initialize the SDK by providing your `pixelId` and `storeUrl`:  
You can get pixel id and store id from the dashboard.


```dart
final convertedin = MethodChannelConvertedin();

void initializeSdk() async {
  final result = await convertedin.initialize(
    pixelId: "your-pixel-id",
    storeUrl: "your-store-url",
  );
  print(result);
}
```

### Identify Users
Identify a user by either their email or phone number:

```dart
void identifyUser() async {
  final result = await convertedin.identifyUser(email: "user@example.com");
  print(result);
}
```

### Register Users
Track user registration events:

```dart
void registerUser() async {
  final result = await convertedin.registerUser("user@example.com");
  print(result);
}
```

### Track Events

The following events can be tracked with the plugin:

#### 1. **Page View Event**
Track page views on your website:

```dart
void logPageView() async {
  final result = await convertedin.pageViewEvent();
  print(result);
}
```

#### 2. **View Content Event**
Track when a user views content, such as a product page:

```dart
void logViewContent() async {
  final result = await convertedin.viewContentEvent(
    currency: "USD",
    total: "100",
    products: [
      ConvertedInProduct(id: "product1", name: "Product 1", price: "50", quantity: 1),
      ConvertedInProduct(id: "product2", name: "Product 2", price: "50", quantity: 1),
    ],
  );
  print(result);
}
```

#### 3. **Add to Cart Event**
Track when a user adds items to their cart:

```dart
void logAddToCart() async {
  final result = await convertedin.addToCartEvent(
    currency: "USD",
    total: "150",
    products: [
      ConvertedInProduct(id: "product1", name: "Product 1", price: "50", quantity: 1),
      ConvertedInProduct(id: "product2", name: "Product 2", price: "100", quantity: 1),
    ],
  );
  print(result);
}
```

#### 4. **Initiate Checkout Event**
Track when a user initiates the checkout process:

```dart
void logCheckoutInitiation() async {
  final result = await convertedin.initiateCheckoutEvent(
    currency: "USD",
    total: "150",
    products: [
      ConvertedInProduct(id: "product1", name: "Product 1", price: "50", quantity: 1),
      ConvertedInProduct(id: "product2", name: "Product 2", price: "100", quantity: 1),
    ],
  );
  print(result);
}
```

#### 5. **Purchase Event**
Track when a user completes a purchase:

```dart
void logPurchaseEvent() async {
  final result = await convertedin.purchaseEvent(
    currency: "USD",
    total: "150",
    products: [
      ConvertedInProduct(id: "product1", name: "Product 1", price: "50", quantity: 1),
      ConvertedInProduct(id: "product2", name: "Product 2", price: "100", quantity: 1),
    ],
    orderId: "order-12345",
  );
  print(result);
}
```

#### 6. **Custom Event**
Track custom events with user-defined names:

```dart
void logCustomEvent() async {
  final result = await convertedin.customEvent(
    eventName: "Custom Event",
    currency: "USD",
    total: "150",
    products: [
      ConvertedInProduct(id: "product1", name: "Product 1", price: "50", quantity: 1),
      ConvertedInProduct(id: "product2", name: "Product 2", price: "100", quantity: 1),
    ],
  );
  print(result);
}
```

### Push Notification Management
To use Convertedin SDK’s push notifications, you need to integrate with Firebase notifications

#### Save Device Token
After Integrating with firebase successfully, call this function on the SDK to send the firebase token to start getting notifications from your dashboard.  
**⚠️Important Note**: Each Time firebase token is updated you must call saveDeviceToken function to save the new firebase token
```dart
void saveDeviceToken() async {
  final result = await convertedin.saveDeviceToken("device-token");
  print(result);
}
```
#### Delete Device Token
Delete the device token for push notifications:

```dart
void deleteDeviceToken() async {
  final result = await convertedin.deleteDeviceToken();
}
```
#### Handle Push Notification Clicks
This event is typically triggered when a user clicks on a push notification, and should pass the received campaign id to the function

```dart
void onPushNotificationClick() async {
  final result = await convertedin.onPushNotificationClicked("campaign-id");
  print(result);
}
```

## Available Events

Here is a summary of the events that can be tracked with the plugin:

- **SDK Initialization**: `initialize(pixelId, storeUrl)`
- **Identify User**: `identifyUser(email, phone, countryCode)`
- **User Registration**: `registerUser(email)`
- **Page View Event**: `pageViewEvent()`
- **View Content Event**: `viewContentEvent(currency, total, products)`
- **Add to Cart Event**: `addToCartEvent(currency, total, products)`
- **Initiate Checkout Event**: `initiateCheckoutEvent(currency, total, products)`
- **Purchase Event**: `purchaseEvent(currency, total, products, orderId)`
- **Custom Event**: `customEvent(eventName, currency, total, products)`
- **Save Device Token**: `saveDeviceToken(token)`
- **Delete Device Token**: `deleteDeviceToken()`
- **Push Notification Click**: `onPushNotificationClicked(campaignId)`
