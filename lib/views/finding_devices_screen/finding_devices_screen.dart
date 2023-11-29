import 'dart:convert';

import 'package:device_scan_animation/device_scan_animation.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_p2p/core/constants/enums.dart';

// import 'package:tic_tac_toe_p2p/core/p2p_manager/p2p_manager.dart';
import 'package:tic_tac_toe_p2p/core/p2p_manager/p2p_manager.dart';
import 'package:tic_tac_toe_p2p/core/widgets/background_widget.dart';
import 'package:tic_tac_toe_p2p/core/widgets/custom_button.dart';
import 'package:tic_tac_toe_p2p/core/widgets/custom_chip.dart';
import 'package:tic_tac_toe_p2p/views/tic_tac_toe_screen/tic_tac_toe_screen.dart';

class FindingDevicesScreen extends StatefulWidget {
  final DeviceType deviceType;

  const FindingDevicesScreen({super.key, required this.deviceType});

  @override
  State<FindingDevicesScreen> createState() => _FindingDevicesScreenState();
}

class _FindingDevicesScreenState extends State<FindingDevicesScreen> {
  late P2pManager p2pManager;

  @override
  void initState() {
    p2pManager = P2pManager(
        deviceType: widget.deviceType,
        onDevicesStateChanged: () {
          if(mounted) {
            setState(() {});
          }
        },
        onNewMessageReceived: (data) {
          p2pManager.gameState.fields.value = List<Player?>.from(jsonDecode(data['message'])['data']
              .map((e) => e == 0
                  ? Player.p1
                  : e == 1
                      ? Player.p2
                      : null)
              .toList());
        });
    super.initState();
  }

  @override
  void dispose() {
    // p2pManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: SafeArea(
        child: Column(
          children: [
            CustomChip(
                title: p2pManager.isUserFound ? 'USER FOUND' : 'SCANNING...'),
            Expanded(
              flex: 4,
              child: Center(
                child: DeviceScanWidget(
                  gap: 35,
                  layers: 6,
                  nodeType: NodeType.even,
                  newNodesDuration: const Duration(seconds: 5),
                  ringThickness: 3,
                  nodeColor: Colors.lightGreenAccent,
                  scanColor: const Color(0xFFAB50F4),
                ),
              ),
            ),
            if (p2pManager.isUserFound)
              Expanded(
                flex: 2,
                child: Center(
                  child: CustomButton(
                      title: 'START GAME!',
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              TicTacToeScreen(p2pManager: p2pManager),
                        ));
                      },
                      buttonStyleType: ButtonStyleType.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
