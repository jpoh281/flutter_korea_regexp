import 'package:example/reg_exp_text_field.dart';
import 'package:flutter/material.dart';

bool initialSearch = false;
bool startsWith = false;
bool endsWith = false;
bool ignoreSpace = false;
bool ignoreCase = false;
bool fuzzy = false;

class KoreaRegExpPage extends StatefulWidget {
  const KoreaRegExpPage({Key? key}) : super(key: key);

  @override
  _KoreaRegExpPageState createState() => _KoreaRegExpPageState();
}

class _KoreaRegExpPageState extends State<KoreaRegExpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("한글 자동완성을 위한 정규식"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    checkBox("initialSearch", initialSearch, (value) {
                      setState(() {
                        initialSearch = value;
                      });
                    }),
                    checkBox("startsWith", startsWith, (value) {
                      setState(() {
                        startsWith = value;
                      });
                    }),
                    checkBox("endsWith", endsWith, (value) {
                      setState(() {
                        endsWith = value;
                      });
                    }),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Row(
                  children: [
                    checkBox("ignoreSpace", ignoreSpace, (value) {
                      setState(() {
                        ignoreSpace = value;
                      });
                    }),
                    checkBox("ignoreCase", ignoreCase, (value) {
                      setState(() {
                        ignoreCase = value;
                      });
                    }),
                    checkBox("fuzzy", fuzzy, (value) {
                      setState(() {
                        fuzzy = value;
                      });
                    }),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                const RegExpTextField()
              ],
            )),
      ),
    );
  }

  Row checkBox(String text, bool aValue, ValueChanged onChanged) {
    return Row(
      children: [
        Text(text),
        Checkbox(value: aValue, onChanged: onChanged),
      ],
    );
  }
}
