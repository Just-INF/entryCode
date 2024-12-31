import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:test_project/CustomWidgets/ide_widget.dart';

import 'dart:math';
import 'package:test_project/CustomWidgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/dashboard/gamePage/components/entryPermit/entry_permit_widget.dart';
import 'package:test_project/dashboard/gamePage/components/optionsChoose/choose_options_widget.dart';
import 'package:test_project/dashboard/gamePage/components/passport/passport_widget.dart';
import 'package:test_project/flutter_flow/flutter_flow_theme.dart';

import 'game_platform_model.dart';
export 'game_platform_model.dart';

class GamePlatformWidget extends StatefulWidget {
  const GamePlatformWidget({super.key});

  @override
  State<GamePlatformWidget> createState() => _GamePlatformWidgetState();
}

class _GamePlatformWidgetState extends State<GamePlatformWidget>
    with TickerProviderStateMixin {
  late GamePlatformModel _model;

  //Code
  final GlobalKey<IDEWidgetState> _ideWidgetKey = GlobalKey<IDEWidgetState>();

  //User ID postion
  void _updatePositionID(DragUpdateDetails details) { 
    setState(() { 
      _model.idPosition[0] += details.delta.dx; 
      _model.idPosition[1] += details.delta.dy; 
    }); 
  }

  void _updatePositionEP(DragUpdateDetails details) { 
    setState(() { 
      _model.epPosition[0] += details.delta.dx; 
      _model.epPosition[1] += details.delta.dy; 
    }); 
  }


  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GamePlatformModel());

    animationsMap.addAll({
      'chooseOptionsOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),

              //IDE
              Align(
                alignment: AlignmentDirectional(1, 0),
                child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                  width: MediaQuery.sizeOf(context).width * 0.65,
                  height: MediaQuery.sizeOf(context).height,
                  child: custom_widgets.IDEWidget(
                    key: _ideWidgetKey,
                    width: MediaQuery.sizeOf(context).width * 0.65,
                    height: MediaQuery.sizeOf(context).height,
                  ),
                ),
              ),

              //user ID
              Positioned(
                left: _model.idPosition[0],
                top: _model.idPosition[1],
                child: GestureDetector(
                  onPanUpdate: _updatePositionID,
                  child:  wrapWithModel(
                    model: _model.passportModel,
                    updateCallback: () => safeSetState(() {}),
                    child: PassportWidget(
                      lastName: 'Nume De Familie',
                      firstName: 'Prenume',
                      nationality: 'Romania / ROU',
                      sex: 'M',
                      dateOfBirth: getCurrentTimestamp,
                      pin: 5555555,
                    ),
                  ),
                ),
              ),

              //Entry Permit
              Positioned(
                left: _model.epPosition[0],
                top: _model.epPosition[1],
                child: GestureDetector(
                  onPanUpdate: _updatePositionEP,
                  child:  wrapWithModel(
                    model: _model.entryPermitModel,
                    updateCallback: () => safeSetState(() {}),
                    child: EntryPermitWidget(
                      permitHolder: 'Nume De Familie + Prenume',
                      nationality: 'Romania / ROU',
                      sex: 'M',
                      motivVizita: 'My motiv',
                      visitDuration: '2 DAYS',
                      dateOfBirth: getCurrentTimestamp,
                    ),
                  ),
                ),
              ),



              //Choose optionsssssssss
              if (_model.chooseOption)
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: wrapWithModel(
                    model: _model.chooseOptionsModel,
                    updateCallback: () => safeSetState(() {}),
                    child: ChooseOptionsWidget(
                      option1: _model.chooseOptions[0],
                      option2: _model.chooseOptions[1],
                      onOptionSelected: (option) { 
                        //_model.userOption = option;
                        if(option==1) {
                          Offset linePosition = (_ideWidgetKey.currentState as IDEWidgetState).getLinePosition(1);
                          print("Top: ${linePosition.dy}, Left: ${linePosition.dx}");
                        }
                        else
                        {
                          String newCode = '''
#include <iostream>

using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
} // [END section1]''';
                          (_ideWidgetKey.currentState as IDEWidgetState).setCode(newCode);
                        }
                        //_model.chooseOption=false;
                        safeSetState(() {});
                      },
                    ),
                  ).animateOnPageLoad(
                      animationsMap['chooseOptionsOnPageLoadAnimation']!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
