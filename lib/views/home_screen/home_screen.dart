import 'package:flutter/material.dart';
import 'package:tic_tac_toe_p2p/core/assets/assets.dart';
import 'package:tic_tac_toe_p2p/core/constants/enums.dart';
import 'package:tic_tac_toe_p2p/core/local_db/local_db.dart';
import 'package:tic_tac_toe_p2p/core/p2p_manager/p2p_manager.dart';
import 'package:tic_tac_toe_p2p/core/widgets/background_widget.dart';
import 'package:tic_tac_toe_p2p/core/widgets/custom_button.dart';
import 'package:tic_tac_toe_p2p/core/widgets/custom_chip.dart';
import 'package:tic_tac_toe_p2p/views/finding_devices_screen/finding_devices_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: SafeArea(
        child: Column(
          children: [
            CustomChip(title: 'WELCOME BACK, ${LocalDB.userName ?? ""}'),
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Image.asset(Assets.images.banner),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    CustomButton(
                        title: 'CREATE GAME!',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FindingDevicesScreen(
                                deviceType: DeviceType.advertiser),
                          ));
                        },
                        buttonStyleType: ButtonStyleType.green),
                    const SizedBox(height: 24),
                    CustomButton(
                        title: 'JOIN GAME!',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FindingDevicesScreen(
                              deviceType: DeviceType.browser,
                            ),
                          ));
                        },
                        buttonStyleType: ButtonStyleType.green)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
