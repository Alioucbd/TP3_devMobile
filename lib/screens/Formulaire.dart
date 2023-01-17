import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Formulaire extends StatefulWidget {
  const Formulaire({super.key, required this.title});

  final String title;
  @override
  State<Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {

  final _formKey = GlobalKey<FormState>();
  String _theme ="",_question = "", _reponse ="";
  CollectionReference questions = FirebaseFirestore.instance.collection('question');
  Future<void> addQuestion(theme,question,reponse) {
    // Calling the collection to add a new Question
    return questions
    //adding to firebase collection
        .add({
      'theme': theme,
      'question': question,
      'reponse': reponse
    })
        .then((value) => print("data Added"))
        .catchError((error) => print(" couldn't be added."));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Center(
          child: Text(
            'Questions/Réponses',
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Theme"),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.deepPurpleAccent, //<-- SEE HERE
              ),

              // The validator receives the text that the user has entered.
              validator: (theme) {
                if (theme == null || theme.isEmpty) {
                  return 'Preciser un Theme';
                }
                _theme = theme;
                return null;
              },
            ),
            Text("Question"),
            TextFormField(
              decoration: InputDecoration(
                filled: true, //<-- SEE HERE
                fillColor: Colors.deepPurpleAccent, //<-- SEE HERE
              ),
              // The validator receives the text that the user has entered.
              validator: (question) {
                if (question == null || question.isEmpty) {
                  return 'Question obligatoire';
                }
                _question = question;
                return null;
              },
            ),
            Text("Reponse"),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.deepPurpleAccent, //<-- SEE HERE
              ),
              // The validator receives the text that the user has entered.
              validator: (reponse) {
                if (reponse == null || reponse.isEmpty) {
                  return 'Question obligatoire';
                }
                _reponse = reponse;
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    addQuestion(_theme,_question,_reponse);
                  }
                },
                child: const Text('Submite'),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
