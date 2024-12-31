import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:test_project/dashboard/components/navBar/nav_bar_model.dart';


import 'loadgame_widget.dart' show LoadgameWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoadgameModel extends FlutterFlowModel<LoadgameWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for navBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    navBarModel.dispose();
  }
}
