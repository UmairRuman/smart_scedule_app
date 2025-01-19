import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_club_app/core/dialogs/device_removal_confirmationDialog.dart';
import 'package:smart_club_app/pages/bulbs_page/controller/bulb_page_state_controller.dart';
import 'package:smart_club_app/pages/fan_page/widgets/device_status.dart';
import 'package:smart_club_app/pages/fan_page/widgets/device_switch.dart';
import 'package:smart_club_app/util/screen_metaData.dart';
import 'package:smart_club_app/util/theme.dart';

class BulbPage extends ConsumerWidget {
  const BulbPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(bulbsPageStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulbs', style: TextStyle(fontSize: 28)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
      ),
      body: Builder(builder: (context) {
        if (state is BulbPageIntialState) {
          return Center(
            child: SpinKitCircle(
              color:
                  Colors.tealAccent, // Replace with your theme's primary color
              size: 50.0,
            ),
          );
        } else if (state is BulbPageIntialState) {
          return Center(
            child: SpinKitCircle(
              color:
                  Colors.tealAccent, // Replace with your theme's primary color
              size: 50.0,
            ),
          );
        } else if (state is BulbPageLoadedState) {
          return state.listOfDevices.isEmpty
              ? Center(
                  child: Text("No Bulb Added yet"),
                )
              : ListView.builder(
                  itemCount: state.listOfDevices.length,
                  itemBuilder: (context, index) {
                    var device = state.listOfDevices[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                        child: Container(
                          width: getScreenWidth(context) * 0.7, // Dynamic width
                          height: getScreenHeight(context) * 0.3,
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
                            child: Stack(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 30,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.ac_unit,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          size: 36,
                                        ),
                                        const Spacer(),
                                        DeviceSwitch(device: device)
                                      ],
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 5,
                                  ),
                                  Expanded(
                                    flex: 30,
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
                                    flex: 30,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 10,
                                          child: MaterialButton(
                                              color: Colors.red,
                                              onPressed: () {
                                                // showBulbRemovalConfirmationDialog(
                                                //     device, context, ref);
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              )),
                                        ),
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
                                              device: device, theme: myTheme),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Positioned(
                              //   top: -getScreenWidth(context) * 0.035,
                              //   right: -getScreenWidth(context) * 0.035,
                              //   child: GestureDetector(
                              //     onTap: () async {
                              //       log("Taping for bulb removal");
                              //       showBulbRemovalConfirmationDialog(
                              //           device, context, ref);
                              //     },
                              //     child: const FanPageRemoveIcon(),
                              //   ),
                              // ),
                            ]),
                          ),
                        ),
                      ),
                    );
                  },
                );
        } else if (state is BulbPageErrorState) {
          String error = state.error;
          return Center(
            child: Text(error.toString()),
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
