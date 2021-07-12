import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calculator_ristek/Components/round_button.dart';
import 'package:calculator_ristek/Components/round_button_grey.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: NewApp(),
    );
  }
}

class NewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  double hasil = 0;
  var base = new StringBuffer();
  List<String> op = [];
  bool flag = false;
  bool newOp = true;

  @override
  void initState() {
    super.initState();
    base.write("0");
  }

  void pressedKey(String str) => setState(() {
        pressAttentionDiv = true;
        pressAttentionMul = true;
        pressAttentionMin = true;
        pressAttentionPlus = true;
        if (op.isEmpty && newOp) {
          base.clear();
          op.clear();
          base.write(str);
          newOp = false;
        }
        else if (base.toString() == "0") {
          if (str == "00") {
          } else if (str == ".") {
            base.write(".");
          } else {
            base.clear();
            base.write(str);
          }
        } else if (op.length > 0 && flag == false) {
          if (str == "00") {
            str = "0";
          } else if (str == ".") {
            str = "0.";
          }
          base.clear();
          base.write(str);
          flag = true;
        } else {
          base.write(str);
        }
      });

  void adaOperator(String str) {
    if (op.isEmpty) {
      op.add(base.toString());
      flag = false;
      op.add(str);
    } else if (op.last == str) {
    } else if (op.last == "/" ||
        op.last == "+" ||
        op.last == "-" ||
        op.last == "x") {
      op.last = str;
    } else {
      op.add(base.toString());
      flag = false;
      op.add(str);
    }
  }

  void hasilAkhir() => setState(() {
        pressAttentionDiv = true;
        pressAttentionMul = true;
        pressAttentionMin = true;
        pressAttentionPlus = true;
        op.add(base.toString());
        double temp = 0;
        for (int i = 0; i < op.length; i++) {
          String s = op[i];
          if (s == "+") {
            temp = double.parse(op[i + 1]);
            hasil += temp;
            i++;
          } else if (s == "-") {
            temp = double.parse(op[i + 1]);
            hasil -= temp;
            i++;
          } else if (s == "x") {
            if (temp == 0) {
              hasil = 0;
            } else {
              temp = double.parse(op[i + 1]);
              if (hasil == 0) {
                hasil = 1;
              }
              hasil *= temp;
            }
            i++;
          } else if (s == "/") {
            double checker = double.parse(op[i + 1]);
            if (temp == 0) {
              if (checker == 0) {
                hasil = 0 / 0;
                break;
              }
              hasil = 0;
            } else {
              temp = double.parse(op[i + 1]);
              if (hasil == 0) {
                hasil = 1;
              }
              hasil /= temp;
            }
            i++;
          } else {
            temp = double.parse(s);
            hasil += temp;
          }
        }
        base.clear();
        if (hasil.toString().endsWith(".0")) {
          base.write(
              hasil.toString().substring(0, hasil.toString().length - 2));
        } else if (hasil.isNaN) {
          base.write("Error");
        } else if (hasil.isInfinite) {
          base.write("Error");
        } else {
          base.write(hasil.toString());
        }
        hasil = 0;
        op.clear();
        newOp = true;
      });

  void clear() => setState(() {
        base.clear();
        base.write("0");
        op.clear();
        hasil = 0;
        pressAttentionDiv = true;
        pressAttentionMul = true;
        pressAttentionMin = true;
        pressAttentionPlus = true;
        newOp = true;
      });

  bool pressAttentionDiv = true;
  bool pressAttentionMul = true;
  bool pressAttentionMin = true;
  bool pressAttentionPlus = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
          backgroundColor: Colors.black,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: new Text(
                        "Calculator",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Calculator()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: new Text("About Me"),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new AboutMe()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
            Widget>[
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomRight,
                width: double.infinity,
                height: double.infinity,
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: AutoSizeText(
                          base.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 100,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(
                // width: double.infinity,
                // height: double.infinity,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: RoundIconButtonGrey(
                                text: Text('C',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  clear();
                                })),
                        Expanded(
                            flex: 1,
                            child: RoundIconButtonGrey(
                                text: Text('+/-',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  String temp = base.toString();
                                  if (temp.startsWith("-") && temp != "0") {
                                    temp = temp.substring(1, temp.length);
                                  } else if (temp != "0") {
                                    temp = "-" + temp;
                                  }
                                  setState(() {
                                    pressAttentionDiv = true;
                                    pressAttentionMul = true;
                                    pressAttentionMin = true;
                                    pressAttentionPlus = true;
                                    base.clear();
                                    base.write(temp);
                                  });
                                })),
                        Expanded(
                            flex: 1,
                            child: RoundIconButtonGrey(
                                text: Text('DEL',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27)),
                                onPressed: () {
                                  String temp = base.toString();
                                  if (temp != "0" && temp.length > 1) {
                                    temp = temp.substring(0, temp.length - 1);
                                  } else if (temp.length == 1) {
                                    temp = "0";
                                  }
                                  setState(() {
                                    pressAttentionDiv = true;
                                    pressAttentionMul = true;
                                    pressAttentionMin = true;
                                    pressAttentionPlus = true;
                                    base.clear();
                                    base.write(temp);
                                  });
                                })),
                        Expanded(
                          flex: 1,
                          child: new RaisedButton(
                            child: Text('/',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: pressAttentionDiv
                                        ? Colors.white
                                        : Colors.blue,
                                    fontSize: 30)),
                            shape: CircleBorder(),
                            color:
                                pressAttentionDiv ? Colors.blue : Colors.white,
                            onPressed: () {
                              adaOperator('/');
                              setState(() {
                                pressAttentionDiv = !pressAttentionDiv;
                                pressAttentionMul = true;
                                pressAttentionMin = true;
                                pressAttentionPlus = true;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('7',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("7");
                                })),
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('8',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("8");
                                })),
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('9',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("9");
                                })),
                        Expanded(
                          flex: 1,
                          child: new RaisedButton(
                            child: Text('x',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: pressAttentionMul
                                        ? Colors.white
                                        : Colors.blue,
                                    fontSize: 30)),
                            shape: CircleBorder(),
                            color:
                                pressAttentionMul ? Colors.blue : Colors.white,
                            onPressed: () {
                              adaOperator('x');
                              setState(() {
                                pressAttentionMul = !pressAttentionMul;
                                pressAttentionDiv = true;
                                pressAttentionMin = true;
                                pressAttentionPlus = true;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('4',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("4");
                                })),
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('5',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("5");
                                })),
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('6',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("6");
                                })),
                        Expanded(
                          flex: 1,
                          child: new RaisedButton(
                            child: Text('-',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: pressAttentionMin
                                        ? Colors.white
                                        : Colors.blue,
                                    fontSize: 30)),
                            shape: CircleBorder(),
                            color:
                                pressAttentionMin ? Colors.blue : Colors.white,
                            onPressed: () {
                              adaOperator('-');
                              setState(() {
                                pressAttentionMin = !pressAttentionMin;
                                pressAttentionDiv = true;
                                pressAttentionMul = true;
                                pressAttentionPlus = true;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('1',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("1");
                                })),
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('2',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("2");
                                })),
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('3',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("3");
                                })),
                        Expanded(
                          flex: 1,
                          child: new RaisedButton(
                            child: Text('+',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: pressAttentionPlus
                                        ? Colors.white
                                        : Colors.blue,
                                    fontSize: 30)),
                            shape: CircleBorder(),
                            color:
                                pressAttentionPlus ? Colors.blue : Colors.white,
                            onPressed: () {
                              adaOperator('+');
                              setState(() {
                                pressAttentionPlus = !pressAttentionPlus;
                                pressAttentionDiv = true;
                                pressAttentionMul = true;
                                pressAttentionMin = true;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('0',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("0");
                                })),
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('00',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey("00");
                                })),
                        Expanded(
                            flex: 1,
                            child: RoundIconButton(
                                text: Text('.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                onPressed: () {
                                  pressedKey(".");
                                })),
                        Expanded(
                          flex: 1,
                          child: new RaisedButton(
                            child: Text('=',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 30)),
                            shape: CircleBorder(),
                            color: Colors.white,
                            onPressed: () {
                              hasilAkhir();
                            },
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ))
        ]),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF544F76),
        appBar: AppBar(
          title: Text(
            'About Me',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF011638),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 75.0,
                backgroundImage: AssetImage('images/JP35.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text('Muhammad Marsha Prawira',
                    style: TextStyle(
                        // fontFamily: 'Pacifico',
                        fontSize: 25.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              Text(
                'Hello! You can call me Marsha',
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 18.0,
                    color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              Text(
                'I\'m sophomore at Faculty of Computer Science\n in University of Indonesia ',
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: Colors.black87,
                    fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 200.0,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Text(
                'My hobby is to play Genshin Impact and Valorant',
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: Colors.black87,
                    fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              Card(
                color: Colors.white54,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: ListTile(
                  leading: Icon(Icons.phone_android_rounded,
                      color: Color(0xFF544F76)),
                  title: Text('+6287832482498',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              Card(
                color: Colors.white54,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: ListTile(
                  leading: Icon(Icons.mail, color: Color(0xFF544F76)),
                  title: Text('muhammad.marsha@ui.ac.id',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              Card(
                color: Colors.white54,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: ListTile(
                  leading:
                      Icon(Icons.camera_alt_outlined, color: Color(0xFF544F76)),
                  title: Text('@marshaprwr',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: new Text("Calculator"),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Calculator()),
                  );
                },
              ),
              Container(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: new Text(
                        "About Me",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new AboutMe()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
