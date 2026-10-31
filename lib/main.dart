import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const QuranWidget());
}

class QuranWidget extends StatefulWidget {
  const QuranWidget({super.key});

  @override
  State<QuranWidget> createState() => _QuranWidgetState();
}

class _QuranWidgetState extends State<QuranWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late final StreamSubscription<void> _completionSubscription;
  String? _currentMusicFile;
  int _playRequest = 0;

  @override
  void initState() {
    super.initState();
    _completionSubscription = _audioPlayer.onPlayerComplete.listen((_) {
      if (!mounted) return;
      setState(() => _currentMusicFile = null);
    });
  }

  Future<void> _playMusic(String musicFile) async {
    if (_currentMusicFile == musicFile) return;

    final request = ++_playRequest;
    setState(() => _currentMusicFile = musicFile);

    try {
      await _audioPlayer.stop();
      if (!mounted || request != _playRequest) return;
      await _audioPlayer.play(AssetSource('audio/$musicFile.mp3'));
    } catch (_) {
      if (mounted && request == _playRequest) {
        setState(() => _currentMusicFile = null);
      }
    }
  }

  @override
  void dispose() {
    unawaited(_completionSubscription.cancel());
    unawaited(_audioPlayer.dispose());
    super.dispose();
  }

  Widget mybutton({required String buttonText, required String musicFile}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: ElevatedButton(
          onPressed: () {
            _playMusic(musicFile);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 41, 25, 10),
          ),

          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(Icons.play_arrow, color: Color.fromARGB(255, 230, 230, 230)),
              SizedBox(width: 10),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 230, 230, 230),
                ),
              ),
            ],
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
