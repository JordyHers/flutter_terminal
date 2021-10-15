import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';

class Service{

  Future<String> getIpAddress() async {
    final ipv4 = await Ipify.ipv4();
    print(ipv4); // 98.207.254.136
    return ipv4;
  }

  Future<String?> getPhoneModelAndroid() async {
    String? model;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
   if(Platform.isIOS){
     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
     print('Running on ${iosInfo.utsname.machine}');
     model = iosInfo.utsname.machine;
    } else{
     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
     print('Running on ${androidInfo.device}');// e.g. "Moto G (4)"
     model='${androidInfo.device}';
    }
    return model;
  }
}