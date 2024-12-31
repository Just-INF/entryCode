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
              left: _model.highlightPoz[0]+72-16,
              top: _model.highlightPoz[1]+1,
                child: Container(
                  width: (_model.charCountOfLine/2) * 16+ 16*2,
                  height: 21,
                  decoration: BoxDecoration(
                    color: Color(0x00FFFFFF),
                    border: Border.all(
                      color: Colors.redAccent,
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
                                      //Setting code
                                      if(_model.tutorialSlide==0) (_ideWidgetKey.currentState as IDEWidgetState).setCode(startingCode);
                                      if(_model.tutorialSlide==18) (_ideWidgetKey.currentState as IDEWidgetState).setCode(variablesAndDataTypes);
                                      if(_model.tutorialSlide==23) (_ideWidgetKey.currentState as IDEWidgetState).setCode(basicArithmeticOperations);
                                      if(_model.tutorialSlide==29) (_ideWidgetKey.currentState as IDEWidgetState).setCode(conditionalStatements);
                                      if(_model.tutorialSlide==33) (_ideWidgetKey.currentState as IDEWidgetState).setCode(loops);
                                      if(_model.tutorialSlide==37) (_ideWidgetKey.currentState as IDEWidgetState).setCode(functions);
                                      if(_model.tutorialSlide==40) (_ideWidgetKey.currentState as IDEWidgetState).setCode(classes);
                                      //Reset height
                                      _model.tutorialHeight = 100.0;
                                      _model.showHighlightLine = false;
                                      int lineToGet = -1;

                                      switch (++_model.tutorialSlide) {
                                        case 1:
                                          _model.tutorialText = "An IDE is where you write your code. It usually includes a text editor, auto-complete feature, and a debugger.";
                                          break;
                                        case 2:
                                          _model.tutorialText = "Think of an IDE as your coding workspace. It helps you write, test, and fix your code efficiently with features like syntax highlighting and error detection.";
                                          break;
                                        case 3:
                                          _model.tutorialText = "What you see in front of you is an IDE that we provide to help you start coding. Now that you know what it is, let's continue.";
                                          break;
                                        case 4:
                                          _model.tutorialText = "Next, let's talk about Programming Languages. They are similar to human languages and contain words, punctuation, math symbols, and rules. Many programs are written in languages like C, C++, Java, Python, and more.";
                                          break;
                                        case 5:
                                          _model.tutorialText = "Programs running on computers are written in programming languages. There are many languages such as C, C++, Pascal, Java, Python, PHP, and JavaScript.";
                                          break;
                                        case 6:
                                          _model.tutorialText = "A program written in a programming language is called source code. It needs to be translated into machine code or executable code that the computer understands.";
                                          break;
                                        case 7:
                                          _model.tutorialText = "Some programming languages need to be compiled (like C, C++, Pascal). Others (like PHP, Python, JavaScript) are interpreted. A compiler or interpreter does this translation.";
                                          break;
                                        case 8:
                                          _model.tutorialText = "For this project, we will use C++ as it is one of the most used languages in the world.\n"
                                                                "Remember, you can find all courses including this one in the dashboard under the courses tab.";
                                          break;
                                        case 9:
                                          _model.tutorialText = "Now, let's explore the structure of a basic C++ program with our 'Hello, World!' example.";
                                          break;
                                        case 10:
                                          _model.tutorialText = "First, let's look at the line that includes the 'iostream' library.\n\n"
                                                                "A library is prewritten code that helps with specific tasks like input and output.";
                                          lineToGet = 2;
                                          break;
                                        case 11:
                                          _model.tutorialText = "Next, we have a line that allows us to use standard library functions without typing `std::` each time. It simplifies our code.";
                                          lineToGet = 4;
                                          break;
                                        case 12:
                                          _model.tutorialText = "Now, let's look at the main function. It starts with a '{' and ends with a '}'.\n"
                                                                "This is where our program starts running. Every C++ program must have a main function.";
                                          lineToGet = 6;
                                          break;
                                        case 13:
                                          _model.tutorialText = "Inside the main function, we have a line using `cout` to print text on the screen.\n"
                                                                "The `<<` operator sends the text to `cout`, and `endl` moves the cursor to a new line.";
                                          lineToGet = 7;
                                          break;
                                        case 14:
                                          _model.tutorialText = "Finally, the return line.\n"
                                                                "This ends the main function and returns `0` to indicate that the program ran successfully.";
                                          lineToGet = 8;
                                          break;
                                        case 15:
                                          _model.tutorialText = "And lastly, comments.\n"
                                                                "Comments are text in your code that are not executed by the program. They are used to explain your code and make it more readable for humans.\n"
                                                                "Single-line comments start with //. Everything after // on that line is ignored by the compiler.";
                                          _model.tutorialHeight = 150.0;
                                          lineToGet = 10;
                                          break;
                                        case 16:
                                          _model.tutorialText = "For comments that span multiple lines, use /* to start the comment and */ to end it.\n"
                                                                "These comments are also ignored by the compiler.";
                                          lineToGet = 11;
                                          break;
                                        case 17:
                                          _model.tutorialText = "Now you know the basics of C++ programming!\n"
                                                                "Next, we'll explore variable types and what they can store. Remember, you can always check all courses and click through this if you already know the material.\n"
                                                                "Happy coding!";
                                          _model.tutorialHeight = 125.0;
                                          break;

                                        // Variables and Data Types
                                        case 18:
                                          _model.tutorialText = "In programming, variables are used to store data that can change. Let's start with some common data types in C++.";
                                          break;
                                        case 19:
                                          _model.tutorialText = "An `int` stores whole numbers.";
                                          lineToGet = 8;
                                          break;
                                        case 20:
                                          _model.tutorialText = "`double` is used for decimal numbers.";
                                          lineToGet = 12;
                                          break;
                                        case 21:
                                          _model.tutorialText = "`char` is used for single characters.";
                                          lineToGet = 16;
                                          break;
                                        case 22:
                                          _model.tutorialText = "`string` is used for text.";
                                          lineToGet = 20;
                                          break;

                                        // Basic Arithmetic Operations
                                        case 23:
                                          _model.tutorialText = "You can perform basic arithmetic operations with variables. Let's look at some examples.";
                                          break;
                                        case 24:
                                          _model.tutorialText = "Addition example.";
                                          lineToGet=9;
                                          break;
                                        case 25:
                                          _model.tutorialText = "Subtraction example.";
                                          lineToGet=13;
                                          break;
                                        case 26:
                                          _model.tutorialText = "Multiplication example.";
                                          lineToGet=17;
                                          break;
                                        case 27:
                                          _model.tutorialText = "Division example.";
                                          lineToGet=21;
                                          break;
                                        case 28:
                                          _model.tutorialText = "Remember, division by zero is not allowed and will cause an error.";
                                          break;

                                        // Conditional Statements
                                        case 29:
                                          _model.tutorialText = "Conditional statements let you run different code based on certain conditions. Let's start with `if` statements.";
                                          break;
                                        case 30:
                                          _model.tutorialText = "`if` statement example.";
                                          lineToGet=9;
                                          break;
                                        case 31:
                                          _model.tutorialText = "`else` statement example.";
                                          lineToGet=16;
                                          break;
                                        case 32:
                                          _model.tutorialText = "`else if` statement example.";
                                          lineToGet=23;
                                          break;

                                        // Loops
                                        case 33:
                                          _model.tutorialText = "Loops let you run the same block of code multiple times. Let's look at `for` and `while` loops.";
                                          break;
                                        case 34:
                                          _model.tutorialText = "`for` loop example.";
                                          lineToGet=7;
                                          break;
                                        case 35:
                                          _model.tutorialText = "`while` loop example.";
                                          lineToGet=13;
                                          break;
                                        case 36:
                                          _model.tutorialText = "Be careful with loops to avoid infinite loops, which will run forever if the condition never becomes false.";
                                          break;

                                        // Functions
                                        case 37:
                                          _model.tutorialText = "Functions are blocks of code that perform a specific task. They help you organize your code and make it reusable.";
                                          break;
                                        case 38:
                                          _model.tutorialText = "Defining a function.";
                                          lineToGet=5;
                                          break;
                                        case 39:
                                          _model.tutorialText = "Calling a function.";
                                          lineToGet=10;
                                          break;

                                        // Classes
                                        case 40:
                                          _model.tutorialText = "Classes are blueprints for creating objects in C++. They encapsulate data and functions that operate on that data.";
                                          break;
                                        case 41:
                                          _model.tutorialText = "Defining a class.";
                                          lineToGet=6;
                                          break;
                                        case 42:
                                          _model.tutorialText = "Creating an object.";
                                          lineToGet=16;
                                          break;

                                        // Conclusion
                                        case 43:
                                          _model.tutorialText = "Now you know the basics of C++ programming, including variables, loops, functions, and classes!\n"
                                                                "Remember, you can always check all courses.\n"
                                                                "Welcome to the job!";
                                          _model.tutorialHeight = 125;
                                          break;
                                      }




                                      //Avem highlith -> -> nr Linie -> Get Line offset -> display
                                      if( lineToGet!=-1)
                                      {
                                        Offset linePosition = (_ideWidgetKey.currentState as IDEWidgetState).getLinePosition(lineToGet);
                                        _model.highlightPoz = [linePosition.dx, linePosition.dy];
                                        _model.charCountOfLine = (_ideWidgetKey.currentState as IDEWidgetState).getCharCountOfLine(lineToGet).toDouble();
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
