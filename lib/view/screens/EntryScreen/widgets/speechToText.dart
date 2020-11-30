import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  final Function setText;
  final String selectedText;
  SpeechScreen({this.setText, this.selectedText});
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    // if (widget.currentText != null) {
    //   _text = widget.currentText;
    // }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      widget.setText(_text);
    }
  }

  @override
  Widget build(BuildContext context) {
    // String tempText = widget.selectedText != null ? widget.selectedText : _text;
    // setState(() {
    //   _text = tempText;
    // });
    return Container(
        // appBar: AppBar(
        //   title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
        //   actions: [],
        // ),
        child: Column(
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            // floatingActionButton:
            children: [
          SingleChildScrollView(
            reverse: true,
            child: Column(
                // height: 200,
                // padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
                children: [
                  Container(
                      // margin: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)),
                      child: Text(
                        _text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ))
                ]),
          ),
          FloatingActionButton(
              onPressed: _listen,
              child: Icon(_isListening ? Icons.mic : Icons.mic_none)),
        ]));
  }
}
