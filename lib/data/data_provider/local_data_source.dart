import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/error/exception.dart';
import '../../presentation/utils/k_strings copy.dart';
import '../model/auth/user_login_response_model.dart';
import '../model/auth/user_profile_model.dart';
import '../model/setting/website_setup_model.dart';

abstract class LocalDataSource {
  /// Gets the cached [UserLoginResponseModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  UserLoginResponseModel getUserResponseModel();

  Future<bool> cacheUserResponse(UserLoginResponseModel userLoginResponseModel);

  Future<bool> cacheUserProfile(UserProfileModel userProfileModel);

  Future<bool> clearUserProfile();
  Future<bool> clearCoupon();

  bool checkOnBoarding();

  Future<bool> cacheOnBoarding();

  WebsiteSetupModel getWebsiteSetting();
}

class LocalDataSourceImpl implements LocalDataSource {
  final _className = 'LocalDataSourceImpl';
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  UserLoginResponseModel getUserResponseModel() {
    final jsonString =
        sharedPreferences.getString(KStrings.cachedUserResponseKey);
    if (jsonString != null) {
      return UserLoginResponseModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheUserResponse(
      UserLoginResponseModel userLoginResponseModel) {
    return sharedPreferences.setString(
      KStrings.cachedUserResponseKey,
      userLoginResponseModel.toJson(),
    );
  }

  @override
  Future<bool> cacheUserProfile(UserProfileModel userProfileModel) {
    final user = getUserResponseModel();
    user.user != userProfileModel;
    return cacheUserResponse(user);
  }

  @override
  Future<bool> clearUserProfile() {
    return sharedPreferences.remove(KStrings.cachedUserResponseKey);
  }

  @override
  bool checkOnBoarding() {
    final jsonString = sharedPreferences.getBool(KStrings.cachOnboardingKey);
    if (jsonString != null) {
      return true;
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheOnBoarding() {
    return sharedPreferences.setBool(KStrings.cachOnboardingKey, true);
  }

  @override
  Future<bool> clearCoupon() {
    // TODO: implement clearCoupon
    throw UnimplementedError();
  }

  // @override
  // Future<bool> cacheWebsiteSetting(WebsiteSetupModel settingModel) async {
  //   log(settingModel.toJson(), name: _className);
  //   return sharedPreferences.setString(
  //       KStrings.cachedWebSettingKey, settingModel.toJson());
  // }

  @override
  WebsiteSetupModel getWebsiteSetting() {
    final jsonString =
        sharedPreferences.getString(KStrings.cachedWebSettingKey);
    log(jsonString.toString(), name: _className);
    if (jsonString != null) {
      return WebsiteSetupModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }
}
