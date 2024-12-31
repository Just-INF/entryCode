import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:just_audio/just_audio.dart';

import 'package:test_project/CustomWidgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/dashboard/gamePage/components/optionsChoose/choose_options_widget.dart';
import 'package:test_project/flutter_flow/flutter_flow_theme.dart';
import 'package:video_player/video_player.dart';


import 'starting_sequence_model.dart';
export 'starting_sequence_model.dart';

class StartingSequenceWidget extends StatefulWidget {
  const StartingSequenceWidget({super.key});

  @override
  State<StartingSequenceWidget> createState() => _StartingSequenceWidgetState();
}

class _StartingSequenceWidgetState extends State<StartingSequenceWidget>
    with TickerProviderStateMixin {
  late StartingSequenceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

Future<void> displaySubtitles(bool display, String text, [int? hideAfterMs]) async {
  setState(() {
    _model.displaySubtitles = display;
    _model.subtitlesText = text;
  });

  if (display && hideAfterMs != null) {
    await Future.delayed(Duration(milliseconds: hideAfterMs));
    setState(() {
      _model.displaySubtitles = false;
    });
  }
}

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartingSequenceModel());

    animationsMap.addAll({
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 2000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'buttonOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 2000.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 250.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 250.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'chooseOptionsOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
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
      'chooseOptionsOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 2000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
                child: custom_widgets.CustomVideoPlayer(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  videoUrl: _model.videoUrl,
                  shouldPlay: _model.playVideo,
                ),
              ),
              Opacity(
                opacity: 0.9,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
              if (_model.showButton)
                Align(
                  alignment: AlignmentDirectional(0, 0.8),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (animationsMap['buttonOnActionTriggerAnimation'] !=
                          null) {
                        await animationsMap['buttonOnActionTriggerAnimation']!
                            .controller
                            .forward(from: 0.0);
                      }

                      // ----------START LOGIC
                        Future<void> handleVideo() async {
                          _model.playVideo = true;
                          _model.showButton = false;
                          safeSetState(() {});

                          await Future.delayed(const Duration(milliseconds: 35000));
                          _model.videoUrl = 'assets/videos/events/startingSequence/apartamentSeq/apartamentSeq.mp4'; 
                          _model.playVideo = false; 
                          safeSetState(() {});

                          await Future.delayed(const Duration(milliseconds: 12000)); 
                          _model.playVideo = true; 
                          safeSetState(() {});

                          await Future.delayed(const Duration(milliseconds: 13000)); 
                          _model.playVideo = false; 
                          safeSetState(() {});

                          while(_model.userOption == 0)
                          {
                            await Future.delayed(Duration(milliseconds: 10));
                          } // Wait for an option to be made

                          await Future.delayed(const Duration(milliseconds: 27500)); //time between choices

                          while(_model.finishedSeq)
                          {
                            await Future.delayed(Duration(milliseconds: 10));
                          }  // Wait for confirmation

                          await Future.delayed(const Duration(milliseconds: 16000)); 
                          _model.videoUrl = 'assets/videos/events/startingSequence/apartamentSeq/apartamentSeqSingle.mp4'; 
                          _model.playVideo = true; 
                          safeSetState(() {});
                        }

                        Future<void> handleAudioAndSubtitles() async {
                            //-----SOUND 1
                            _model.soundPlayer1 ??= AudioPlayer();
                            _model.soundPlayer1!.setVolume(1); 
                            await _model.soundPlayer1!.setAsset('audios/events/startingSequence/startingSequence.mp3'); 
                            _model.soundPlayer1!.play();

                            await Future.delayed(Duration(milliseconds: 1400));
                            await displaySubtitles(true, 'It started here, under this tree. A moment so full of light it felt like nothing could touch it.', 6200);

                            await Future.delayed(Duration(milliseconds: 500));
                            await displaySubtitles(true, 'Emanuel was young, brimming with dreams of building something that mattered. Sophie was his anchor, his spark.', 7700);
                            
                            await Future.delayed(Duration(milliseconds: 400));
                            await displaySubtitles(true, 'Together, they thought they could take on the world.', 2700);
                            
                            await Future.delayed(Duration(milliseconds: 200));
                            await displaySubtitles(true, 'She saw through his walls, broke them down with a laugh and a kiss.', 3900);
                            
                            await Future.delayed(Duration(milliseconds: 600));
                            await displaySubtitles(true, 'But life has a way of shifting under your feet, doesn’t it? Of turning warmth into something colder.', 6300);

                            //------SOUND 1

                            //------SOUND 2
                            _model.soundPlayer2 ??= AudioPlayer();
                            _model.soundPlayer2!.setVolume(1);
                              await _model.soundPlayer2!.setAsset('audios/events/startingSequence/apartamentSeq/apartamentSeqAudio.mp3');
                            _model.soundPlayer2!.play();

                              await Future.delayed(Duration(milliseconds: 1790));
                              await displaySubtitles(true, 'The years blurred together, the light of those early days growing dimmer.', 6500 - 1790);
                              
                              await Future.delayed(Duration(milliseconds: 6900 - 6500));
                              await displaySubtitles(true, 'Emanuel had traded his dreams for practicality, but reality proved heavier than he expected.', 13400 - 6900);

                              await Future.delayed(Duration(milliseconds: 13900 - 13400));
                              await displaySubtitles(true, 'The bills piled up, the promises grew thinner, and the laughter... that faded first.', 20100 - 13900);

                              await Future.delayed(Duration(milliseconds: 21300 - 20100));
                              await displaySubtitles(true, 'SOPHIE: You’ve been at that desk all day, Manny. Can we talk? Please?', 26300 - 21300);

                              await Future.delayed(Duration(milliseconds: 27300 - 26300));
                              await displaySubtitles(true, 'He wanted to answer, but the weight of everything unsaid hung between them, heavier than any words could be.', 35000 - 27300);

                              await Future.delayed(Duration(milliseconds: 36000 - 35000));
                              await displaySubtitles(true, 'SOPHIE: I’m serious, Manny. This... this isn’t working. We... we are not working. And I’m tired of pretending we are.', 44350 - 36000);

                              await Future.delayed(Duration(milliseconds: 44500 - 44350));
                              await displaySubtitles(true, 'What do you say to the person who once made everything seem possible, when all you can offer now are excuses?', 53000 - 44500);

                            //-----SOUND 2

                            //---OPTION SELECT
                            _model.chooseOption = true;
                            _model.chooseOptions[0] = "Apologize and try to reassure her.";
                            _model.chooseOptions[1] = "Deflect and focus on work.";
                            safeSetState(() {});
                            while(_model.chooseOption)
                            {
                              await Future.delayed(Duration(milliseconds: 10));
                            } // Wait for option

                            _model.soundPlayer1 ??= AudioPlayer();
                            _model.soundPlayer1!.setVolume(1); 
                            if(_model.userOption == 1)
                              await _model.soundPlayer1!.setAsset('audios/events/startingSequence/apartamentSeq/option1.mp3'); 
                            else
                              await _model.soundPlayer1!.setAsset('audios/events/startingSequence/apartamentSeq/option2.mp3'); 
                            _model.soundPlayer1!.play();

                            if(_model.userOption == 1)
                            {
                              await displaySubtitles(true, 'He reached for her hand, hoping to hold onto something that was already slipping away.', 6000);
                            }
                            else
                            {
                              await displaySubtitles(true, 'The words were there, somewhere. But all he could manage was silence.', 6000);
                            }

                            _model.soundPlayer2 ??= AudioPlayer();
                            _model.soundPlayer2!.setVolume(1); 
                              await _model.soundPlayer2!.setAsset('audios/events/startingSequence/apartamentSeq/afterChoice.mp3'); 
                            _model.soundPlayer2!.play();

                            await displaySubtitles(true, 'SOPHIE: You can’t keep doing this, Manny. One day, there won’t be anything left to save.', 5500);

                            await Future.delayed(Duration(milliseconds: 1000));
                            await displaySubtitles(true, '*DOOR CLOSES*', 1500);
                            
                            await Future.delayed(Duration(milliseconds: 1000));
                            await displaySubtitles(true, 'Moments like these don’t end—they linger. The choices we make affect us far beyond what we can see.', 18500-9000);
                            
                            await Future.delayed(Duration(milliseconds: 1000));
                            _model.finishedSeq=true;
                            safeSetState(() {});

                            while(_model.finishedSeq)
                            {
                              await Future.delayed(Duration(milliseconds: 10));
                            } // Wait for button

                            _model.soundPlayer1 ??= AudioPlayer();
                            _model.soundPlayer1!.setVolume(1); 
                            await _model.soundPlayer1!.setAsset('audios/events/startingSequence/apartamentSeq/finalSeq/mainAudio.mp3'); 
                            _model.soundPlayer1!.play();
                            
                            await Future.delayed(Duration(milliseconds: 1000)); 
                            await displaySubtitles(true, 'Desperation has a way of narrowing your world, of making you see only one way forward.', 7250 - 1000); 
                            
                            await Future.delayed(Duration(milliseconds: 7500 - 7250)); 
                            await displaySubtitles(true, 'Emanuel didn’t want this. He wanted something else, something better.', 13000 - 7500); 
                            
                            await Future.delayed(Duration(milliseconds: 13250 - 13000)); 
                            await displaySubtitles(true, 'But the world had stopped caring about what he wanted.', 16500 - 13250); 
                            
                            await Future.delayed(Duration(milliseconds: 16600 - 16500)); 
                            await displaySubtitles(true, 'It wasn’t glamorous. It wasn’t even appealing. But it was stable.', 22000 - 16600); 
                            
                            await Future.delayed(Duration(milliseconds: 22250 - 22000)); 
                            await displaySubtitles(true, 'A steady paycheck, benefits, something to keep the lights on.', 26500 - 22250); 
                            
                            await Future.delayed(Duration(milliseconds: 27000 - 26500)); 
                            await displaySubtitles(true, 'SOPHIE: One day, there won’t be anything left to save.', 30000 - 27000); 
                            await Future.delayed(Duration(milliseconds: 31300 - 30000)); 
                            await displaySubtitles(true, 'It wasn’t his dream, but maybe dreams were a luxury he couldn’t afford.', 35800 - 31300); 
                            
                            await Future.delayed(Duration(milliseconds: 36300 - 35800)); 
                            await displaySubtitles(true, 'Was this a step forward, or just another compromise?', 39600 - 36300);

                            _model.chooseOption = true;
                            _model.chooseOptions[0] = "Apply for the job. It’s better than nothing.";
                            _model.chooseOptions[1] = "Put the newspaper aside and try to find another way.";
                            safeSetState(() {});
                            while(_model.chooseOption)
                            {
                              await Future.delayed(Duration(milliseconds: 10));
                            } // Wait for option

                            _model.soundPlayer2 ??= AudioPlayer();
                            _model.soundPlayer2!.setVolume(1); 
                            if(_model.userOption == 1)
                              await _model.soundPlayer2!.setAsset('audios/events/startingSequence/apartamentSeq/finalSeq/option1.mp3'); 
                            else
                              await _model.soundPlayer2!.setAsset('audios/events/startingSequence/apartamentSeq/finalSeq/option2.mp3'); 
                            _model.soundPlayer2!.play();

                            if(_model.userOption == 1)
                            {
                              await displaySubtitles(true, 'He told himself it was temporary. Just enough to get by. But even temporary things have a way of lasting longer than you expect.', 9500);
                            }
                            else
                            {
                              await displaySubtitles(true, 'Hope lingered, but it faded quickly. In the end, the choice was always the same.', 5500);
                            }


                        }
                        
                        handleVideo();
                        handleAudioAndSubtitles();

                      // ----------END LOGIC
                    },
                    text: 'Click me to continue...',
                    options: FFButtonOptions(
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Colors.black,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )
                      .animateOnPageLoad(
                          animationsMap['buttonOnPageLoadAnimation']!)
                      .animateOnActionTrigger(
                        animationsMap['buttonOnActionTriggerAnimation']!,
                      ),
                ),
              if (_model.displaySubtitles)
                Align(
                  alignment: AlignmentDirectional(0, 0.8),
                  child: custom_widgets.NarrationBox(
                    width: 1,
                    height: 1,
                    text: _model.subtitlesText,
                  )
                      .animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!)
                      .animateOnActionTrigger(
                        animationsMap['containerOnActionTriggerAnimation']!,
                      ),
                ),

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
                        _model.userOption = option;
                        _model.chooseOption=false;
                        safeSetState(() {});
                      },
                    ),
                  )
                      .animateOnPageLoad(
                          animationsMap['chooseOptionsOnPageLoadAnimation']!)
                      .animateOnActionTrigger(
                        animationsMap['chooseOptionsOnActionTriggerAnimation']!,
                      ),
                ),
                if (_model.finishedSeq)
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'The choices you make will shape future events and actions.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: Colors.white,
                                        fontSize: 18,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        'This icon    ',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              fontSize: 18,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Icon(
                                        Icons.import_contacts_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        '  will appear after you’ve made an important decision in the storyline.',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              fontSize: 18,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0.8),
                          child: FFButtonWidget(
                            onPressed: () {
                              setState(() {
                                _model.finishedSeq = false;
                              });
                            },
                            text: 'Click me to continue...',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Colors.white,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    color: Colors.black,
                                    fontSize: 18,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation2']!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
