import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

const operatorColor = Colors.black38;
const buttonColor = Colors.black54;
const orangleColor = Colors.orange;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNUm = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith("0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black54,
        title: const Text(
          "CALCULATOR",
          style: TextStyle(
              color: Colors.orange, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(icon:const Icon(Icons.accessibility_new_sharp,color:Colors.orange,),
          onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Made By Shivam!"),));
          },),
      ),
      backgroundColor: Colors.brown,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12.0),
              color: Colors.black38,
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                direction: Axis.vertical,
                children: <Widget>[
                  Text(
                    hideInput ? "" : input,
                    style: const TextStyle(fontSize: 33, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black54),
                      child: Text(
                        output,
                        style: TextStyle(
                            fontSize: outputSize,
                            color: Colors.white.withOpacity(0.7)),
                      )),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(
                text: "AC",
                buttonBgColor: Colors.green,
                tColor: orangleColor,
              ),
              button(
                  text: "<",
                  buttonBgColor: operatorColor,
                  tColor: orangleColor),
              button(text: "e", buttonBgColor: Colors.transparent),
              button(
                  text: "/",
                  buttonBgColor: operatorColor,
                  tColor: orangleColor),
            ],
          ),
          Row(
            children: [
              button(
                text: "7",
              ),
              button(text: "8"),
              button(
                text: "9",
              ),
              button(
                  text: "x",
                  buttonBgColor: operatorColor,
                  tColor: orangleColor),
            ],
          ),
          Row(
            children: [
              button(
                text: "4",
              ),
              button(text: "5"),
              button(
                text: "6",
              ),
              button(
                  text: "-",
                  buttonBgColor: operatorColor,
                  tColor: orangleColor),
            ],
          ),
          Row(
            children: [
              button(
                text: "1",
              ),
              button(text: "2"),
              button(
                text: "3",
              ),
              button(
                  text: "+",
                  buttonBgColor: operatorColor,
                  tColor: orangleColor),
            ],
          ),
          Row(
            children: [
              button(
                text: "%",
              ),
              button(text: "0"),
              button(
                text: ".",
              ),
              button(
                  text: "=", buttonBgColor: Colors.green, tColor: orangleColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({
    text,
    tColor = Colors.white,
    buttonBgColor = buttonColor,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
            backgroundColor: MaterialStateProperty.all(buttonBgColor),
            padding: MaterialStateProperty.all(const EdgeInsets.all(22)),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, color: tColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
