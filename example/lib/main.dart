import 'package:convertedin_plugin/convertedin_plugin.dart';
import 'package:flutter/material.dart';
import 'package:convertedin_plugin/convertedin_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConvertedIn Plugin Demo',
      home: EventLoggerScreen(),
    );
  }
}

class EventLoggerScreen extends StatefulWidget {
  const EventLoggerScreen({super.key});

  @override
  State<EventLoggerScreen> createState() => _EventLoggerScreenState();
}

class _EventLoggerScreenState extends State<EventLoggerScreen> {
  final convertedin = Convertedin();

  // Replace these with your actual values
  String pixelId = "your-pixel-id";
  String storeUrl = "yourstore.com";

  @override
  void initState() {
    super.initState();
    initializeSDK();
  }

  Future<void> initializeSDK() async {
    try {
      String? initResponse =
          await convertedin.initialize(pixelId: pixelId, storeUrl: storeUrl);
      debugPrint("SDK initialized: $initResponse");
    } catch (e) {
      debugPrint("Error initializing SDK: $e");
    }
  }

  Future<void> logEvent(String eventType) async {
    try {
      List<ConvertedInProduct> products = [
        ConvertedInProduct(id: 1, name: "Product A", quantity: 2),
        ConvertedInProduct(id: 2, name: "Product B", quantity: 5),
      ];

      String currency = "USD";
      String total = "55";
      String? response;

      switch (eventType) {
        case "pageView":
          response = await convertedin.pageViewEvent();
          break;
        case "viewContent":
          response = await convertedin.viewContentEvent(
              currency: currency, total: total, products: products);
          break;
        case "addToCart":
          response = await convertedin.addToCartEvent(
              currency: currency, total: total, products: products);
          break;
        case "purchase":
          response = await convertedin.purchaseEvent(
              currency: currency,
              total: total,
              products: products,
              orderId: "order123");
          break;
        case "customEvent":
          response = await convertedin.customEvent(
              "customEventName", currency, total, products);
          break;
        case "saveDeviceToken":
          response = await convertedin.saveDeviceToken("device-token-123");
          break;
        case "deleteDeviceToken":
          response = await convertedin.deleteDeviceToken();
          break;
        case "pushNotificationClicked":
          response = await convertedin.onPushNotificationClicked("campaign123");
          break;

        case "registerUser":
          response = await convertedin.registerUser("123@example.com");
          break;

        case "identifyUser":
          response = await convertedin.identifyUser(
              phone: "1234567890", countryCode: "+20");
          break;
      }

      debugPrint("$eventType event logged: $response");
    } catch (e) {
      debugPrint("Error logging $eventType event: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ConvertedIn Events"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => logEvent("pageView"),
                child: const Text("Log Page View Event"),
              ),
              ElevatedButton(
                onPressed: () => logEvent("viewContent"),
                child: const Text("Log View Content Event"),
              ),
              ElevatedButton(
                onPressed: () => logEvent("addToCart"),
                child: const Text("Log Add to Cart Event"),
              ),
              ElevatedButton(
                onPressed: () => logEvent("purchase"),
                child: const Text("Log Purchase Event"),
              ),
              ElevatedButton(
                onPressed: () => logEvent("customEvent"),
                child: const Text("Log Custom Event"),
              ),
              ElevatedButton(
                onPressed: () => logEvent("saveDeviceToken"),
                child: const Text("Save Device Token"),
              ),
              ElevatedButton(
                onPressed: () => logEvent("deleteDeviceToken"),
                child: const Text("Delete Device Token"),
              ),
              ElevatedButton(
                onPressed: () => logEvent("pushNotificationClicked"),
                child: const Text("Log Push Notification Clicked Event"),
              ),
              ElevatedButton(
                onPressed: () => logEvent("identifyUser"),
                child: const Text("Log Identify User Event"),
              ),
              ElevatedButton(
                onPressed: () => logEvent("registerUser"),
                child: const Text("Log Register User Event"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
