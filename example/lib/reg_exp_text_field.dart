import 'package:example/main.dart';
import 'package:example/reg_exp_page.dart';
import 'package:flutter/material.dart';
import 'package:korea_regexp/korea_regexp.dart';

class RegExpTextField extends StatefulWidget {
  const RegExpTextField({Key? key}) : super(key: key);

  @override
  _RegExpTextFieldState createState() => _RegExpTextFieldState();
}

class _RegExpTextFieldState extends State<RegExpTextField> {

  OverlayEntry? overlayEntry;
  final LayerLink _layerLink = LayerLink();
  late List<List<dynamic>> terms;
  late final TextEditingController textController;
  late final FocusNode focusNode;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    scrollController = ScrollController();
    focusNode = FocusNode();
    terms = searchTerms;

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (overlayEntry == null) {
          overlayEntry = _createOverlayEntry();
          Overlay.of(context)?.insert(overlayEntry!);
        }
      } else {
        if (overlayEntry?.mounted ?? false) {
          overlayEntry?.remove();
          overlayEntry = null;
        }
      }
    });

    textController.addListener(() {
      if (textController.text.isNotEmpty) {
        changeSearchTerm(textController.text);
      } else {
        clearSearchTerm();
      }
    });
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   CompositedTransformTarget(
      link: _layerLink,
      child: SafeArea(
        child: SizedBox(
          height: 40,
          child: TextField(
            focusNode: focusNode,
            controller: textController,
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(
          left: offset.dx,
          top: offset.dy + size.height,
          width: size.width,
          child: Material(
            elevation: 4.0,
            child: Container(
                height: 400,
                child: (terms.isNotEmpty)
                    ? ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.only(bottom: 200),
                    itemCount: terms.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(terms[index][0], ));
                    })
                    : const Center(
                  child: Text("검색어가 없습니다."),
                )),
          )),
    );
  }

  void clearSearchTerm() {
    terms = searchTerms;
  }

  void changeSearchTerm(String text) {
    List<List<dynamic>> list = searchTerms;

    RegExp regExp = getRegExp(
        text,
        RegExpOptions(
          initialSearch: initialSearch,
          startsWith: startsWith,
          endsWith: endsWith,
          fuzzy: fuzzy,
          ignoreSpace: ignoreSpace,
          ignoreCase: ignoreCase,
        ));

    terms =
        list.where((element) => regExp.hasMatch(element[0] as String)).toList();
  }
}
