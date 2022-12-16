import 'package:flutter/material.dart';
import 'package:useful_toolbox/logic.dart';

class IdVerifyPage extends StatelessWidget {
  final String title;

  const IdVerifyPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: const [
          _IdInputBody(),
          Divider(
            indent: 10.0,
            endIndent: 10.0,
            color: Colors.grey,
          ),
          Text(
            '註: 從 CK Judge 搬過來的，可能有些不太準確',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class _IdInputBody extends StatefulWidget {
  const _IdInputBody({super.key});

  @override
  State<_IdInputBody> createState() => _IdInputBodyState();
}

class _IdInputBodyState extends State<_IdInputBody> {
  final myController = TextEditingController();

  static const _space = 20.0;

  String _resultText = '輸入學號';
  Color _resultColor = Colors.black;

  String? _errorText;

  void _updateResult(int state) {
    setState(() {
      if (state == 1) {
        _resultText = '驗證通過';
        _resultColor = Colors.green;
      } else if (state == 0) {
        _resultText = '驗證失敗';
        _resultColor = Colors.red;
      } else if (state == -1) {
        _resultText = '輸入學號';
        _resultColor = Colors.black;
        myController.clear();
        _errorText = null;
      }
    });
  }

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
          // result text
          Text(
            _resultText,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: _resultColor,
            ),
          ),
          // Space
          const SizedBox(height: _space),
          // Input Field
          TextField(
            controller: myController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text('學號'),
              errorText: _errorText,
            ),
            onChanged: ((value) {
              setState(() {
                _errorText = null;
              });
            }),
          ),
          // Space
          const SizedBox(height: _space),
          // Submit Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              try {
                _updateResult(idVerify(myController.text) ? 1 : 0);
              } on InputFormatException catch (e) {
                setState(() {
                  _errorText = e.cause;
                });
              }
            },
            child: const Text('送出'),
          ),
          // Space
          const SizedBox(height: _space),
          // Clear Button
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              side: const BorderSide(color: Colors.grey),
            ),
            onPressed: () {
              _updateResult(-1);
            },
            child: const Text('清除'),
          ),
        ],
      ),
    );
  }
}
