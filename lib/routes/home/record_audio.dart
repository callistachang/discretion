import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';

class RecordAudio {
  FlutterSound flutterSound = new FlutterSound();
  var _recorderSubscription;

  void startRecording() async {
    String path = await flutterSound.startRecorder();
    print('startRecorder: $path');

    _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
      String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
    });
  }

  void stopRecording() async {
    String result = await flutterSound.stopRecorder();
    print('stopRecorder: $result');

    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }
  }
}