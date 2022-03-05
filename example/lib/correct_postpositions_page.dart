import 'dart:math';

import 'package:flutter/material.dart';
import 'package:korea_regexp/korea_regexp.dart';

const kExampleText = [
  '전쟁와(과) 평화',
  '죄와(과) 벌',
  '설탕은(는) 달다',
  '고양이은(는) 건드리지 마라',
  '홍길동이(가) 홍상직을(를) 만났다',
  '토끼 이(가) 거북이을(를) 만났다',
  '''"토끼"이(가) '거북이'을(를) 만났다''',
  '고양이은(는) 건드리지 마라'
];

class CorrectPostPositionsPage extends StatefulWidget {
  const CorrectPostPositionsPage({Key? key}) : super(key: key);

  @override
  _CorrectPostPositionsPageState createState() =>
      _CorrectPostPositionsPageState();
}

class _CorrectPostPositionsPageState extends State<CorrectPostPositionsPage> {
  late TextEditingController controller;
  late dynamic text = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: kExampleText[Random().nextInt(8)]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("조사 자동 치환"),
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
                          text = correctPostpositions(controller.text);
                        });
                      },
                      child: Text("변환"),),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    controller.text = kExampleText[Random().nextInt(7)];
                    print(Random().nextInt(7));
                  });
                },
                child: Text("랜덤 예시 불러오기"),),
              Text("1. 조사 A(B)형태로 적어주세요. 예시: 은(는), 이(가)"),
              Text("2. 명사 뒤에 작은 따옴표, 큰 따옴표, 공백 한칸은 올 수 있습니다.",),
              Text('''예시: "'토끼'",""거북이"","고양이 "''',),
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
