import 'package:flutter/material.dart';
import 'package:useful_toolbox/exceptions.dart';

class PrimeNumberPage extends StatelessWidget {
  final String _title;

  const PrimeNumberPage(this._title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Text(
              '輸入數字 1 ~ 1000000000',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            _NumberInputBody(),
          ],
        ),
      ),
    );
  }
}

class _NumberInputBody extends StatefulWidget {
  const _NumberInputBody({super.key});

  @override
  State<_NumberInputBody> createState() => _NumberInputBodyState();
}

class _NumberInputBodyState extends State<_NumberInputBody> {
  final myController = TextEditingController();

  String? _errorText;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Input Field
          TextField(
            controller: myController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text('輸入範圍內正整數'),
              errorText: _errorText,
            ),
            onChanged: ((value) {
              setState(() {
                _errorText = null;
              });
            }),
          ),
          // space
          const SizedBox(height: 20),
          // Submit button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              String? dialogMsg;
              try {
                if (_isPrimeNumber(myController.text)) {
                  dialogMsg = '是質數';
                } else {
                  dialogMsg = '不是質數';
                }
              } on InputFormatException catch (e) {
                setState(() {
                  _errorText = e.cause;
                });
                return;
              }
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  title: Text(myController.text),
                  content: Text(dialogMsg!),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('送出'),
          ),
        ],
      ),
    );
  }
}

// Prime Number Check
bool _isPrimeNumber(String numStr) {
  int num;
  try {
    num = int.parse(numStr);
  } on FormatException {
    throw InputFormatException('須為正整數且介於範圍內');
  }
  
  if (!(1 <= num && num <= 1000000000)) {
    throw InputFormatException('須為正整數且介於範圍內');
  }

  if (num == 1) return false;
  if (num == 2) return true;

  for (int i = 2; i*i <= num; i++) {
    if (num%i == 0) {
      return false;
    }
  }
  return true;
}
