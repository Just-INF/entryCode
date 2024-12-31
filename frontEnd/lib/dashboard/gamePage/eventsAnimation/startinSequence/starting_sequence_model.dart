import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_project/dashboard/gamePage/components/optionsChoose/choose_options_model.dart';
import 'starting_sequence_widget.dart' show StartingSequenceWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartingSequenceModel extends FlutterFlowModel<StartingSequenceWidget> {
  ///  Local state fields for this page.

  bool playVideo = false;

  String subtitlesText = ' ';

  bool displaySubtitles = false;

  String videoUrl =
      'assets/videos/events/startingSequence/startingSequence.mp4';

  bool showButton = true;

  bool chooseOption = false;
  List<String> chooseOptions = ["option1", "option2"];
  int userOption = 0;

  bool finishedSeq = false;

  ///  State fields for stateful widgets in this page.

  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;

  late ChooseOptionsModel chooseOptionsModel;

  @override
  void initState(BuildContext context) {
    chooseOptionsModel = createModel(context, () => ChooseOptionsModel());
  }

  @override
  void dispose() {
    chooseOptionsModel.dispose();
  }
}
