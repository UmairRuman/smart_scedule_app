import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_club_app/core/functions/global_functions.dart';
import 'package:smart_club_app/core/services/service_locater.dart';
import 'package:smart_club_app/util/shared_prefrences_key.dart';

class SharedPrefrenceService {
  static SharedPrefrenceService? sharedPrefrenceService;
  SharedPrefrenceService._internal();

  factory SharedPrefrenceService() {
    return sharedPrefrenceService ??= SharedPrefrenceService._internal();
  }
  Future<bool> insertAdminkeyInPrefs() async {
    String adminKey = await getAdminKey();
    SharedPreferences prefs = serviceLocator.get<SharedPreferences>();
    bool isInserted = await prefs.setString(SharedPrefKeys.adminKey, adminKey);
    return isInserted;
  }

  bool isAdminKeyInPrefs() {
    SharedPreferences prefs = serviceLocator.get<SharedPreferences>();
    String? adminKey = prefs.getString(SharedPrefKeys.adminKey);
    if (adminKey != null) {
      return true;
    } else {
      return false;
    }
  }

  String getAdminKeyFromPrefs() {
    SharedPreferences prefs = serviceLocator.get<SharedPreferences>();
    String? adminKey = prefs.getString(SharedPrefKeys.adminKey);
    return adminKey ?? "";
  }

  Future<bool> insertCurrentPretimer(int preTimer) async {
    SharedPreferences prefs = serviceLocator.get<SharedPreferences>();
    bool isInserted = await prefs.setString(
        SharedPrefKeys.pretimerDuration, preTimer.toString());
    return isInserted;
  }

  String getCurrentPretimer() {
    SharedPreferences prefs = serviceLocator.get<SharedPreferences>();
    String? pretimerDuration = prefs.getString(SharedPrefKeys.pretimerDuration);
    return pretimerDuration ?? "";
  }

  bool isCurrentPretimerInPrefs() {
    SharedPreferences prefs = serviceLocator.get<SharedPreferences>();
    String? pretimerDuration = prefs.getString(SharedPrefKeys.pretimerDuration);
    if (pretimerDuration != null) {
      return true;
    } else {
      return false;
    }
  }
}
