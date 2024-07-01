import 'package:nitrobills/app/data/models/mobile_service_provider.dart';

class NetworkProviderService {
  static const String _mtnKey = 'mtn';
  static const String _gloKey = 'glo';
  static const String _airtelKey = 'airtel';
  static const String _nineMobileKey = '9mobile';
  static const String _starcomsKey = 'starcoms';
  static const String _smileKey = 'smile';
  static const String _multilinksKey = 'multilinks';
  static const String _mtelKey = 'mtel';

  static const Map<String, List<String>> _fivePrefix = {
    _mtnKey: ["07025", "07026"],
    _starcomsKey: ["07028", "07029"],
    _multilinksKey: ["07027"],
    _smileKey: ["07020"],
  };

  static const Map<String, List<String>> _fourPrefix = {
    _mtnKey: [
      "0703",
      "0704",
      "0706",
      "0707",
      "0803",
      "0806",
      "0810",
      "0813",
      "0814",
      "0816",
      "0903",
      "0906",
      "0913",
      "0916"
    ],
    _airtelKey: [
      "0701",
      "0708",
      "0802",
      "0808",
      "0812",
      "0901",
      "0902",
      "0904",
      "0907",
      "0912",
      "0911"
    ],
    _nineMobileKey: ["0809", "0817", "0818", "0909", "0908"],
    _gloKey: ["0705", "0805", "0807", "0811", "0815", "0905", "0915"],
    _starcomsKey: ["0819"],
    _multilinksKey: ["0709"],
    _mtelKey: ["0804"],
  };

  static MobileServiceProvider _getMobileProvider(String name) {
    switch (name) {
      case _mtnKey:
        return MobileServiceProvider.mtn;
      case _airtelKey:
        return MobileServiceProvider.airtel;
      case _nineMobileKey:
        return MobileServiceProvider.nineMobile;
      case _gloKey:
        return MobileServiceProvider.glo;
      case _mtelKey:
        return MobileServiceProvider.mtel;
      case _starcomsKey:
        return MobileServiceProvider.starcomms;
      case _multilinksKey:
        return MobileServiceProvider.multilinks;
      case _smileKey:
        return MobileServiceProvider.smile;
      default:
        throw Exception("Mobile Provider Not available");
    }
  }

  static bool isNigerianNumber(String phone) {
    if (phone[0] == "+") {
      if (phone.substring(0, 4) == "+234") {
        return true;
      } else {
        return false;
      }
    } else if (phone[0] == "0") {
      return true;
    } else {
      return false;
    }
  }

  static String extractNumber(String phone) {
    String number;
    if (phone[0] == "+") {
      if (phone.substring(0, 4) == "+234") {
        if (phone[4] == '0') {
          number = phone.substring(4);
        } else {
          number = '0${phone.substring(4)}';
        }
      } else {
        throw Exception("Not a Nigerian Number");
      }
    } else if (phone[0] == "0") {
      number = phone;
    } else {
      throw Exception("Not a Nigerian Number");
    }
    return number;
  }

  static MobileServiceProvider checkProvider(String phone) {
    String number = extractNumber(phone);
    String fivePrefix = number.substring(0, 5);
    final fiveEntries = _fivePrefix.entries.toList();
    for (int i = 0; i < fiveEntries.length; i++) {
      if (fiveEntries[i].value.contains(fivePrefix)) {
        return _getMobileProvider(fiveEntries[i].key);
      }
    }
    String fourPrefix = number.substring(0, 4);
    final fourEntries = _fourPrefix.entries.toList();
    for (int i = 0; i < fourEntries.length; i++) {
      if (fourEntries[i].value.contains(fourPrefix)) {
        return _getMobileProvider(fourEntries[i].key);
      }
    }
    throw Exception("Mobile provider not found");
  }
}
