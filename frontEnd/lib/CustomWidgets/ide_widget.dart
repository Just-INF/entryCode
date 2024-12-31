import 'package:flutter_highlight/themes/vs2015.dart';
import 'index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants/constants.dart' as constant;

class IDEWidget extends StatefulWidget {
  final double width;
  final double height;

  IDEWidget({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  IDEWidgetState createState() => IDEWidgetState();
}

class IDEWidgetState extends State<IDEWidget> {
  final GlobalKey _codeFieldKey = GlobalKey();
  late CodeController _controller;

  static const startingCode = constant.startingCode;

  @override
  void initState() {
    super.initState();
    _controller = CodeController(
      text: "", // Initial code
      language: cpp,
      namedSectionParser: const BracketsStartEndNamedSectionParser(),
    );

    setupIDE();
  }

  void setupIDE() {
    _controller.autocompleter.setCustomWords(['string', 'ifstream', 'ofstream', 'std']);
    _controller.readOnlySectionNames = {'section1'};
  }

  String getCode() {
    return _controller.fullText;
  }

  void setCode(String newCode) {
    _controller.fullText = newCode;
  }

  //Get line poz
  Offset getLinePosition(int lineNumber) {
    final RenderBox renderBox = _codeFieldKey.currentContext?.findRenderObject() as RenderBox;
    if(lineNumber==1)
      return renderBox.localToGlobal(Offset(0, 16-4));
    
    if(lineNumber==2)
      return renderBox.localToGlobal(Offset(0, 16+16+4));

    return renderBox.localToGlobal(Offset(0, 16+16+4 + (16+8)*(lineNumber-2) ));
  }

  int getCharCountOfLine(int lineNumber) { 
    final List<String> lines = _controller.fullText.split('\n'); 
    
    if (lineNumber < lines.length) 
      return lines[lineNumber-1].length; 
    else
      return 0; 
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: Color(0xff1E1E1E),
        ),
        child: ListView(
          children: [
            CodeTheme(
              data: CodeThemeData(styles: vs2015Theme),
              child: CodeField(
                key: _codeFieldKey,
                controller: _controller,
                textStyle: const TextStyle(fontFamily: 'Consolas', fontSize: 16),
                gutterStyle: const GutterStyle(
                  textStyle: TextStyle(
                    height: 1.52,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
