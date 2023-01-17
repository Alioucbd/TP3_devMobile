import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_2/blocs/next/bloc.dart';
import 'package:tp_2/blocs/next/state.dart';

import '../blocs/next/event.dart';
import 'Resultat.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key, required this.title});

  final String title;

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class Question {
  String questionText;
  bool isCorrect;
  Question({required this.questionText, required this.isCorrect});

  setQuestionText(String questionText ){
    this.questionText = questionText;
  }

  setIsCorrect(bool isCorrect ){
    this.isCorrect = isCorrect;
  }

}


class _QuizzPageState extends State<QuizzPage> {
  int index = 0;
  bool buttonFalse = false, buttonTrue =false;
  var reponse =  Map<int, bool>();


  @override
  Widget build(BuildContext context) {
    var request;
    CollectionReference requette = FirebaseFirestore.instance.collection('question');
    FutureBuilder<DocumentSnapshot>(
      future: requette.doc().get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          request = data;
        }

        return Text("loading");
      },
    );

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: BlocBuilder<NextBloc, NextState>(
          builder: (context, state) {
            print(state.props.first);
            index = state.props.first;

            if(request.length == index){
              Navigator.push(context,
                  MaterialPageRoute<void>(
                      builder:(BuildContext context) {
                        return Resultat(title: "Resultat", request: request, reponse: reponse);
                      }));
            }
           return Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/img_quizz.jpg',
                width: 200,
                height: 300,
              ),
              SizedBox(height:40.0),
              Expanded(
                child: Container(
                  width: 100,
                  height: 100,
                  //color: Colors.blue,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text(
                      request[index].questionText,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height:40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.blueGrey,
                      ),
                      onPressed: () => buttonTrue = true,
                      child: const Text('VRAI'),
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
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.blueGrey,
                      ),
                      onPressed: () => buttonFalse = true,
                      child: const Text('FAUX'),
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
                    child:TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                          backgroundColor: Colors.blueGrey,
                        ),
                        onPressed: () => context.read<NextBloc>().add(NextSubmitEvent(index,buttonFalse,buttonTrue,reponse)),
                        //next(request)
                        child: const Text('->'),
                      ),
                  ),
                ],
              ),
              const SizedBox(height:40.0),
            ],
          );
  },
),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
