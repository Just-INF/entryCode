import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight/highlight.dart';
import 'package:provider/provider.dart';
import 'package:test_project/CustomWidgets/constants/constants.dart';
import 'package:test_project/CustomWidgets/ide_widget.dart' as custom_widgets;
import 'package:test_project/CustomWidgets/ide_widget.dart';
import 'package:test_project/dashboard/gamePage/components/entryPermit/entry_permit_widget.dart';
import 'package:test_project/dashboard/gamePage/components/optionsChoose/choose_options_widget.dart';
import 'package:test_project/dashboard/gamePage/components/passport/passport_widget.dart';
import 'package:test_project/flutter_flow/flutter_flow_theme.dart';

import 'first_tutorial_model.dart';
export 'first_tutorial_model.dart';

class FirstTutorialWidget extends StatefulWidget {
  const FirstTutorialWidget({super.key});

  @override
  State<FirstTutorialWidget> createState() => _FirstTutorialWidgetState();
}

class _FirstTutorialWidgetState extends State<FirstTutorialWidget>
    with TickerProviderStateMixin {
  late FirstTutorialModel _model;

  //Code
  final GlobalKey<IDEWidgetState> _ideWidgetKey = GlobalKey<IDEWidgetState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FirstTutorialModel());

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
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
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
              Align(
                alignment: AlignmentDirectional(1, 0),
                child: custom_widgets.IDEWidget(
                  key: _ideWidgetKey,
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                ),
              ),
              if (_model.chooseOption)
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: wrapWithModel(
                    model: _model.chooseOptionsModel,
                    updateCallback: () => safeSetState(() {}),
                    child: ChooseOptionsWidget(
                      option1: _model.chooseOptions.elementAtOrNull(0)!,
                      option2: _model.chooseOptions.elementAtOrNull(1)!, 
                      onOptionSelected: (option) {
                        
                      },
                    ),
                  ).animateOnPageLoad(
                      animationsMap['chooseOptionsOnPageLoadAnimation']!),
                ),
              if (_model.passport)
                wrapWithModel(
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
              if (_model.entryPermit)
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: wrapWithModel(
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



              //HighLight
              if(_model.showHighlightLine)
              Positioned(
              left: _model.highlightPoz[0]+72,
              top: _model.highlightPoz[1]+1,
                child: Container(
                  width: (_model.charCountOfLine/2) * 16+ 16*2,
                  height: 21,
                  decoration: BoxDecoration(
                    color: Color(0x00FFFFFF),
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.45,
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 567, _model.tutorialHeight+50),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/trainer.png',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0.4),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if(_model.tutorialSlide==0) (_ideWidgetKey.currentState as IDEWidgetState).setCode(tutorialCode);
                                      //Reset height
                                      _model.tutorialHeight = 100.0;
                                      _model.showHighlightLine = false;
                                      int lineToGet = -1;

                                      switch (++_model.tutorialSlide) {
                                        case 1:
                                          _model.tutorialText = "An IDE is where all the magic happens. It’s the place where you write your code. It typically includes a source code editor, an autocompleter, and a debugger.";
                                          break;
                                        case 2:
                                          _model.tutorialText = "Think of an IDE as your workspace for coding. It helps you write, test, and debug your code efficiently by providing helpful features like syntax highlighting, code completion, and error detection.";
                                          break;
                                        case 3:
                                          _model.tutorialText = "What you see in front of you is an IDE provided by us to help you get started with coding. Now that you know what you’re looking at, let's go further.";
                                          break;
                                        case 4:
                                          _model.tutorialText = "We are going to continue with what is a Programming Language. Programming languages are similar to human languages. They contain words, punctuation marks, mathematical operations, and follow specific rules. Programs that run on any computer are written in a programming language. There are numerous programming languages, such as C, C++, Pascal, Java, Python, PHP, JavaScript, etc.";
                                          _model.tutorialHeight = 150.0;
                                          break;
                                        case 5:
                                          _model.tutorialText = "Programs that run on any computer are written in a programming language. There are numerous programming languages, such as C, C++, Pascal, Java, Python, PHP, JavaScript, etc.";
                                          break;
                                        case 6:
                                          _model.tutorialText = "A program written in a programming language is called source code, and it needs to be translated into a language that the processor understands, called machine code or executable program.";
                                          break;
                                        case 7:
                                          _model.tutorialText = "For certain programming languages, the translation operation is called compilation (like in C, C++, Pascal, etc.), while for other languages (PHP, Python, JavaScript, etc.), the translation operation is called interpretation. The translation is done by a specialized program called a compiler or interpreter.";
                                          _model.tutorialHeight = 125.0;
                                          break;
                                        case 8:
                                          _model.tutorialText = "For this automation project, we will use C++. And remember that you can find all courses including this one on the dasboard -> courses tab.";
                                          break;
                                        case 9:
                                          _model.tutorialText = "Now, let's dive into the structure of a basic C++ program with our 'Hello, World!' example.";
                                          break;
                                        case 10:
                                          _model.tutorialText = "Let's start with the first line:\n\n"
                                              "This line tells the compiler to include the 'iostream' library.\n"
                                              "A library is a collection of prewritten code that provides tools for your program.\n"
                                              "'iostream' helps us with input (taking data) and output (printing data).";
                                          _model.tutorialHeight=150.0;
                                          lineToGet=2;
                                          break;
                                        case 11:
                                          _model.tutorialText = "Next line:\n\n"
                                              "`using namespace std;`:\n"
                                              "This line allows us to use standard library functions without typing `std::` before them.\n"
                                              "It makes our code simpler and easier to read.";
                                          break;
                                        case 12:
                                          _model.tutorialText = "Now, the main function:\n\n"
                                              "`int main() {` and `}`:\n"
                                              "This is where our program starts running.\n"
                                              "Every C++ program must have a main function.\n"
                                              "Think of it as the starting point of the program.";
                                          break;
                                        case 13:
                                          _model.tutorialText = "Inside the main function, we have this line:\n\n"
                                              "`cout << \"Hello, World!\" << endl;`:\n"
                                              "`cout` is used for printing text on the screen.\n"
                                              "The `<<` operator sends the text to `cout`.\n"
                                              "`endl` moves the cursor to a new line, so the next output starts on the next line.";
                                          break;
                                        case 14:
                                          _model.tutorialText = "Finally, this line:\n\n"
                                              "`return 0;`:\n"
                                              "This ends the main function and returns the value `0` to the system.\n"
                                              "It indicates that the program ran successfully.";
                                          break;
                                        case 15:
                                          _model.tutorialText = "Now you know the basics of C++ programming!\n\n"
                                              "You can start experimenting with different code and see how it works.\n"
                                              "Remember, practice makes perfect.\n"
                                              "Happy coding!";
                                          break;
                                      }

                                      //Avem highlith -> -> nr Linie -> Get Line offset -> display
                                      if( lineToGet!=-1)
                                      {
                                        Offset linePosition = (_ideWidgetKey.currentState as IDEWidgetState).getLinePosition(lineToGet);
                                        _model.highlightPoz = [linePosition.dx, linePosition.dy];
                                        _model.charCountOfLine = (_ideWidgetKey.currentState as IDEWidgetState).getCharCountOfLine(lineToGet).toDouble();
                                        print(_model.charCountOfLine.toString());
                                        _model.showHighlightLine = true;
                                      }
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      width: 800,
                                      height: _model.tutorialHeight,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF71797E),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 10, 10, 10),
                                            child: Text(
                                              _model.tutorialText,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 18,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                            ).animateOnPageLoad(animationsMap[
                                                'textOnPageLoadAnimation']!),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
