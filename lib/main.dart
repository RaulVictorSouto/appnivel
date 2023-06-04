import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(BalanceApp());
}

class BalanceApp extends StatefulWidget {
  @override
  _BalanceAppState createState() => _BalanceAppState();
}

class _BalanceAppState extends State<BalanceApp> {
  bool isBalanced = false;
  bool isVibrating =
      false; // Variável para controlar se a vibração está ocorrendo

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        // Verifica se o dispositivo está nivelado quando o telefone está na horizontal
        if (event.z > 9.7) {
          isBalanced = true;
          if (!isVibrating) {
            vibrate();
            isVibrating = true;
          }
        } else {
          isBalanced = false;
          isVibrating = false; // Reseta o estado de vibração
        }
      });
    });
  }

  void vibrate() {
    Vibration.vibrate();
  }

  void stopVibration() {
    Vibration.cancel();
    isVibrating = false; // Reseta o estado de vibração
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isBalanced ? Icons.check_circle : Icons.warning,
                size: 100,
                color: isBalanced ? Colors.green : Colors.red,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
