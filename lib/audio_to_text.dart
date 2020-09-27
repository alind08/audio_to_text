import 'package:curus_test/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AudioToText extends StatefulWidget {
  @override
  _AudioToTextState createState() => _AudioToTextState();
}

class _AudioToTextState extends State<AudioToText> {
  SpeechToText _speech;
  bool listening = false;
  String _text = "Click om the mic to record audio";

  @override
  void initState() {
    super.initState();
    _speech = SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Audio => Text"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _listen,
          child: listening ? Icon(Icons.mic,color: Colors.greenAccent,):Icon(Icons.mic,color: Colors.red,),
        ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Text(_text,
            style: head1
          ),
        ),
      ),
    );
  }
  void _listen() async {
    if (!listening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => listening = true);
        _speech.listen(
          onResult: (value) => setState(() {
            _text = value.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => listening = false);
      _speech.stop();
    }
  }
}
