import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/app_state.dart';
import 'package:test_project/flutter_flow/flutter_flow_theme.dart';
import 'package:test_project/http/account/auth_service.dart';

import 'nav_bar_model.dart';
export 'nav_bar_model.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  late NavBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) {
        if (_model.navBarOpenStatus) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 270,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(
                    0,
                    2,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.pan_tool_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'BorderRo',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                  fontSize: 24,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: AlignmentDirectional(1, 0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.navBarOpenStatus = false;
                                setState(() {});
                              },
                              child: Icon(
                                Icons.menu_rounded,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FFAppState().navPage == 'load page'
                            ? Color(0xFF001919)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FFAppState().navPage == 'load game'
                              ? Color(0x4D9489F5)
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
                              child: Container(
                                width: 4,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FFAppState().navPage == 'load game'
                                      ? Color(0xFF00FFFF)
                                      : Color(0xFF008080),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.play_arrow,
                              color: FFAppState().navPage == 'load game'
                                  ? Color(0xFF00FFFF)
                                  : Colors.white,
                              size: 28,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Text(
                                'Load Game',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: FFAppState().navPage == 'load game'
                                          ? Color(0xFF00FFFF)
                                          : Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FFAppState().navPage == 'challenges'
                            ? Color(0xFF001919)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FFAppState().navPage == 'challenges'
                              ? Color(0x4D9489F5)
                              : Colors.transparent,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
                              child: Container(
                                width: 4,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FFAppState().navPage == 'challenges'
                                      ? Color(0xFF00FFFF)
                                      : Color(0xFF008080),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.hearing_sharp,
                              color: FFAppState().navPage == 'challenges'
                                  ? Color(0xFF00FFFF)
                                  : Colors.white,
                              size: 28,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Text(
                                'Challenges',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color:
                                          FFAppState().navPage == 'challenges'
                                              ? Color(0xFF00FFFF)
                                              : Colors.white,
                                      fontSize: 14,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FFAppState().navPage == 'statistics'
                            ? Color(0xFF001919)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FFAppState().navPage == 'statistics'
                              ? Color(0x4D9489F5)
                              : Colors.transparent,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
                              child: Container(
                                width: 4,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FFAppState().navPage == 'statistics'
                                      ? Color(0xFF00FFFF)
                                      : Color(0xFF008080),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.query_stats,
                              color: FFAppState().navPage == 'statistics'
                                  ? Color(0xFF00FFFF)
                                  : Colors.white,
                              size: 28,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Text(
                                'Statistics',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color:
                                          FFAppState().navPage == 'statistics'
                                              ? Color(0xFF00FFFF)
                                              : Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FFAppState().navPage == 'learn'
                            ? Color(0xFF001919)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FFAppState().navPage == 'learn'
                              ? Color(0x4D9489F5)
                              : Colors.transparent,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
                              child: Container(
                                width: 4,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FFAppState().navPage == 'learn'
                                      ? Color(0xFF00FFFF)
                                      : Color(0xFF008080),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.menu_book_rounded,
                              color: FFAppState().navPage == 'learn'
                                  ? Color(0xFF00FFFF)
                                  : Colors.white,
                              size: 28,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Text(
                                'Learn',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: FFAppState().navPage == 'learn'
                                          ? Color(0xFF00FFFF)
                                          : Colors.white,
                                      fontSize: 14,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.go('/dashboard/options');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FFAppState().navPage == 'options'
                              ? Color(0xFF001919)
                              : Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: FFAppState().navPage == 'options'
                                ? Color(0x4D9489F5)
                                : Colors.transparent,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 12, 12),
                                child: Container(
                                  width: 4,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: FFAppState().navPage == 'options'
                                        ? Color(0xFF00FFFF)
                                        : Color(0xFF008080),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.settings_sharp,
                                color: FFAppState().navPage == 'options'
                                    ? Color(0xFF00FFFF)
                                    : Colors.white,
                                size: 28,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'Options',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: FFAppState().navPage == 'options'
                                            ? Color(0xFF00FFFF)
                                            : Colors.white,
                                        fontSize: 14,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Divider(
                            height: 12,
                            thickness: 2,
                            color: Color(0x4D9489F5),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0x4C39D2C0),
                                    borderRadius: BorderRadius.circular(12),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Color(0xFF39D2C0),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/default_profile.png',
                                        width: 44,
                                        height: 44,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Andrew D.',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(1, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 5),
                                                      child: Icon(
                                                        Icons
                                                            .notifications_sharp,
                                                        color:
                                                            Color(0x7FFFFFFF),
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 4, 0, 0),
                                                child: Text(
                                                  'admin@gmail.com',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color:
                                                            Color(0x9AFFFFFF),
                                                        fontSize: 14,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(1, 1),
child: Container(
                                                  decoration: BoxDecoration(),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1, 1),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 6, 0, 0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          logout();
                                                          context.go("/");
                                                        },
                                                        child: Icon(
                                                          Icons.logout_outlined,
                                                          color:
                                                              Color(0x7FFFFFFF),
                                                          size: 24,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 35,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(
                    0,
                    2,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 28),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.navBarOpenStatus = true;
                                setState(() {});
                              },
                              child: Icon(
                                Icons.menu_rounded,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color(0x4D000000),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: FFAppState().navPage == 'load game'
                                  ? Color(0xFF00FFFF)
                                  : Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: FFAppState().navPage == 'challenges'
                            ? Color(0xFF001919)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FFAppState().navPage == 'challenges'
                              ? Color(0x4D9489F5)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.hearing_sharp,
                            color: FFAppState().navPage == 'challenges'
                                ? Color(0xFF00FFFF)
                                : Colors.white,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: FFAppState().navPage == 'statistics'
                            ? Color(0xFF001919)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FFAppState().navPage == 'statistics'
                              ? Color(0x4D9489F5)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.query_stats,
                            color: FFAppState().navPage == 'statistics'
                                ? Color(0xFF00FFFF)
                                : Colors.white,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: FFAppState().navPage == 'learn'
                            ? Color(0xFF001919)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FFAppState().navPage == 'learn'
                              ? Color(0x4D9489F5)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu_book_rounded,
                            color: FFAppState().navPage == 'learn'
                                ? Color(0xFF00FFFF)
                                : Colors.white,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: FFAppState().navPage == 'options'
                            ? Color(0xFF001919)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FFAppState().navPage == 'options'
                              ? Color(0x4D9489F5)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.go('/dashboard/options');
                            },
                            child: Icon(
                              Icons.settings_sharp,
                              color: FFAppState().navPage == 'options'
                                  ? Color(0xFF00FFFF)
                                  : Colors.white,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Divider(
                            height: 12,
                            thickness: 2,
                            color: Color(0x4D9489F5),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1, 0),
                                            child: Container(
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(1, 0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 5),
                                                  child: Icon(
                                                    Icons.notifications_sharp,
                                                    color: Color(0x7FFFFFFF),
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1, 1),
                                            child: Container(
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(1, 1),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 6, 0, 0),
                                                  child: Icon(
                                                    Icons.logout_outlined,
                                                    color: Color(0x7FFFFFFF),
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
