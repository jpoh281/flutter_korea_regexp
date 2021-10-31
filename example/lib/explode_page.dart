import 'package:flutter/material.dart';
import 'package:korea_regexp/explode.dart';

class ExplodePage extends StatefulWidget {
  const ExplodePage({Key? key}) : super(key: key);

  @override
  _ExplodePageState createState() => _ExplodePageState();
}

class _ExplodePageState extends State<ExplodePage> {
  late TextEditingController controller;
  late dynamic text = '';
  bool grouped = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '불닭');
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
        title: Text("자소분리"),
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
                  )),
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          text = explode(controller.text, grouped: grouped);
                        });
                      },
                      child: Text("변환")),
                ],
              ),
              Row(
                children: [
                  Text("그룹화 여부"),
                  Checkbox(
                      value: grouped,
                      onChanged: (bool? value) {
                        setState(() {
                          grouped = value!;
                        });
                      }),
                ],
              ),
              Text("false 예시) 불닭 : '['ㅂ', 'ㅜ', 'ㄹ', 'ㄷ', 'ㅏ', 'ㄹ', 'ㄱ']"),
              Text("true 예시) 불닭 : [['ㅂ', 'ㅜ', 'ㄹ'], ['ㄷ', 'ㅏ', 'ㄹ', 'ㄱ']]"),
              Text(
                text.toString(),
                style: TextStyle(color: Colors.redAccent, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
