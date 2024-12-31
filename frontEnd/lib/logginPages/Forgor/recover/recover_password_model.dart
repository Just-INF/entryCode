

import 'dart:async';
import 'dart:math';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'recover_password_widget.dart' show RecoverPasswordWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RecoverPasswordModel extends FlutterFlowModel<RecoverPasswordWidget> {
  ///  Local state fields for this page.

  String? userEmail;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for userEmail widget.
  FocusNode? userEmailFocusNode;
  TextEditingController? userEmailTextController;
  String? Function(BuildContext, String?)? userEmailTextControllerValidator;
  String? _userEmailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for firstPassword widget.
  FocusNode? firstPasswordFocusNode;
  TextEditingController? firstPasswordTextController;
  late bool firstPasswordVisibility;
  String? Function(BuildContext, String?)? firstPasswordTextControllerValidator;
  String? _firstPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for secondPassword widget.
  FocusNode? secondPasswordFocusNode;
  TextEditingController? secondPasswordTextController;
  late bool secondPasswordVisibility;
  String? Function(BuildContext, String?)?
      secondPasswordTextControllerValidator;
  String? _secondPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    userEmailTextControllerValidator = _userEmailTextControllerValidator;
    firstPasswordVisibility = false;
    firstPasswordTextControllerValidator =
        _firstPasswordTextControllerValidator;
    secondPasswordVisibility = false;
    secondPasswordTextControllerValidator =
        _secondPasswordTextControllerValidator;
  }

  @override
  void dispose() {
    userEmailFocusNode?.dispose();
    userEmailTextController?.dispose();

    firstPasswordFocusNode?.dispose();
    firstPasswordTextController?.dispose();

    secondPasswordFocusNode?.dispose();
    secondPasswordTextController?.dispose();
  }
}
