import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_p2p/core/constants/enums.dart';
import 'package:tic_tac_toe_p2p/core/models/game_state.dart';

enum DeviceType { advertiser, browser }

class P2pManager {
  Player get player =>
      _deviceType == DeviceType.advertiser ? Player.p1 : Player.p2;

  bool get isUserFound => connectedDevices.isNotEmpty;

  List<Device> connectedDevices = [];
  GameState gameState = Get.put(GameState());

  late NearbyService _nearbyService;
  late StreamSubscription _subscription;
  late StreamSubscription _receivedDataSubscription;
  late Function(dynamic) _onNewMessageReceived;
  late Function() _onDevicesStateChanged;
  late DeviceType _deviceType;

  P2pManager(
      {required DeviceType deviceType,
      required Function() onDevicesStateChanged,
      required Function(dynamic) onNewMessageReceived}) {
    _deviceType = deviceType;
    _onNewMessageReceived = onNewMessageReceived;
    _onDevicesStateChanged = onDevicesStateChanged;
    _nearbyService = NearbyService();
    _init();
  }

  void _init() async {
    String devInfo = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devInfo = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devInfo = iosInfo.localizedModel;
    }

    await _nearbyService.init(
        serviceType: 'mpconn',
        deviceName: devInfo,
        strategy: Strategy.P2P_CLUSTER,
        callback: (isRunning) async {
          if (isRunning) {
            if (_deviceType == DeviceType.browser) {
              await _nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await _nearbyService.startBrowsingForPeers();
            } else {
              await _nearbyService.stopAdvertisingPeer();
              await _nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await _nearbyService.startAdvertisingPeer();
              await _nearbyService.startBrowsingForPeers();
            }
          }
        });

    _subscription =
        _nearbyService.stateChangedSubscription(callback: (devicesList) async {
      connectedDevices = [];
      for (var element in devicesList) {
        debugPrint(
            " deviceId: ${element.deviceId} | deviceName: ${element.deviceName} | state: ${element.state}");

        if (element.state != SessionState.connected) {
          await _connect(element.deviceId, element.deviceName);
        }
        connectedDevices.add(element);
        break;
      }
      _onDevicesStateChanged();
    });

    _receivedDataSubscription =
        _nearbyService.dataReceivedSubscription(callback: (data) {
      debugPrint("dataReceivedSubscription: ${jsonEncode(data)}");
      _onNewMessageReceived(data);
      debugPrint(jsonEncode(data));
    });
  }

  void dispose() {
    _subscription.cancel();
    _receivedDataSubscription.cancel();
    _nearbyService.stopBrowsingForPeers();
    _nearbyService.stopAdvertisingPeer();
  }

  Future<void> _connect(String deviceId, String deviceName) async {
    await _nearbyService.invitePeer(
      deviceID: deviceId,
      deviceName: deviceName,
    );
  }

  void _sendMessage(Map message) {
    if (connectedDevices.isNotEmpty) {
      print("sending message...");
      print(connectedDevices.first.deviceId);
      print(message);
      _nearbyService.sendMessage(
          connectedDevices.first.deviceId, jsonEncode(message));
    } else {
      print("NO DEVICE CONNECTED");
    }
  }

  void sendGameState(GameState gameState) {
    print('herrrrr');
    _sendMessage(
        {"data": gameState.fields.map((e) => (e?.index) ?? 2).toList()});
  }
}
