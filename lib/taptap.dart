import 'dart:async';

import 'package:flutter/material.dart';
import 'package:discretion/routes/home/HomePage.dart';
import 'package:discretion/routes/message/MessagePage.dart';
import 'package:discretion/routes/ringtone/RingtonePage.dart';
import 'package:discretion/routes/settings/SettingsPage.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:vibration/vibration.dart';


class TapTapService {
  static int seqLength = 60;
  static int samplingPeriod = 10000;
  List<List<List<double>>> input = [List.generate(seqLength, (i) => List.filled(6, 0, growable: false), growable:false)];
  List<int> lastTime = [0,0];
  int skipNum = seqLength;
  int firstTapTime = 0;
  bool secondFlag = false;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  Interpreter? firstInterpreter;
  Interpreter? secondInterpreter;
  List<List<double>> output = [[0,0,0]];


  Future<void> init() async{
    _streamSubscriptions.add(gyroscopeEvents.audit(Duration(microseconds: samplingPeriod)).listen((event) {
      addSensorData(0, event.x, event.y, event.z, DateTime.now().microsecondsSinceEpoch);
    }));
    _streamSubscriptions.add(userAccelerometerEvents.audit(Duration(microseconds: samplingPeriod)).listen((event) {
      addSensorData(1, event.x, event.y, event.z, DateTime.now().microsecondsSinceEpoch);
    }));
    var options = InterpreterOptions();
    options.threads = 4;
    firstInterpreter = await Interpreter.fromAsset('first.tflite', options: options);
    secondInterpreter = await Interpreter.fromAsset("second.tflite", options: options);
  }



  void addSensorData(int idx, double x, double y, double z, int timestamp) {
    if (timestamp < lastTime[idx] + 3 * 1e6)
      return;
    lastTime[idx] = timestamp;
    for (int i = 0; i < seqLength - 1; i++)
      List.copyRange(input[0][i], 3 * idx, input[0][i + 1], 3 * idx, 3 * idx + 3);
    input[0][seqLength - 1][3 * idx] = x;
    input[0][seqLength - 1][3 * idx + 1] = y;
    input[0][seqLength - 1][3 * idx + 2] = z;
    if (idx == 1) {
      if (skipNum > 0)
        skipNum--;
      // 进行识别
      else {
        recognizeFirst();
        recognizeSecond();
      }
    }
  }

  void recognizeFirst() {
    int offset = 5;
    double value = input[0][seqLength - offset][5];
    if (value < 0.5)
      return;
    for (int i = 1; i <= 10; i++)
      if (value < input[0][seqLength - offset - i][5])
        return;
    for (int i = 1; i < offset; i++)
      if (value < input[0][seqLength - offset + i][5])
        return;
    List<List<List<double>>> firstInput = [List.generate(10, (i) => List.filled(6, 0, growable: false), growable:false)];
    List<List<double>> firstOutput = [[0,0]];
    for (int i = -5; i < 5; i++)
      List.copyRange(firstInput[0][5 + i], 0, input[0][seqLength - offset + i], 0, 6);
    firstInterpreter?.run(firstInput, firstOutput);
    if (firstOutput[0][1] < 0.99)
      return;
    if (!secondFlag) {
      secondFlag = true;
      skipNum = 8;
    }
    firstTapTime = lastTime[1];
  }

  void recognizeSecond() {
    if (!secondFlag || skipNum > 0)
      return;
    if (lastTime[1] - firstTapTime > 600 * 1e6) {
      secondFlag = false;
      return;
    }
    secondInterpreter?.run(input, output);
    if (output[0][1] > output[0][0] && output[0][1] > output[0][2]) {
      //TODO: taptap behaviour Toast.makeText(this, "TapTap", Toast.LENGTH_SHORT).show();
    }
    else
      return;
    secondFlag = false;
    skipNum = 30;
    for (int i = 0; i < seqLength; i++)
      for (int j = 0; j < 6; j++)
        input[0][i][j] = 0;
    Vibration.vibrate(duration:300);
  }

  @override
  void dispose() {
    //super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    firstInterpreter?.close();
    secondInterpreter?.close();

  }
}
