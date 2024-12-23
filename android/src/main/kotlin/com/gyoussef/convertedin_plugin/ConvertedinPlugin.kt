package com.gyoussef.convertedin_plugin

import androidx.annotation.NonNull
import android.content.Context
import convertedin.pixel.pixelsdk.ConvertedInSdk
import convertedin.pixel.pixelsdk.data.entities.EventContent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result




class ConvertedinPlugin: FlutterPlugin, MethodCallHandler {

      companion object {
        private const val CHANNEL_NAME = "convertedin"
        
        @JvmStatic
        private lateinit var instance: ConvertedinPlugin
        
        @JvmStatic
        fun getInstance(): ConvertedinPlugin {
            if (!::instance.isInitialized) {
                instance = ConvertedinPlugin()
            }
            return instance
        }
    }

    private lateinit var channel: MethodChannel  
    private lateinit var context: Context  

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
        instance = this
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
          
            "initialize" -> {
                initializeSdk(call, result)                
            }
            "identifyUser" -> {
                identifyUser(call, result)
            }
            "addEvent" -> {
                addEvent(call, result)
            }
            "registerEvent" -> {
                registerEvent(call, result)
            }
            "viewContentEvent" -> {
                viewContentEvent(call, result)
            }
            "pageViewEvent" -> {
                pageViewEvent(result)
            }
            "addToCartEvent" -> {
                addToCartEvent(call, result)
            }
            "initiateCheckoutEvent" -> {
                initiateCheckoutEvent(call, result)
            }
            "purchaseEvent" -> {
                purchaseEvent(call, result)
            }
            "saveDeviceToken" -> {
                saveDeviceToken(call, result)
            }
            "onPushNotificationClicked" -> {
                onPushNotificationClicked(call, result)
            }
            "deleteDeviceToken" -> {
                deleteDeviceToken(result)
            }
            else -> result.notImplemented()
        }
    }

    

    private fun initializeSdk(call: MethodCall, result: Result) {
        val pixelId = call.argument<String>("pixelId")?: ""
        val storeUrl = call.argument<String>("storeUrl")?: ""
        ConvertedInSdk().initialize(context, pixelId, storeUrl)
        result.success("SDK initialize success")
    }

    private fun identifyUser(call: MethodCall, result: Result) {
        val email = call.argument<String>("email")
        val phone = call.argument<String>("phone")
        val countryCode = call.argument<String>("countryCode")
        if (!email.isNullOrEmpty()) {
            ConvertedInSdk().setUserData(email)
        } else if (!phone.isNullOrEmpty()) {
            ConvertedInSdk().setUserData(phone, countryCode ?: "")
        }
        result.success("User identified")
    }

    private fun addEvent(call: MethodCall, result: Result) {
        val eventName = call.argument<String>("eventName") ?: ""
        val currency = call.argument<String>("currency") ?: ""
        val total = call.argument<String>("total") ?: ""
        val products = call.argument<List<Map<String, String>>>("products")?.map {
            EventContent(
                it["id"] ?: "",
                it["quantity"] ?: "",
                it["name"] ?: ""
            )
        } ?: emptyList()

        ConvertedInSdk().addEvent(eventName, currency, total, ArrayList(products))
        result.success("Event added")
    }

    private fun registerEvent(call: MethodCall, result: Result) {
        val email = call.argument<String>("email") ?: ""
        ConvertedInSdk().register(email)
        result.success("Register event logged")
    }

    private fun viewContentEvent(call: MethodCall, result: Result) {
        val currency = call.argument<String>("currency") ?: ""
        val total = call.argument<String>("total") ?: ""
        val products = call.argument<List<Map<String, String>>>("products")?.map {
            EventContent(
                it["id"] ?: "",
                it["quantity"] ?: "",
                it["name"] ?: ""
            )
        } ?: emptyList()

        ConvertedInSdk().viewContentEvent(currency, total, ArrayList(products))
        result.success("View content event logged")
    }

    private fun pageViewEvent(result: Result) {
        ConvertedInSdk().pageViewEvent()
        result.success("Page view event logged")
    }

    private fun addToCartEvent(call: MethodCall, result: Result) {
        val currency = call.argument<String>("currency") ?: ""
        val total = call.argument<String>("total") ?: ""
        val products = call.argument<List<Map<String, String>>>("products")?.map {
            EventContent(
                it["id"] ?: "",
                it["quantity"] ?: "",
                it["name"] ?: ""
            )
        } ?: emptyList()

        ConvertedInSdk().addToCartEvent(currency, total, ArrayList(products))
        result.success("Add to cart event logged")
    }

    private fun initiateCheckoutEvent(call: MethodCall, result: Result) {
        val currency = call.argument<String>("currency") ?: ""
        val total = call.argument<String>("total") ?: ""
        val products = call.argument<List<Map<String, String>>>("products")?.map {
            EventContent(
                it["id"] ?: "",
                it["quantity"] ?: "",
                it["name"] ?: ""
            )
        } ?: emptyList()

        ConvertedInSdk().initiateCheckoutEvent(currency, total, ArrayList(products))
        result.success("Initiate checkout event logged")
    }

    private fun purchaseEvent(call: MethodCall, result: Result) {
        val currency = call.argument<String>("currency") ?: ""
        val total = call.argument<String>("total") ?: ""
        val products = call.argument<List<Map<String, String>>>("products")?.map {
            EventContent(
                it["id"] ?: "",
                it["quantity"] ?: "",
                it["name"] ?: ""
            )
        } ?: emptyList()
        val orderId = call.argument<String>("orderId") ?: ""

        ConvertedInSdk().purchaseEvent(currency, total, ArrayList(products), orderId)
        result.success("Purchase event logged")
    }

    private fun saveDeviceToken(call: MethodCall, result: Result) {
        val token = call.argument<String>("token") ?: ""
        ConvertedInSdk().saveDeviceToken(token)
        result.success("Device token saved with result: $token")
    }

    private fun onPushNotificationClicked(call: MethodCall, result: Result) {
        val campaignId = call.argument<String>("campaignId") ?: ""
        ConvertedInSdk().onPushNotificationClicked(campaignId)
        result.success("Push notification clicked")
    }

    private fun deleteDeviceToken(result: Result) {
        ConvertedInSdk().deleteDeviceToken()
        result.success("Device token deleted")
    }

}

