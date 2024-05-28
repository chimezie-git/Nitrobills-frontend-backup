import 'package:fluttertoast/fluttertoast.dart';

class NbToast {
  static void show(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
