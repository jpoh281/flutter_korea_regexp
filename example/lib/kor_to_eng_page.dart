import 'package:flutter/material.dart';
import 'package:korea_regexp/kor_to_eng.dart';

class KorToEngPage extends StatefulWidget {
  const KorToEngPage({Key? key}) : super(key: key);

  @override
  _KorToEngPageState createState() => _KorToEngPageState();
}

class _KorToEngPageState extends State<KorToEngPage> {
  late TextEditingController controller;
  String text = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: 'ㅗ디ㅣㅐ 재깅!');
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
        title: Text("한글 -> 영어 테스트"),
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
                          text = korToEng(controller.text);
                        });
                      },
                      child: Text("변환")),
                ],
              ),
              Text(text,style: TextStyle(color: Colors.redAccent, fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}
