@JS()
library persistence_bridge;

import 'package:js/js.dart';

@JS('setProp')
external void jsSet(String propertyName, dynamic value);

@JS('getProp')
external dynamic jsGet(String propertyName);
