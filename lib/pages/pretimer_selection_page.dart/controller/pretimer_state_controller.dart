import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/core/services/service_locater.dart';
import 'package:smart_club_app/core/services/shared_prefrence_Service.dart';
import 'package:smart_club_app/pages/pretimer_selection_page.dart/collection/pretimer_collection.dart';

final pretimerStateProvider =
    NotifierProvider<PretimerStateController, int>(PretimerStateController.new);

class PretimerStateController extends Notifier<int> {
  PretimerCollection pretimerCollection = PretimerCollection();
  @override
  int build() {
    intiallize();
    return state;
  }

  void intiallize() async {
    bool isPretimerInPrefs =
        serviceLocator.get<SharedPrefrenceService>().isCurrentPretimerInPrefs();
    if (isPretimerInPrefs) {
      String pretimerDuration =
          serviceLocator.get<SharedPrefrenceService>().getCurrentPretimer();
      int duration = int.parse(pretimerDuration);
      state = duration;
    } else {
      log("Failed to intiallize pretimer in Pretimer state controller class");
    }
  }

  void getPretimerById(int duration) async {
    try {
      var list = await pretimerCollection.getPretimersByDuration(duration);

      int currentPretimerDuration = list[0].pretimerDuration;
      serviceLocator
          .get<SharedPrefrenceService>()
          .insertCurrentPretimer(currentPretimerDuration);
      state = currentPretimerDuration;
    } catch (e) {
      log("Error getting pretimer by duration: $e");
    }
  }
}

enum PretimerStates { two, five, ten }
