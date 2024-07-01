import 'package:equatable/equatable.dart';

class UserMobileData extends Equatable {
  final List<UserMobile> allMobile;

  const UserMobileData({required this.allMobile});

  factory UserMobileData.initial() => const UserMobileData(allMobile: []);

  @override
  List<Object?> get props => [allMobile];
}

class UserMobile {
  final String phoneNumber;
  final String provider;
  final double dataBought;
  final double dataRemaining;

  UserMobile({
    required this.phoneNumber,
    required this.provider,
    required this.dataBought,
    required this.dataRemaining,
  });
}
