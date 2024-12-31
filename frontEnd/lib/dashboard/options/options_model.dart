import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:test_project/dashboard/components/navBar/nav_bar_model.dart';


import 'dart:math';
import 'options_widget.dart' show OptionsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OptionsModel extends FlutterFlowModel<OptionsWidget> {
  ///  Local state fields for this page.

  String userName = 'userName';

  String userEmail = 'userEmail';

  ///  State fields for stateful widgets in this page.

  // Model for navBar component.
  late NavBarModel navBarModel;
  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode;
  TextEditingController? yourNameTextController;
  String? Function(BuildContext, String?)? yourNameTextControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    navBarModel.dispose();
    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();
  }
}

