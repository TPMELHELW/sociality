import 'package:sociality/core/class/enum.dart';

handlingData(responce) {
  if (responce is StatusRequest) {
    return responce;
  } else {
    return StatusRequest.success;
  }
}
