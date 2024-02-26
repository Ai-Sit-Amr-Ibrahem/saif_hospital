

import 'package:hive/hive.dart';

import '../../features/auth/data/model/login_model.dart';

class HiveHelper {
  static const boxKeyUserData = "boxKeyUserSit";
  static const userToken = "userTokenSit";
  static const boxBasketKey = 'boxBasketKey';



  static LoginModel? getUserData() {
    return Hive.box(HiveHelper.boxKeyUserData).isNotEmpty
        ? userModelFromJson(
      Hive.box(HiveHelper.boxKeyUserData).get(HiveHelper.boxKeyUserData),
    )
        : null;
  }

  static void setUserData(LoginModel userModel) async {
    Hive.box(HiveHelper.boxKeyUserData)
        .put(HiveHelper.boxKeyUserData, userModelToJson(userModel));
  }


  // static void setLangState(String state) {
  //   Hive.box(HiveHelper.langState).put(HiveHelper.langState, state);
  // }
  //
  // static String getLangState() {
  //   return Hive.box(HiveHelper.langState).isNotEmpty
  //       ? Hive.box(HiveHelper.langState).get(HiveHelper.langState)
  //       : 'en';
  // }
  //
  static void setToken(String token) {
    Hive.box(HiveHelper.userToken).put(HiveHelper.userToken, token);
  }

  static String getToken() {
    return Hive.box(HiveHelper.userToken).isNotEmpty
        ? Hive.box(HiveHelper.userToken).get(HiveHelper.userToken)
        : '';
  }
  //
  // static bool getModeState() {
  //   return Hive.box(HiveHelper.darkMode).isNotEmpty
  //       ? Hive.box(HiveHelper.darkMode).get(HiveHelper.darkMode)
  //       : false;
  // }
  //
  // static void setModeState(bool isDark) {
  //   Hive.box(HiveHelper.darkMode).put(HiveHelper.darkMode, isDark);
  // }
  //
  static void logout() {
    Hive.box(boxKeyUserData).clear();
    Hive.box(userToken).clear();
    // Get.offAll(HomeLayout());
  }
  //
  // static bool getIsArabic() {
  //   return Hive.box(HiveHelper.lang).isNotEmpty
  //       ? Hive.box(HiveHelper.lang).get(HiveHelper.lang)
  //       : true;
  // }
  //
  // static void setIsArabic(bool isDark) {
  //   Hive.box(HiveHelper.lang).put(HiveHelper.lang, isDark);
  // }

  // static CartModelResponse? getBasketData() {
  //   return Hive.box(HiveHelper.boxBasketKey).isNotEmpty
  //       ?productsBasketFromJson(
  //     Hive.box(HiveHelper.boxBasketKey).get(HiveHelper.boxBasketKey),
  //   )
  //       : null;
  // }
  //
  // static void setBasketData(CartModelResponse productResponse) async {
  //   Hive.box(HiveHelper.boxBasketKey)
  //       .put(HiveHelper.boxBasketKey, productsBasketToJson(productResponse));
  // }

  static void clearBasket() {
    Hive.box(HiveHelper.boxBasketKey).clear();
    // Get.offAll(HomeLayout());
  }

}
