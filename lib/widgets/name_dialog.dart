import 'package:dice_roller/persistence/settings_controller.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class NameDialog extends StatefulWidget {
  const NameDialog({super.key, required this.animation});

  final Animation<double> animation;

  static Future<void> show(context) async => showGeneralDialog(
      context: context,
      pageBuilder: (_, animation, __) => NameDialog(animation: animation));

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  final _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    _controller.text = context.read<SettingsController>().playerName.value;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeOutCubic,
      ),
      child: SimpleDialog(
        contentPadding: const EdgeInsets.all(16),
        title: const Text('Player Name'),
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: 12,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onChanged: (value) =>
                context.read<SettingsController>().setPlayerName(value),
            // Player tapped 'Submit'/'Done' on their keyboard.
            onSubmitted: (_) => context.pop(),
          ),
          const SizedBox(height: 16),
          RoughButton(onTap: context.pop, child: const Text('Close')),
        ],
      ),
    );
  }
}
