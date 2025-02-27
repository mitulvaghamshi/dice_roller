import 'package:dice_roller/src/controllers/settings_controller.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class NameDialog extends StatefulWidget {
  const NameDialog({super.key, required this.animation});

  final Animation<double> animation;

  static Future<void> show(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (_, animation, _) => NameDialog(animation: animation),
    );
  }

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  final _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.text = context.read<SettingsController>().playerName.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeOutCubic,
    ),
    child: SimpleDialog(
      contentPadding: const .all(16),
      title: const Text('Player Name'),
      children: [
        TextField(
          controller: _controller,
          maxLength: 12,
          autofocus: true,
          maxLengthEnforcement: .enforced,
          textCapitalization: .words,
          textInputAction: .done,
          textAlign: .center,
          onChanged: (value) =>
              context.read<SettingsController>().setPlayerName(value),
          // Player tapped 'Submit'/'Done' on their keyboard.
          onSubmitted: (_) => context.pop(),
        ),
        const SizedBox(height: 16),
        RoughButton(onTap: context.pop, child: const Text('Save')),
      ],
    ),
  );
}
