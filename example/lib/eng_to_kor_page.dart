import 'package:flutter/material.dart';
import 'package:korea_regexp/korea_regexp.dart';

class EngToKorPage extends StatefulWidget {
  const EngToKorPage({Key? key}) : super(key: key);

  @override
  _EngToKorPageState createState() => _EngToKorPageState();
}

class _EngToKorPageState extends State<EngToKorPage> {
  late TextEditingController controller;
  var text = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: 'Rkrenrldhk xhdekfr!');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영어 -> 한글 테스트'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        text = engToKor(controller.text);
                      });
                    },
                    child: Text('변환'),
                  ),
                ],
              ),
              Text(
                text,
                style: TextStyle(color: Colors.redAccent, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
