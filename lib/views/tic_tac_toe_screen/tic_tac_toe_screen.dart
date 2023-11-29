import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_p2p/core/constants/enums.dart';
import 'package:tic_tac_toe_p2p/core/models/game_state.dart';
import 'package:tic_tac_toe_p2p/core/p2p_manager/p2p_manager.dart';
import 'package:tic_tac_toe_p2p/core/widgets/background_widget.dart';

import 'widgets/tic_tac_toe_widget.dart';

class TicTacToeScreen extends StatefulWidget {
  final P2pManager p2pManager;

  const TicTacToeScreen({super.key, required this.p2pManager});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  Player get player => widget.p2pManager.player;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BackgroundWidget(
        child: SafeArea(
      child: Obx(() {
        final gameState = Get.find<GameState>();
        print(gameState.status);
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    gameState.formattedStatus(player),
                    style: textTheme.displayMedium?.copyWith(
                        color: gameState.formattedStatusColor(player),
                        shadows: [
                          const BoxShadow(color: Colors.black38, blurRadius: 8)
                        ]),
                  ),
                ),
              ),
              TicTacToeWidget(
                  gameState: gameState,
                  player: player,
                  onSquareClicked: (index) {
                    gameState.claimField(index);
                    widget.p2pManager.sendGameState(gameState);
                  }),
              const Spacer()
            ],
          );
        }
      ),
    ));
  }
}
