import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:useful_toolbox/logic.dart';

class BaseConverterPage extends StatelessWidget {
  final String _title;

  const BaseConverterPage(this._title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: _InputBody(),
      ),
    );
  }
}

class _InputBody extends StatefulWidget {
  const _InputBody({super.key});

  @override
  State<_InputBody> createState() => _InputBodyState();
}

class _InputBodyState extends State<_InputBody> {
  final inputBaseController = TextEditingController();
  final targetBaseController = TextEditingController();
  final inputController = TextEditingController();
  final resultController = TextEditingController();

  @override
  void dispose() {
    inputBaseController.dispose();
    targetBaseController.dispose();
    inputController.dispose();
    resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: TextField(
                controller: inputBaseController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(2),
                ],
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text('輸入進制'),
                  filled: true,
                ),
              ),
            ),
            Flexible(
              child: IconButton(
                iconSize: 40,
                splashRadius: 20,
                color: Colors.grey[600],
                padding: const EdgeInsets.all(16.0),
                onPressed: () {
                  // swap base
                  String tmp = inputBaseController.text;
                  inputBaseController.text = targetBaseController.text;
                  targetBaseController.text = tmp;
                  // swap input and result
                  inputController.text = resultController.text;
                  resultController.text = '';
                },
                icon: const Icon(Icons.swap_horiz),
              ),
            ),
            Flexible(
              child: TextField(
                controller: targetBaseController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(2),
                ],
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text('目標進制'),
                  filled: true,
                ),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.black,
        ),
        // Space
        const SizedBox(height: 20),
        // Input
        TextField(
          controller: inputController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text('欲轉換數字'),
          ),
        ),
        const Icon(
          Icons.arrow_downward,
          size: 50,
        ),
        TextField(
          controller: resultController,
          readOnly: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text('結果'),
          ),
        ),
        // Space
        const SizedBox(height: 20),
        const Divider(
          color: Colors.black,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: () {
            String initBase = inputBaseController.text;
            String targetBase = targetBaseController.text;
            String src = inputController.text;
            try {
              resultController.text = baseConvert(src, initBase, targetBase);
            } on InputFormatException catch (e) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('輸入格式錯誤'),
                  content: Text(e.cause),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    )
                  ],
                ),
                barrierDismissible: false,
              );
            }
          },
          child: const Text('送出'),
        ),
      ],
    );
  }
}
