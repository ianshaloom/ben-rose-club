import 'package:get/get.dart';

import '../../../../core/constants/image_path_const.dart';
import '../../../../core/utils/utility_methods.dart';
import '../../core/errors/failures.dart';
import '../../data/provider/database/models/user.dart';
import '../../data/provider/network/authentication_ds.dart';
import '../../data/repository/auth_repo_impl.dart';
import '../../domain/entity/auth_user.dart';
import '../../domain/usecase/auth_usecase.dart';

class AuthRepoController extends GetxController {
  /// initialize controller
  static AuthRepoController init() => Get.put(
    AuthRepoController(AuthUC(AuthRepoImpl(FirebaseAuthentification()))),
    permanent: true,
  );

  /// find controller
  static AuthRepoController get find => Get.find<AuthRepoController>();

  final AuthUC authUC;

  AuthRepoController(this.authUC);

  // current user
  AuthUser get currentUser => authUC.currentUser;

  // Stream user
  Stream<AuthUser> get user => authUC.user;

  // is loggin in
  var isLoggingIn = false.obs;
  var isSigningUp = false.obs;

  var isResettingPassword = false.obs;
  var isLoggingOut = false.obs;

  // log in
  var loggedInUser = <AuthUser>[].obs;
  var loggedInFailure = <Failure>[].obs;
  Future<void> logIn({required String email, required String password}) async {
    isLoggingIn.value = true;

    final userOrFailure = await authUC.logIn(email: email, password: password);

    userOrFailure.fold((failure) => loggedInFailure.add(failure), (user) async {
      loggedInUser.add(user);
      await saveIsarUser(user, false);
    });

    isLoggingIn.value = false;
  }

  // create user
  var createdUser = <AuthUser>[].obs;
  var createdUserFailure = <Failure>[].obs;
  Future<void> createUser({
    required String username,
    required String email,
    required String password,
  }) async {
    isSigningUp.value = true;

    final userOrFailure = await authUC.createUser(
      username: username,
      email: email,
      password: password,
    );

    userOrFailure.fold((failure) => createdUserFailure.add(failure), (
      user,
    ) async {
      createdUser.add(user);
      await saveIsarUser(user, false);
    });

    isSigningUp.value = false;
  }

  // send password reset link
  var resetLinkSent = false.obs;
  var resetLinkFailure = <Failure>[].obs;
  Future<void> sendPasswordResetLink({required String email}) async {
    isResettingPassword(false);

    final successOrFailure = await authUC.resetPassword(email: email);

    successOrFailure.fold(
      (failure) => resetLinkFailure.add(failure),
      (success) => resetLinkSent(true),
    );
  }

  // verify email
  var emailVerified = false.obs;
  var isVerifyingEmail = false.obs;
  var emailVerificationFailure = <Failure>[].obs;
  Future<void> verifyEmail() async {
    isVerifyingEmail.value = true;

    final successOrFailure = await authUC.verifyEmail();

    successOrFailure.fold(
      (failure) => emailVerificationFailure.add(failure),
      (success) => {},
    );

    isVerifyingEmail.value = false;
  }

  // sign out
  Future<void> signOut() async {
    final successOrFailure = await authUC.signOut();

    successOrFailure.fold(
      (failure) {
        // print('Failure: $failure');
      },
      (success) {
        isLoggingOut.value = false;
        userIsars.clear();
        // print('Success: ${success.successContent}');
      },
    );
  }

  // get local user by id:1
  var userIsars = <UserIsar>[].obs;
  Future<void> getLocalUser1() async {}

  // save google user
  Future<UserIsar> saveIsarUser(AuthUser user, bool isGoogleUser) async {
    final isarUser = UserIsar(
      id: user.id,
      uuid: user.id,
      name: user.name ?? extractNameFromEmail(user.email),
      email: currentUser.email,
      isEmailVerified: user.isEmailVerified,
      isGoogleSignIn: isGoogleUser,
      profileImgUrl: user.profileImgUrl ?? defaultProfilePicture,
    );

    userIsars.add(isarUser);

    return isarUser;
  }
}
