import 'package:csv/csv.dart';
import 'package:example/correct_postpositions_page.dart';
import 'package:example/explode_page.dart';
import 'package:example/implode_page.dart';
import 'package:example/kor_to_eng_page.dart';
import 'package:example/reg_exp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late var searchTerms;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final csv = await rootBundle.loadString('assets/search_address.csv');
  searchTerms = const CsvToListConverter().convert(csv);
  searchTerms
      .sort((List a, List b) => (a[0] as String).compareTo(b[0] as String));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("플러터 한국어 정규표현식"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExplodePage()));
              },
              child: Text("자소 분리"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImplodePage()));
              },
              child: Text("자소 합치기"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KorToEngPage()));
              },
              child: Text("한글 -> 영어"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KoreaRegExpPage()));
              },
              child: Text("한글 정규 표현식"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CorrectPostPositionsPage()));
              },
              child: Text("조사 자동 치환"),
            ),
          ],
        ),
      ),
    );
  }
}
