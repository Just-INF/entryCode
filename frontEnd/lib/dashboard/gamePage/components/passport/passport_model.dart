
import 'dart:math';
import 'dart:ui';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'passport_widget.dart' show PassportWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PassportModel extends FlutterFlowModel<PassportWidget> {
  ///  Local state fields for this component.

  bool folded = true;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
