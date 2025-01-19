import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_club_app/core/dialogs/device_removal_confirmationDialog.dart';
import 'package:smart_club_app/pages/fan_page/controller/fan_page_state_controller.dart';
import 'package:smart_club_app/pages/fan_page/widgets/device_slider.dart';
import 'package:smart_club_app/pages/fan_page/widgets/device_status.dart';
import 'package:smart_club_app/pages/fan_page/widgets/device_switch.dart';
import 'package:smart_club_app/pages/fan_page/widgets/slider_percentage_value.dart';
import 'package:smart_club_app/util/screen_metaData.dart';
import 'package:smart_club_app/util/theme.dart';

class FansPage extends ConsumerWidget {
  const FansPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(fansPageStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fans', style: TextStyle(fontSize: 28)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
      ),
      body: Builder(builder: (context) {
        if (state is FanPageIntialState) {
          return Center(
            child: SpinKitCircle(
              color:
                  Colors.tealAccent, // Replace with your theme's primary color
              size: 50.0,
            ),
          );
        } else if (state is FanPageLoadedState) {
          return state.listOfDevices.isEmpty
              ? const Center(
                  child: Text("No fan added yet"),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: ListView.builder(
                    itemCount: state.listOfDevices.length,
                    itemBuilder: (context, index) {
                      var device = state.listOfDevices[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Container(
                            width:
                                getScreenWidth(context) * 0.75, // Dynamic width
                            height: getScreenHeight(context) * 0.35,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF1F1F1F), Color(0xFF292929)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(4, 4),
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(-4, -4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 30,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.ac_unit,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                              size: 36,
                                            ),
                                            const Spacer(),
                                            DeviceSwitch(device: device)
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 20,
                                        child: Text(
                                          device.deviceName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 20,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: DeviceSlider(
                                                  device: device,
                                                  theme: myTheme),
                                            ),
                                            SliderPercentageValue(
                                              device: device,
                                              theme: myTheme,
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                flex: 10,
                                                child: MaterialButton(
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      showFanRemovalConfirmationDialog(
                                                          device, context, ref);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ))),
                                            const Spacer(
                                              flex: 50,
                                            ),
                                            Expanded(
                                              flex: 20,
                                              child: Text(
                                                "Status: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 20,
                                              child: DeviceStatus(
                                                  device: device,
                                                  theme: myTheme),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Dynamically positioned remove icon
                                  // Positioned(
                                  //   top: -getScreenWidth(context) * 0.035,
                                  //   right: -getScreenWidth(context) * 0.035,
                                  //   child: InkWell(
                                  //     onTap: () async {

                                  //     },
                                  //     child: const FanPageRemoveIcon(),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        } else if (state is FanPageErrorState) {
          var errorState = state as FanPageErrorState;
          return Center(
            child: Text(errorState.error.toString()),
          );
        } else {
          return const Center(
            child: Text("Unknown State"), // Fallback for unexpected states
          );
        }
      }),
    );
  }
}
