import 'package:flutter/material.dart';

class CustomMaterialPageOverlay extends StatefulWidget {
  final WidgetBuilder builder;

  const CustomMaterialPageOverlay({Key? key, required this.builder}) : super(key: key);

  @override
  _CustomMaterialPageOverlayState createState() => _CustomMaterialPageOverlayState();
}

class _CustomMaterialPageOverlayState extends State<CustomMaterialPageOverlay> {
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: 16.0,
        bottom: 16.0,
        child: widget.builder(context),
      ),
    );

    // Insert the overlay entry into the overlay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Overlay.of(context).insert(_overlayEntry);
    });
  }

  @override
  void dispose() {
    _overlayEntry.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Empty container; the overlay will be positioned separately
  }
}
