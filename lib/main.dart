import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(QuranWidget());
}

class QuranWidget extends StatelessWidget {
  const QuranWidget({super.key});
  void musicplay(String numMusic) {
    final player = AudioPlayer();
    player.play(AssetSource('audio/$numMusic.mp3'));
  }

  Widget mybutton({required String buttonText, required String musicFile}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          musicplay(musicFile);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 41, 25, 10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 230, 230, 230),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 23, 17, 13),
        appBar: AppBar(
          title: Center(
            child: Text(
              'Quran Kareem',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 230, 230, 230),
              ),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 41, 25, 10),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            mybutton(buttonText: 'الفاتحة', musicFile: '001'),
            mybutton(buttonText: 'الكافرون', musicFile: '109'),
            mybutton(buttonText: 'النصر', musicFile: '110'),
            mybutton(buttonText: 'المسد', musicFile: '111'),
            mybutton(buttonText: 'الإخلاص', musicFile: '112'),
            mybutton(buttonText: 'الفلق', musicFile: '113'),
            mybutton(buttonText: 'الناس', musicFile: '114'),
          ],
        ),
      ),
    );
  }
}
