import '../../../../../../core/constants/image_path_const.dart';

class UserIsar {
  const UserIsar({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.isEmailVerified,
    required this.isGoogleSignIn,
    required this.profileImgUrl,
  });

  final String id;
  final String uuid;
  final String name;
  final String email;
  final String profileImgUrl;
  final bool isGoogleSignIn;
  final bool isEmailVerified;

  static UserIsar get empty => const UserIsar(
    id: '',
    uuid: '',
    name: '',
    email: '',
    isEmailVerified: true,
    isGoogleSignIn: false,
    profileImgUrl: defaultProfilePicture,
  );
}
