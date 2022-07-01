import Flutter
import UIKit
import AliyunIdentityManager

//当前视图 ViewController;
var controller : UIViewController?;
//method管道
var channel : FlutterMethodChannel?;
//event管道
var eventChannel : FlutterEventChannel?;
//回调flutter
let eventStreamHandler = EventStreamHandler()
public class SwiftAliAuthPersonPlugin: NSObject, FlutterPlugin{

  public static func register(with registrar: FlutterPluginRegistrar) {
    channel = FlutterMethodChannel(name: "ali_auth_person", binaryMessenger: registrar.messenger())
    let instance = SwiftAliAuthPersonPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel!)
    eventChannel = FlutterEventChannel(name: "ali_auth_person_plugin_event", binaryMessenger: registrar.messenger())
    eventChannel?.setStreamHandler((eventStreamHandler as! FlutterStreamHandler & NSObjectProtocol))
    //初始化阿里SDK
    AliyunSdk.`init`();
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      //获取本机参数
      if(call.method == "getMetaInfos"){
          let info  = AliyunIdentityManager.getMetaInfo();
          var jsonData: Data? = nil
          do {
              if info != nil {
                  jsonData = try JSONSerialization.data(withJSONObject: info!, options: .prettyPrinted)
              }
          } catch  _ {
              print("(parseError.localizedDescription)");
          }
          var infoData : String? = "";
          if let jsonData = jsonData {
              infoData = String(data: jsonData, encoding: .utf8)
          };
         result(infoData);
      }else if(call.method == "verify"){
          controller = UIApplication.shared.delegate?.window??.rootViewController;
          //进行实名认证
          let  certifyId : String = String(describing: call.arguments!);
          print(certifyId);
          let extParams: [String : Any] = ["currentCtr": controller!];
          AliyunIdentityManager.sharedInstance()?.verify(with: certifyId, extParams: extParams, onCompletion: { (response) in
              DispatchQueue.main.async {
                  var resString = ""
                  var deviceToken = "";
                  var code = -1;
                  switch response?.code {
                  case .ZIMResponseSuccess:
                      resString = "认证成功";
                      code = 1000;
                      break;
                  case .ZIMInterrupt:
                      resString = "初始化失败"
                      code = 1001;
                   break
                  case .ZIMTIMEError:
                      resString = "设备时间错误";
                      code = 2003;
                   break
                  case .ZIMNetworkfail:
                      resString = "网络错误";
                      code = 2002;
                   break
                  case .ZIMInternalError:
                      resString = "用户退出";
                      code = 1003;
                   break
                  case .ZIMResponseFail:
                      resString = "刷脸失败";
                      code = 2006;
                  default:
                      resString = "未知异常"
                      break
                  }
                  deviceToken = response?.deviceToken ?? "";
                  eventStreamHandler.sendEvent(event: "{'code':\(code),'msg':'\(resString)','deviceToken':'\(deviceToken)'}");
              }
          })
      }else{
          result("")
      }
  }
}

class EventStreamHandler: FlutterStreamHandler {
    private var eventSink:FlutterEventSink? = nil
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    public func sendEvent(event:Any) {
        eventSink?(event)
    }
}
