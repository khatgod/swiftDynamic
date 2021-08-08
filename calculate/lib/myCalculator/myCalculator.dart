import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalculatorPage extends StatefulWidget {
  MyCalculatorPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyCalculatorPageState createState() => _MyCalculatorPageState();
}

class _MyCalculatorPageState extends State<MyCalculatorPage> {
  String answer;
  var input = '';
  int chkValue = 0;
  bool chkOper = false;

  @override
  void initState() {
    answer = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[buildAnswerWidget(), buildNumPadWidget()],
          ),
        ));
  }

  Widget buildAnswerWidget() {
    return Container(
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height * 0.275),
        color: Color(0xffecf0f1),
        child: Align(
            alignment: Alignment.bottomRight,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text(answer,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold))
            ])));
  }

  Widget buildNumPadWidget() {
    return Container(
        color: Color(0xffecf0f1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildNumberButton("C", numberButton: false, onTap: () {
                  clear();
                }),
                buildNumberButton("+/-", numberButton: false, onTap: () {
                  plusandminus(strToint(answer));
                }),
                buildNumberButton("%", numberButton: false, onTap: () {
                  chkValue++;
                  isOperator("%");
                }),
                buildNumberButton("÷", numberButton: false, onTap: () {
                  chkValue++;
                  isOperator("/");
                }),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              buildNumberButton("7", onTap: () {
                input += "7";
                addNumberToAnswer(7);
              }),
              buildNumberButton("8", onTap: () {
                input += "8";
                addNumberToAnswer(8);
              }),
              buildNumberButton("9", onTap: () {
                input += "9";
                addNumberToAnswer(9);
              }),
              buildNumberButton("x", numberButton: false, onTap: () {
                chkValue++;
                isOperator("*");
              }),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              buildNumberButton("4", onTap: () {
                input += "4";
                addNumberToAnswer(4);
              }),
              buildNumberButton("5", onTap: () {
                input += "5";
                addNumberToAnswer(5);
              }),
              buildNumberButton("6", onTap: () {
                input += "6";
                addNumberToAnswer(6);
              }),
              buildNumberButton("-", numberButton: false, onTap: () {
                chkValue++;
                isOperator("-");
              }),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              buildNumberButton("1", onTap: () {
                input += "1";
                addNumberToAnswer(1);
              }),
              buildNumberButton("2", onTap: () {
                input += "2";
                addNumberToAnswer(2);
              }),
              buildNumberButton("3", onTap: () {
                input += "3";
                addNumberToAnswer(3);
              }),
              buildNumberButton("+", numberButton: false, onTap: () {
                chkValue++;
                isOperator("+");
              }),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildNumberButton("0", onTap: () {
                  input += "0";
                  addNumberToAnswer(0);
                }),
                buildNumberButton(".", numberButton: false, onTap: () {
                  input += ".";
                  isOperator(".");
                }),
                buildNumberButton("=", numberButton: false, onTap: () {
                  isOperator("=");
                  setState(() {
                    chkValue++;
                    equalPressed();
                  });
                  input = answer;
                }),
              ],
            )
          ],
        ));
  }

  void isOperator(String str) {
    chkOper = true;
    if (str != "=") {
      if (chkValue > 0) {
        setState(() {
          equalPressed();
        });
        input = answer;
      }
      input += str;
    }

    print(input.toString());
  }

  void equalPressed() {
    String finaluserinput = input;
    // finaluserinput = input.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }

  int strToint(String str) {
    var myInt = int.parse(str);
    assert(myInt is int);
    return myInt;
  }

  void clear() {
    setState(() {
      answer = "0";
      input = '';
      chkValue = 0;
    });
  }

  void plusandminus(int number) {
    setState(() {
      if (number != 0) {
        number *= -1;
      }
      answer = number.toString();
    });
  }

  void addNumberToAnswer(int number) {
    setState(() {
      if (number == 0 && answer == "0") {
      } else if (number != 0 && answer == "0" || chkValue > 1) {
        answer = number.toString();
        chkValue = 1;
      } else {
        answer += number.toString();
      }
    });
    print("$answer $input");
  }

  Widget buildNumberButton(String str,
      {@required Function() onTap, bool numberButton = true}) {
    Widget widget;
    widget = GestureDetector(
        onTap: onTap,
        child: Container(
            margin: EdgeInsets.all(1),
            color:
                numberButton ? Colors.lightBlue[100] : Colors.blueAccent[100],
            height: MediaQuery.of(context).size.width * 0.24,
            width: str != "0"
                ? MediaQuery.of(context).size.width * 0.24
                : MediaQuery.of(context).size.width * 0.48 + 2,
            child: Center(
                child: Text(str,
                    style: TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold)))));

    return widget;
  }
}
