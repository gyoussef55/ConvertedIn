# Keep all classes and members in the convertedin.pixel.pixelsdk package
-keep class convertedin.pixel.pixelsdk.** { *; }

# Prevent proguard from stripping interface information from TypeAdapter, TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

-keepattributes Signature
-keepattributes *Annotation*

# Prevent R8 from leaving Data object members always null
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# Retain generic signatures of TypeToken and its subclasses with R8 version 3.0 and higher.
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * implements java.lang.reflect.Type
-keep class com.google.common.reflect.TypeToken { *; }


# Gson specific classes
-dontwarn sun.misc.**
-keep class com.google.gson.stream.** { *; }

-keep class java.util.HashMap { *; }

# Keep generic signature of Call, Response (R8 full mode strips signatures from non-kept items).
 -keep,allowobfuscation,allowshrinking interface retrofit2.Call
 -keep,allowobfuscation,allowshrinking class retrofit2.Response

# Keep classes and members that are used by RxJava
-keep class io.reactivex.** { *; }
-keep class * extends io.reactivex.** { *; }
-keep class * implements io.reactivex.** { *; }

# Keep methods that are used by RxJava subscribers
-keepclassmembers class * {
    void onSubscribe(io.reactivex.disposables.Disposable);
    void onNext(*);
    void onError(java.lang.Throwable);
    void onComplete();
}
