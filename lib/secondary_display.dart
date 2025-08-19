import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation_displays/displays_manager.dart';

/// Only use a subscription to listen within the secondary display
/// [arguments] returned  type [dynamic]
typedef ArgumentsCallback = Function(dynamic arguments);

/// This widget will wrap the secondary display, it will receive data transmitted from [DisplayManager].
/// [SecondaryDisplay.callback] instance of [ArgumentsCallback] to receive data transmitted from the [DisplayManager].
/// [SecondaryDisplay.child] child widget of secondary display
class SecondaryDisplay extends StatefulWidget {
  const SecondaryDisplay({
    super.key,
    required this.callback,
    required this.child,
  });

  /// instance of [ArgumentsCallback] to receive data transmitted from the [DisplaysManager].
  final ArgumentsCallback callback;

  /// Your Flutter UI on Presentation Screen
  final Widget child;

  @override
  SecondaryDisplayState createState() => SecondaryDisplayState();
}

class SecondaryDisplayState extends State<SecondaryDisplay> {
  final _presentationChannel = "presentation_displays_plugin_engine";
  late MethodChannel? _presentationMethodChannel;

  @override
  void initState() {
    _addListenerForPresentation(widget.callback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _addListenerForPresentation(ArgumentsCallback function) {
    _presentationMethodChannel = MethodChannel(_presentationChannel);
    _presentationMethodChannel?.setMethodCallHandler((call) async {
      function(call.arguments);
    });
  }
}
