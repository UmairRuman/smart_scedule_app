import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_club_app/core/services/shared_prefrence_Service.dart';
import 'package:smart_club_app/core/usb_serial_services/usb_serial_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setupLocator() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(
    () => sharedPreferences,
  );
  serviceLocator.registerSingleton(SharedPrefrenceService());
  serviceLocator.registerSingleton(UsbSerialService());
}
