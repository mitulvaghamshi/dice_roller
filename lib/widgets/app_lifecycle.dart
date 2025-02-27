import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

@immutable
class AppLifecycleObserver extends StatefulWidget {
  const AppLifecycleObserver({required this.child, super.key});

  final Widget child;

  @override
  State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
  final lifecycleListenable = ValueNotifier<AppLifecycleState>(
    AppLifecycleState.inactive,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    lifecycleListenable.value = state;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using InheritedProvider because we don't want to use Consumer
    // or context.watch or anything like that to listen to this. We want
    // to manually add listeners. We're interested in the _events_ of lifecycle
    // state changes, and not so much in the state itself. (For example,
    // we want to stop sound when the app goes into the background, and
    // restart sound again when the app goes back into focus. We're not
    // rebuilding any widgets.)
    //
    // Provider, by default, throws when one
    // is trying to provide a Listenable (such as ValueNotifier) without using
    // something like ValueListenableProvider. InheritedProvider is more
    // low-level and doesn't have this problem.
    return InheritedProvider<ValueNotifier<AppLifecycleState>>.value(
      value: lifecycleListenable,
      child: widget.child,
    );
  }
}
