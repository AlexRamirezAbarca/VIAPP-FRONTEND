import 'package:viapp/env/config/config_base.dart';

class ProdEnv extends BaseConfig {
  @override
  String get appName => 'VIAPP PROD';

  @override
  String get serviceUrl => '';

  @override
  String get tittleAppName => 'VIAPP';
}
