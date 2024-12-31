// Automatic FlutterFlow imports
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:visibility_detector/visibility_detector.dart';

class VisibilityDetectorWidget extends StatefulWidget {
  const VisibilityDetectorWidget({
    Key? key,
    this.width,
    this.height,
    required this.onVisible,
    required this.identifier,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<dynamic> Function() onVisible;
  final String identifier; // Unique identifier

  @override
  _VisibilityDetectorWidgetState createState() =>
      _VisibilityDetectorWidgetState();
}

class _VisibilityDetectorWidgetState extends State<VisibilityDetectorWidget> {
  bool hasBeenVisible = false;

  @override
  void initState() {
    super.initState();
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0 && !hasBeenVisible) {
      widget.onVisible();
      hasBeenVisible = true;
    } else if (info.visibleFraction == 0 && hasBeenVisible) {
      hasBeenVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('visibility-detector-${widget.identifier}'), // Unique key
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 50.0,
        color: Colors.transparent,
      ),
    );
  }
}