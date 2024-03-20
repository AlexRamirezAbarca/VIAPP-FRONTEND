import 'package:viapp/env/config/config_base.dart';

class DevEnv extends BaseConfig {


  @override
  String get appName => 'VIAPP DEV';

  @override
  //String get serviceUrl => 'http://10.10.80.243:6969/';
  //String get serviceUrl => 'http://192.168.10.101:6969/'; //COWORKING
  // String get serviceUrl => 'http://10.10.80.233:6969/';    //AAMADEUS
  // String get serviceUrl => 'http://192.168.86.33:6969/';
  String get serviceUrl => 'http://192.168.100.55:6969/';     //CASA
  // String get serviceUrl => 'http://192.168.100.62:6969/';     //CASA
  // String get serviceUrl => 'http://192.168.86.247:6969/';    
  //  String get serviceUrl => 'http://192.168.86.21:6969/';    
  
  // String get serviceUrl => 'http://192.168.100.72:6969/';
  //String get serviceUrl => 'http://192.168.86.30:6969/';
  // String get serviceUrl => 'http://10.10.80.243:6969/';
  // String get serviceUrl => 'http://172.20.10.8:6969/';
  // String get serviceUrl => 'http://192.168.86.20:6969/';

  
  @override
  String get tittleAppName => 'VIAPP';
}
