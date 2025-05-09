class AppNamedRoutes {
  // Authentication routes
  static String root = '/';
  static String landing = '${root}landing';

  static String toSignIn = '${root}signin';
  static String toForgotPass = '$toSignIn/forgot-password';
  static String toSignUp = '${root}signup';

  // from homepage
  static String home = '${root}home';
  static String toPurchaseLists = '${root}purchase-lists';
  static String fromHomeToPurchaseDetail = '${root}purchase-details';
  static String toShopView = '${root}shopview';
  static String toProfile = '${root}profile';

  // from purchase lists
  static String toPurchaseDetail = '$toPurchaseLists/purchase-details';

  
  // from purchase detail
  static String toStatusUpdated(String id) {
    return '$toPurchaseDetail/$id/status-updated';
  }
}
