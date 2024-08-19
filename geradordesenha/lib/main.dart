import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

void main() {
  runApp(PasswordGeneratorApp());
}

class PasswordGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PasswordGeneratorScreen(),
    );
  }
}

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  String _password = '';
  final TextEditingController _passController = TextEditingController();
  
  String _generatePassword(int length) {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#\$%&*!?';
    
    Random random = Random();
    length = length > 150 ? 150 : length;
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  void _generateAndSetPassword() {
    int length = int.tryParse(_passController.text) ?? 12;
    length = length > 150 ? 150 : length;
    length = length > 0 ? length : 12;

    setState(() {
      _password = _generatePassword(length);
    });
  }

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                width: 150,
                height: 30,
                child: Center(
                  child: TextField(
                    controller: _passController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Digite o tamanho',
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2), // Limita a 2 caracteres
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: _generateAndSetPassword,
              child: Text('Gerar senha'),
            ),
            SizedBox(height: 20),
            Text(
              'Sua senha é:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SelectableText(
              _password,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
