import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:test_project/dashboard/gamePage/components/entryPermit/entry_permit_model.dart';
import 'package:test_project/dashboard/gamePage/components/optionsChoose/choose_options_model.dart';
import 'package:test_project/dashboard/gamePage/components/passport/passport_model.dart';

import 'dart:math';
import 'dart:ui';
import 'first_tutorial_widget.dart' show FirstTutorialWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FirstTutorialModel extends FlutterFlowModel<FirstTutorialWidget> {
  ///  Local state fields for this page.

  bool chooseOption = false;

  List<String> chooseOptions = ['option1', 'option2'];
  void addToChooseOptions(String item) => chooseOptions.add(item);
  void removeFromChooseOptions(String item) => chooseOptions.remove(item);
  void removeAtIndexFromChooseOptions(int index) =>
      chooseOptions.removeAt(index);
  void insertAtIndexInChooseOptions(int index, String item) =>
      chooseOptions.insert(index, item);
  void updateChooseOptionsAtIndex(int index, Function(String) updateFn) =>
      chooseOptions[index] = updateFn(chooseOptions[index]);

  bool passport = false;

  bool entryPermit = false;

  int tutorialSlide = 0;
  bool showHighlightLine = false;
  List<double> highlightPoz = [-200,-200];

  String tutorialText = 'Hello Emanuel! I am Kaira from MAI and I will be responsible for your training regarding the new border automation project. We will start by explaining what a IDE is.Click this to continue...';
  double tutorialHeight = 100.0;
  ///  State fields for stateful widgets in this page.

  // Model for chooseOptions component.
  late ChooseOptionsModel chooseOptionsModel;
  // Model for passport component.
  late PassportModel passportModel;
  // Model for entryPermit component.
  late EntryPermitModel entryPermitModel;

  @override
  void initState(BuildContext context) {
    chooseOptionsModel = createModel(context, () => ChooseOptionsModel());
    passportModel = createModel(context, () => PassportModel());
    entryPermitModel = createModel(context, () => EntryPermitModel());
  }

  @override
  void dispose() {
    chooseOptionsModel.dispose();
    passportModel.dispose();
    entryPermitModel.dispose();
  }
}
