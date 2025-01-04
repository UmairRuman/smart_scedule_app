import 'package:flutter_riverpod/flutter_riverpod.dart';

final editModeProvider =
    NotifierProvider<EditModeNotifier, bool>(EditModeNotifier.new);

class EditModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void onSwitchingEditMode() {
    state = state == true ? false : true;
  }
}
