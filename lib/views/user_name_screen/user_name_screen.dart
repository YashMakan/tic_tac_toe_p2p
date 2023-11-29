import 'package:flutter/material.dart';
import 'package:tic_tac_toe_p2p/core/constants/enums.dart';
import 'package:tic_tac_toe_p2p/core/local_db/local_db.dart';
import 'package:tic_tac_toe_p2p/core/widgets/background_widget.dart';
import 'package:tic_tac_toe_p2p/core/widgets/custom_button.dart';
import 'package:tic_tac_toe_p2p/core/widgets/custom_chip.dart';
import 'package:tic_tac_toe_p2p/core/widgets/custom_textfield.dart';
import 'package:tic_tac_toe_p2p/views/home_screen/home_screen.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BackgroundWidget(
      child: SafeArea(
        child: Column(
          children: [
            const CustomChip(title: 'ENTER PLAYER NAME'),
            Expanded(
              flex: 3,
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PLAYER NAME',
                          style: textTheme.headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(controller: controller,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: CustomButton(
                    title: 'Continue',
                    onTap: () {
                      if(controller.text.trim().isNotEmpty) {
                        LocalDB.setUserName(controller.text).then((_) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                        });
                      }
                    },
                    buttonStyleType: ButtonStyleType.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
