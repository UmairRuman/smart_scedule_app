import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_club_app/pages/bulbs_page/controller/bulb_page_state_controller.dart';
import 'package:smart_club_app/pages/fan_page/widgets/device_status.dart';
import 'package:smart_club_app/pages/fan_page/widgets/device_switch.dart';
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
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 12, right: 100, left: 100),
                  child: ListView.builder(
                    itemCount: state.listOfDevices.length,
                    itemBuilder: (context, index) {
                      var device = state.listOfDevices[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 140,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.ac_unit,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 36,
                                    ),
                                    const Spacer(),
                                    DeviceSwitch(device: device)
                                  ],
                                ),
                                Text(
                                  device.deviceName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Status: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    const SizedBox(width: 5),
                                    DeviceStatus(device: device, theme: myTheme)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        } else {
          String error = (state as BulbPageErrorState).error;
          return Center(
            child: Text(error.toString()),
          );
        }
      }),
    );
  }
}
