import 'package:flutter/material.dart';
import 'package:tp_2/screens/QuizzPage.dart';

class Resultat extends StatefulWidget {
  final request;

  final reponse;

  const Resultat({super.key, required this.title, required this.request, required this.reponse});

  final String title;

  @override
  State<Resultat> createState() => _ResultatState();
}

class _ResultatState extends State<Resultat> {

  @override
  Widget build(BuildContext context) {
    print(widget.request);
    print(widget.request[0].isCorrect);
    String printResponse(){
      var resp = "";
      print("object");
      for(int i=0; i<widget.request.length; i++){

        var req = widget.request;

        resp = resp + req[i].questionText;

        String ret = req[i].isCorrect == widget.reponse[i] ? "BONNE REPONSE" : "MAUVAISE REPONSE";

        resp = resp + ret +"\n\n";
      }
      return resp;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
          child: Text(
            widget.title,
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),

              child: Text(
                printResponse(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
