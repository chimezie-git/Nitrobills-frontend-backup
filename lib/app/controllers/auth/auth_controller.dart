import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nitrobills/app/data/services/auth/auth_service.dart';
import 'package:nitrobills/app/hive_box/auth_data/auth_data.dart';
import 'package:nitrobills/app/ui/pages/onboarding/intro_page.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class AuthController extends GetxController {
  late final RxString username = RxString("");
  late final RxString firstName = RxString("");
  late final RxString lastName = RxString("");
  late final RxString email = RxString("");
  late final RxString phoneNumber = RxString("");
  late final RxString password = RxString("");
  late final Rxn<DateTime> lastLogin = Rxn<DateTime>(null);
  final RxBool authDataAvailable = RxBool(false);
  final RxBool biometricAvailable = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    _checkLogin();
  }

  Future _checkLogin() async {
    AuthData? data = AuthData.getData();
    if (data != null) {
      username.value = data.username;
      lastName.value = data.lastName;
      firstName.value = data.firstName;
      email.value = data.email;
      phoneNumber.value = data.phoneNumber;
      password.value = data.password;
      lastLogin.value = data.lastLogin;
      // check if biometric is available
      final LocalAuthentication auth = LocalAuthentication();
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      biometricAvailable.value = canAuthenticate;
      authDataAvailable.value = true;
    }
  }

  Future saveLoginData(String username, String lastName, String firstName,
      String email, String phoneNumber, String password) async {
    DateTime now = DateTime.now();
    this.username.value = username;
    this.lastName.value = lastName;
    this.firstName.value = firstName;
    this.email.value = email;
    this.phoneNumber.value = phoneNumber;
    this.password.value = password;
    lastLogin.value = now;
    await AuthData.saveData(
        username, lastName, firstName, email, password, phoneNumber, now);
  }

  Future logoutUser() async {
    final logoutData = await AuthService.logout();
    if (logoutData.isRight) {
      NbUtils.removeNav;
      Get.offAll(() => const IntroPage());
    } else {
      NbToast.show(logoutData.left.message);
    }
  }

  Future resetData() async {
    username.value = "";
    firstName.value = "";
    lastName.value = "";
    email.value = "";
    password.value = "";
    phoneNumber.value = "";
    lastLogin.value = null;
    authDataAvailable.value = false;
    biometricAvailable.value = false;
  }
}
