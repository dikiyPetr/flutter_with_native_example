package com.example.flutter_with_native_example

import android.os.Handler
import android.os.Looper
import com.example.flutter_with_native_example.platform_view.ButtonPlatformViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.StandardMethodCodec
import java.util.*

/** FlutterWithNativeExamplePlugin */
class FlutterWithNativeExamplePlugin : FlutterPlugin, MethodCallHandler,
    EventChannel.StreamHandler, Pigeon.ModelApi {
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private val timerMap = HashMap<String, Timer>()

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "my_method_channel",
            StandardMethodCodec.INSTANCE
        )
        methodChannel.setMethodCallHandler(this)
        attachEventChannel(flutterPluginBinding)
        initPigeon(flutterPluginBinding)
        registerViewFactory(flutterPluginBinding)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
        Pigeon.ModelApi.setup(binding.binaryMessenger, null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "add") {
            val argumentsList = call.arguments as List<*>
            val a = (argumentsList[0] as Number).toLong()
            val b = (argumentsList[1] as Number).toLong()
            result.success(a + b)
        } else {
            result.notImplemented()
        }
    }

    private fun attachEventChannel(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        eventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger,
            "my_event_channel",
            StandardMethodCodec.INSTANCE,
        )
        eventChannel.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        val argumentsList = arguments as List<*>
        val id = argumentsList[0] as String
        val period = (argumentsList[1] as Number).toLong()
        val timer = Timer()
        timer.scheduleAtFixedRate(object : TimerTask() {
            override fun run() {
                Handler(Looper.getMainLooper()).post {
                    events.success(System.currentTimeMillis())
                }
            }

        }, 0, period)
        timerMap[id]?.cancel()
        timerMap[id] = timer
    }

    override fun onCancel(arguments: Any?) {
        val argumentsList = arguments as List<*>
        val id = argumentsList[0] as String
        timerMap.remove(id)?.cancel()
    }

    private fun registerViewFactory(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            ButtonPlatformViewFactory.TYPE,
            ButtonPlatformViewFactory(flutterPluginBinding),
        )
    }

    private fun initPigeon(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Pigeon.ModelApi.setup(flutterPluginBinding.binaryMessenger, this)
    }

    override fun getModel(id: Long): Pigeon.Model {
        return Pigeon.Model.Builder().setId(id).setTitle("title $id").build()
    }
}
