import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'card_img.dart';

class QuestionView extends StatefulWidget {
  final AssetsAudioPlayer assetsAudioPlayer;
  const QuestionView({super.key, required this.assetsAudioPlayer});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  // assetsAudioPlayer = AssetsAudioPlayer();
  String s1 = "assets/questions/soru.png";
  String s1A = "assets/questions/image.png";
  String s1B = "assets/questions/image1.png";
  String s1C = "assets/questions/image2.png";
  String s1D = "assets/questions/image3.png";
  late List<String> s1ListImg;
  //soru2
  String s2 = "assets/questions/soru2.png";
  String s2A = "assets/questions/soru2A.png";
  String s2B = "assets/questions/soru2B.png";
  String s2C = "assets/questions/soru2C.png";
  String s2D = "assets/questions/soru2D.png";
  late List<String> s2ListImg;

  //soru3
  String s3 = "assets/questions/soru3.png";
  String s3A = "assets/questions/soru3A.png";
  String s3B = "assets/questions/soru3B.png";
  String s3C = "assets/questions/soru3C.png";
  late List<String> s3ListImg;

  //soru4
  String s4 = "assets/questions/soru4.png";
  String s4A = "assets/questions/soru4A.png";
  String s4B = "assets/questions/soru4B.png";
  String s4C = "assets/questions/soru4C.png";
  late List<String> s4ListImg;

  //soru5
  String s5 = "assets/questions/soru5.png";
  String s5A = "assets/questions/soru5A.png";
  String s5B = "assets/questions/soru5B.png";
  String s5C = "assets/questions/soru5C.png";
  late List<String> s5ListImg;

  late CardImg card1;
  late CardImg card2;
  late CardImg card3;
  late CardImg card4;
  late CardImg card5;
  int? _selectedOptionIndex;
  late CardImg chooseCard;
  bool isOpen = true;

  @override
  void initState() {
    super.initState();
    s1ListImg = [s1A, s1B, s1C, s1D];
    s2ListImg = [s2A, s2B, s2C, s2D];
    s3ListImg = [s3A, s3B, s3C];
    s4ListImg = [s4A, s4B, s4C];
    s5ListImg = [s5A, s5B, s5C];
    card1 = CardImg(questionPath: s1, answerIndex: 2, imgList: s1ListImg);
    card2 = CardImg(questionPath: s2, answerIndex: 0, imgList: s2ListImg);
    card3 = CardImg(questionPath: s3, answerIndex: 1, imgList: s3ListImg);
    card4 = CardImg(questionPath: s4, answerIndex: 1, imgList: s4ListImg);
    card5 = CardImg(questionPath: s5, answerIndex: 1, imgList: s5ListImg);
    chooseCard = card1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Sorular'),
        actions: [
          IconButton(
            onPressed: () async {
              await onPressed();
            },
            icon: Icon(isOpen ? Icons.music_note : Icons.music_off),
            iconSize: 30,
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Expanded(child: Center(child: Text("Aşağıdaki soruda son şekil ne olabilir ?"))),
          Expanded(child: Image.asset(chooseCard.questionPath)),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(children: chooseCard.imgList.asMap().entries.map((e) => buildAnserItems(e.value, e.key)).toList())),
          const Expanded(child: Text(""))
        ],
      ),
    );
  }

  Widget buildAnserItems(String path, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOptionIndex = index;
        });
        if (_selectedOptionIndex == chooseCard.answerIndex) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Tebrikler'),

                  // content: const Text('Yeni soruya geç'),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        await widget.assetsAudioPlayer.stop();
                        await widget.assetsAudioPlayer.dispose();
                        exit(0);
                      },
                      child: const Text('Çıkış'),
                    ),
                    ElevatedButton(
                      child: const Text('Yeni Soruya Geç'),
                      onPressed: () {
                        switch (chooseCard.questionPath) {
                          case "assets/questions/soru.png":
                            setState(() {
                              chooseCard = card2;
                              _selectedOptionIndex = null;
                            });
                            break;
                          case "assets/questions/soru2.png":
                            setState(() {
                              chooseCard = card3;
                              _selectedOptionIndex = null;
                            });
                            break;
                          case "assets/questions/soru3.png":
                            setState(() {
                              chooseCard = card4;
                              _selectedOptionIndex = null;
                            });
                            break;
                          case "assets/questions/soru4.png":
                            setState(() {
                              chooseCard = card5;
                              _selectedOptionIndex = null;
                            });
                            break;
                          case "assets/questions/soru5.png":
                            setState(() {
                              chooseCard = card1;
                              _selectedOptionIndex = null;
                            });
                            break;

                          default:
                        }
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                );
              });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Yanlıs!"),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: _selectedOptionIndex == index ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: _selectedOptionIndex == index ? Colors.blue : Colors.grey,
            width: 1.0,
          ),
        ),
        child: Image.asset(path),
      ),
    );
  }

  Future<void> onPressed() async {
    setState(() {
      isOpen = !isOpen;
    });
    if (widget.assetsAudioPlayer.isPlaying.value) {
      await widget.assetsAudioPlayer.pause();
    } else {
      await widget.assetsAudioPlayer.play();
    }
  }
}
