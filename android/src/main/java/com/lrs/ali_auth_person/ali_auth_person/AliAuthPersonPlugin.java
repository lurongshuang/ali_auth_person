package com.lrs.ali_auth_person.ali_auth_person;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.aliyun.aliyunface.api.ZIMCallback;
import com.aliyun.aliyunface.api.ZIMFacade;
import com.aliyun.aliyunface.api.ZIMFacadeBuilder;
import com.aliyun.aliyunface.api.ZIMResponse;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

/**
 * AliAuthPersonPlugin
 */
public class AliAuthPersonPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    // 上下文 Context
    private Context context;
    private Activity activity;
    private EventChannel.EventSink eventSink;


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "ali_auth_person");
        channel.setMethodCallHandler(this);
        context = flutterPluginBinding.getApplicationContext();

        final EventChannel eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "ali_auth_person_plugin_event");
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {
                AliAuthPersonPlugin.this.eventSink = eventSink;
            }

            @Override
            public void onCancel(Object o) {
                AliAuthPersonPlugin.this.eventSink = null;
            }
        });
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("getMetaInfos")) {
            //获取本机参数
            String metaInfo = ZIMFacade.getMetaInfos(context);
            result.success(metaInfo);
        } else if (call.method.equals("verify")) {
            //进行实名认证
            String certifyId = call.arguments();
            if (certifyId == null || certifyId.isEmpty()) {
                Toast.makeText(context, "certifyId 不能为空！", Toast.LENGTH_SHORT).show();
                return;
            }
            ZIMFacade.install(context);
            ZIMFacade zimFacade = ZIMFacadeBuilder.create(activity);
            zimFacade.verify(certifyId, true, new ZIMCallback() {
                @Override
                public boolean response(ZIMResponse response) {
                    // TODO：根据实人认证回调结果处理自身的业务。
//                    if (null != response && 1000 == response.code) {
//                        // 认证成功。
//                        Log.d("response", "----------------------认证成功");
//                    } else {
//                        // 认证失败。
//                        Log.d("response", "----------------------认证失败");
//                    }
                    JSONObject jsonObject = new JSONObject();
                    try {
                        jsonObject.put("code", response.code);
                        jsonObject.put("msg", response.msg);
                        jsonObject.put("deviceToken", response.deviceToken);
                        jsonObject.put("videoFilePath", response.videoFilePath);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                    eventSink.success(jsonObject.toString());
                    return true;
                }
            });
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }
}
