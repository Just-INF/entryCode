import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'nav_bar_widget.dart' show NavBarWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NavBarModel extends FlutterFlowModel<NavBarWidget> {
  ///  Local state fields for this component.

  bool navBarOpenStatus = true;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
