import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedAnswersPage extends StatefulWidget {
  const SavedAnswersPage({super.key});

  @override
  State<SavedAnswersPage> createState() => _SavedAnswersPageState();
}

class _SavedAnswersPageState extends State<SavedAnswersPage> {
  Map<String, Map<String, dynamic>> allSavedAnswers =
      {};
       // Map to store answers of all sets
  // Map<int, Map<int, String>> allSavedAnswers =
  //     {}; // Map to store answers of all sets

  @override
  void initState() {
    super.initState();
    loadAllSavedAnswers(); 
  }

  // load answers for all sets from SharedPreferences
  void loadAllSavedAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    // We'll try to load saved answers for all sets, 
    //start from the set 1
    int setNumber = 1;
    while (true) {
      String? answersJson = prefs.getString('set_${setNumber}_answers');
      if (answersJson == null) {
        break;
      }

      // Decode the JSON string back into a map
      Map<String, dynamic> answersMap = jsonDecode(answersJson);

      // Store the answers for this set in the allSavedAnswers map
      setState(() {
        allSavedAnswers['$setNumber'] =
            answersMap.map((key, value) => MapEntry(key, value as String));
        // allSavedAnswers[setNumber] = answersMap
        //     .map((key, value) => MapEntry(int.parse(key), value as String));
      });

      setNumber++; // Move to the next set
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Answers for All Sets'),
      ),
      body: allSavedAnswers.isEmpty
          ? const Center(child: Text('No saved answers found for any set.'))
          : ListView.builder(
              itemCount: allSavedAnswers.length,
              itemBuilder: (context, index) {
                final setNumber = allSavedAnswers.keys.elementAt(index);
                final answers = allSavedAnswers[setNumber]!;
                return ExpansionTile(
                  title: Text('Set $setNumber'),
                  children: answers.entries.map((entry) {
                    final questionIndex = entry.key;
                    final answer = entry.value;
                    return ListTile(
                      title: Text(
                          'Question ${int.parse(questionIndex) + 1} : $answer'),
                    );
                  }).toList(),
                );
              },
            ),
    );
  }
}
