import 'package:flutter/material.dart';

class SettingsIcon extends StatelessWidget {
  final double iconSize;
  final Color iconColor;
  final VoidCallback callback;
  final String tooltip;

  // Parameterized Constructor
  const SettingsIcon(this.callback,
      {Key? key,
      this.iconSize = 18,
      this.iconColor = Colors.white,
      this.tooltip = "Settings"})
      : super(key: key);

  // Named Constructor
  const SettingsIcon.dark(this.callback,
      {Key? key, this.iconSize = 18, this.tooltip = "Settings"})
      : iconColor = Colors.black,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.settings, color: iconColor),
        iconSize: iconSize,
        tooltip: tooltip,
        onPressed: callback);
  }
}
