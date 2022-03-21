import 'package:flutter/material.dart';
import 'package:korea_regexp/korea_regexp.dart';

class ImplodePage extends StatefulWidget {
  const ImplodePage({Key? key}) : super(key: key);

  @override
  _ImplodePageState createState() => _ImplodePageState();
}

class _ImplodePageState extends State<ImplodePage> {
  late TextEditingController controller;
  var text = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: 'ㅂㅜㄹㄷㅏㄹㄱ');
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
        title: Text("자소 합치기"),
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
                        text = implode(controller.text);
                      });
                    },
                    child: Text("변환"),
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
