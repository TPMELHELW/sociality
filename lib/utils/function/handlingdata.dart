import 'package:sociality/utils/class/enum.dart';

handlingData(responce) {
  if (responce is StatusRequest) {
    return responce;
  } else {
    return StatusRequest.success;
  }
}
