import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart' show Uint8List;
import 'package:url_launcher/url_launcher.dart';

class NbContactUtils {
  static Future<void> phoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> sendEmail({
    required String toEmail,
    String subject = '',
    String body = '',
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  static void shareOnFacebook(String message) {
    final url = Uri.encodeComponent(message);
    final facebookUrl = 'https://www.facebook.com/sharer/sharer.php?u=$url';
    Share.share('Check this out: $facebookUrl');
  }

  static Future<void> shareOnInstagram(Uint8List imgByte) async {
    try {
      final fileXByte = XFile.fromData(imgByte);
      await Share.shareXFiles([fileXByte],
          text: 'Check this out on Instagram!');
    } catch (e) {
      debugPrint('Error sharing on Instagram: $e');
    }
  }

  static Future<void> shareOnTwitter(String message) async {
    final String encodedMessage = Uri.encodeComponent(message);
    final Uri twitterUri = Uri(
      scheme: 'https',
      host: 'twitter.com',
      path: 'intent/tweet',
      queryParameters: {'text': encodedMessage},
    );

    if (await canLaunchUrl(twitterUri)) {
      await launchUrl(twitterUri);
    }
  }

  static Future<void> shareOnWhatsApp(String message) async {
    final String encodedMessage = Uri.encodeComponent(message);
    final String url = 'https://wa.me/?text=$encodedMessage';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
