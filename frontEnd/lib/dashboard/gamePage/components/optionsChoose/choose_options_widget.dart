import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/flutter_flow/flutter_flow_theme.dart';

import 'choose_options_model.dart';
export 'choose_options_model.dart';

class ChooseOptionsWidget extends StatefulWidget {
  const ChooseOptionsWidget({
    super.key,
    required this.option1,
    required this.option2,
    required this.onOptionSelected,
  });

  final String? option1;
  final String? option2;
  final Function(int) onOptionSelected; // Callback function to pass the selected option

  @override
  State<ChooseOptionsWidget> createState() => _ChooseOptionsWidgetState();
}

class _ChooseOptionsWidgetState extends State<ChooseOptionsWidget> {
  late ChooseOptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseOptionsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional(0, -0.1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        widget.onOptionSelected(1); // Pass the selected option back
                      },
                      text: widget.option1!,
                      options: FFButtonOptions(
                        height: 40,
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Color(0x00FFFFFF),
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Inter Tight',
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 0.0,
                        ),
                        elevation: 0,
                        borderRadius: BorderRadius.circular(8),
                        hoverTextColor: Color(0xFF4B3B76),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '/',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                color: Color(0xFF4B3B76),
                fontSize: 125,
                letterSpacing: 0.0,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0.1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      widget.onOptionSelected(2); // Pass the selected option back
                    },
                    text: widget.option2!,
                    options: FFButtonOptions(
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Color(0x004B39EF),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 0.0,
                      ),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(8),
                      hoverTextColor: Color(0xFF4B3B76),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
