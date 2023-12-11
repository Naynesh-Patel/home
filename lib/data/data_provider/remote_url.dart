class RemoteUrls {
  static const String rootUrl = "https://quomodothemes.website/homeco/";
  // static const String rootUrl = "https://mamunuiux.com/homeco/";

  static const String baseUrl = '${rootUrl}api/';
  static const String homeUrl = baseUrl;
  static const String userRegister = '${baseUrl}store-register';
  static const String userLogin = '${baseUrl}store-login';
  static const String websiteSetup = '${baseUrl}website-setup';

  static String createPropertyInfoUrl(String token, String purpose) =>
      '${baseUrl}user/property/create?token=$token&purpose=$purpose';

  static String editInfoUrl(String id, String token) =>
      '${baseUrl}user/property/$id/edit?token=$token';

  static String getPropertyChooseInfo(String token) =>
      '${baseUrl}user/choose-property-type?token=$token';

  static String changePassword(String token) =>
      '${baseUrl}user/update-password?token=$token';

  static String userLogOut(String token) =>
      '${baseUrl}user/logout?token=$token';
  static const String sendForgetPassword = '${baseUrl}send-forget-password';
  static const String resendRegisterCode = '${baseUrl}resend-register-code';

  static String storeResetPassword = '${baseUrl}store-reset-password';

  static String userVerification = '${baseUrl}user-verification';
  static String resendVerificationCode = '${baseUrl}resend-register';

  static String singlePropertyDetailsUrl(String slug) =>
      '${baseUrl}property/$slug';

  static String createPropertyUrl(String token) =>
      '${baseUrl}user/property?token=$token';

  static String updatePropertyUrl(String id, String token) =>
      '${baseUrl}user/update-property/$id?token=$token';

  static String removeSliderImageUrl(String id, String token) =>
      '${baseUrl}user/remove-property-slider/$id?token=$token';

  static String removeSingleNearestLocationUrl(String id, String token) =>
      '${baseUrl}user/remove-nearest-location/$id?token=$token';

  static String removeSingleAddInfoUrl(String id, String token) =>
      '${baseUrl}user/remove-add-infor/$id?token=$token';

  static String removeSinglePlanUrl(String id, String token) =>
      '${baseUrl}user/remove-plan/$id?token=$token';

  static String deletePropertyUrl(String id, String token) =>
      '${baseUrl}user/property/$id?token=$token';

  static String getAgentDashboardInfo(String token) =>
      '${baseUrl}user/dashboard?token=$token';

  static String getAgentProfile(String token) =>
      '${baseUrl}user/my-profile?token=$token';

  static String getAllAgent() => '${baseUrl}agents';

  static String getAgentDetails(String userName) =>
      '${baseUrl}agent?agent_type=agent&user_name=$userName';

  static String sendMessageToAgent() => '${baseUrl}send-mail-to-agent';

  static String updateAgentProfileInfo(String token) =>
      '${baseUrl}user/update-profile?token=$token';

  static String getFaqContent() => '${baseUrl}faq';

  static String getPrivacyPolicy() => '${baseUrl}privacy-policy';

  static String getTermsAndCondition() => '${baseUrl}terms-and-conditions';

  static String getReviewList(String token) =>
      '${baseUrl}user/my-reviews?token=$token';

  static String getWishListProperties(String token) =>
      '${baseUrl}user/wishlist?token=$token';

  static String addToWishlist(String token, String id) =>
      '${baseUrl}user/add-to-wishlist/$id?token=$token';

  static String removeFromWishlist(String token, String id) =>
      '${baseUrl}user/remove-wishlist/$id?token=$token';

  static String getContactUs() => '${baseUrl}contact-us';
  static String sendContactUsMessage = '${baseUrl}send-contact-message';

  static String getAboutUs() => '${baseUrl}about-us';

  static String getAllOrders(String token) =>
      '${baseUrl}user/orders?token=$token';

  static String getOrderDetails(String token, String orderId) =>
      '${baseUrl}user/order/$orderId?token=$token';

  static String getPricePlan() => '${baseUrl}pricing-plan';

  static String getPaymentPageInformation(String token, String planSlug) =>
      '${baseUrl}payment/$planSlug?token=$token';

  //payment urls start

  static String freeEnrollment(String token, String planSlug) =>
      '${baseUrl}free-enroll/$planSlug?token=$token';

  static String bankPayment(String token, String planSlug) =>
      '${baseUrl}bank-payment/$planSlug?token=$token';

  static String stripePayment(String token, String planSlug) =>
      '${baseUrl}pay-with-stripe/$planSlug?token=$token';

  static String payWithFlutterWave(String token, String planSlug) =>
      '${rootUrl}flutterwave-webview/$planSlug?token=$token';

  static String payWithPayStack(String token, String planSlug) =>
      '${rootUrl}paystack-webview/$planSlug?token=$token';

  static String payWithMolli(String token, String planSlug) =>
      '${rootUrl}mollie-webview/$planSlug?token=$token';

  static String payWithInstamojo(String token, String planSlug) =>
      '${rootUrl}instamojo-webview/$planSlug?token=$token';

  static String payWithRazorpay(String token, String planSlug) =>
      '${rootUrl}razorpay-webview/$planSlug?token=$token';

  static String payWithPaypal(String token, String planSlug) =>
      '${rootUrl}paypal-webview/$planSlug?token=$token';

  //payment urls end

  static String getSearchProperty = '${baseUrl}properties?';
  static String getAllProperty = '${baseUrl}properties';
  static String getFilterProperty = '${baseUrl}properties?';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;
}
