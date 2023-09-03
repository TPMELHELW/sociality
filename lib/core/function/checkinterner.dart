import 'dart:io';

checkInternet() async {
  try {
    var responce = await InternetAddress.lookup('google.com');
    if (responce.isNotEmpty && responce[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}
