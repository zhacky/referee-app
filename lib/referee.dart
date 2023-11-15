import 'package:basketball_referee/players.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class RefereeWidget extends StatefulWidget {
  final Soundpool pool;
  final ValueSetter<SoundpoolOptions> onOptionsChange;
  const RefereeWidget({super.key, required this.pool, required this.onOptionsChange});

  @override
  State<RefereeWidget> createState() => _RefereeWidgetState();
}

class _RefereeWidgetState extends State<RefereeWidget> {
  // region " fields "
  Soundpool get soundpool => widget.pool;
  int? whistlesStreamId;
  int? singleWhistleStreamId;
  int? buzzerStreamId;
  int? themeSoundStreamId;
  int? cheerStreamId;
  int? defenseStreamId;
  bool isPlayingW = false;
  bool isPlayingSW = false;
  bool isPlayingB = false;
  bool isPlayingTS = false;
  bool isPlayingC = false;
  bool isPlayingD = false;
  late Future<int> whistlesId;
  late Future<int> singleWhistleId;
  late Future<int> buzzerId;
  late Future<int> themeSoundId;
  late Future<int> cheerId;
  late Future<int> defenseId;
  static const whistles = "assets/whistle.mp3";
  static const singleWhistle = "assets/whistle2.mp3";
  static const buzzer = "assets/buzzer.mp3";
  static const themeSound = "assets/basketball_theme.mp3";
  static const cheer = "assets/cheer.mp3";
  static const defense = "assets/defense.mp3";
  int rightScore = 0;
  final grayTextStyle = const TextStyle(color: Colors.grey, fontSize: 12);
  final scoreTextStyle = const TextStyle(color: Colors.green, fontSize: 40);
  int leftScore = 0;

// endregion

  @override
  void initState() {
    super.initState();
    loadSounds();
  }

  @override
  void didUpdateWidget(covariant RefereeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pool != widget.pool) {
      loadSounds();
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Referee App', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    MaterialButton(
                      color: Colors.white,
                      minWidth: 75,
                      height: 75,
                      onPressed: wh2Pressed,
                      child: Column(
                        children: [
                          const Icon(Icons.audiotrack),
                          Text(
                            'Long\nWhistle',
                            style: grayTextStyle,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      color: Colors.white,
                      minWidth: 75,
                      height: 75,
                      onPressed: whPressed,
                      child: Column(
                        children: [
                          const Icon(Icons.audiotrack),
                          Text(
                            '3 Whistles',
                            style: grayTextStyle,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      color: Colors.white,
                      minWidth: 75,
                      height: 75,
                      onPressed: buzzPressed,
                      child: Column(
                        children: [
                          const Icon(Icons.alarm),
                          Text(
                            'Buzzer',
                            style: grayTextStyle,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: themePressed,
                color: Colors.white,
                minWidth: 75,
                height: 75,
                child: Column(
                  children: [
                    const Icon(Icons.sports_basketball),
                    Text(
                      'Theme\nSound',
                      style: grayTextStyle,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                color: Colors.white,
                onPressed: cheerPressed,
                minWidth: 75,
                height: 75,
                child: Column(
                  children: [
                    const Icon(Icons.people),
                    Text(
                      'Cheer',
                      style: grayTextStyle,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                color: Colors.white,
                onPressed: defensePressed,
                minWidth: 75,
                height: 75,
                child: Column(
                  children: [
                    const Icon(Icons.security),
                    Text('Defense\nChant', style: grayTextStyle)
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    'Team A',
                    style: TextStyle(fontSize: 25),
                  ),
                  MaterialButton(
                    onPressed: scoreLeft,
                    color: Colors.orangeAccent,
                    minWidth: 20,
                    height: 20,
                    child: const Icon(Icons.arrow_drop_up),
                  ),
                  Text('$leftScore', style: scoreTextStyle),
                  MaterialButton(
                    onPressed: reduceLeft,
                    color: Colors.orangeAccent,
                    minWidth: 20,
                    height: 20,
                    child: const Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                ':',
                style: scoreTextStyle,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  const Text(
                    'Team B',
                    style: TextStyle(fontSize: 25),
                  ),
                  MaterialButton(
                    onPressed: scoreRight,
                    color: Colors.purpleAccent,
                    minWidth: 20,
                    height: 20,
                    child: const Icon(Icons.arrow_drop_up),
                  ),
                  Text('$rightScore', style: scoreTextStyle),
                  MaterialButton(
                    onPressed: reduceRight,
                    color: Colors.purpleAccent,
                    minWidth: 20,
                    height: 20,
                    child: const Icon(Icons.arrow_drop_down),
                  )
                ],
              )
            ],
          ),
          const PlayerStats()
        ],
      ),
    );
  }

// region button presses
  void whPressed() {
    if (!isPlayingW) {
      playWhistles();
    } else {
      stopWhistles();
    }
    setState(() {
      isPlayingW = !isPlayingW;
    });
  }
  void wh2Pressed() {
    if (!isPlayingSW) {
      playSingleWhistle();
    } else {
      stopSingleWhistle();
    }
    setState(() {
      isPlayingSW = !isPlayingSW;
    });
  }
  void buzzPressed() {
    if (!isPlayingB) {
      playBuzzer();
    } else {
      stopBuzzer();
    }
    setState(() {
      isPlayingB = !isPlayingB;
    });
  }
  void themePressed() {
    if (!isPlayingTS) {
      playThemeSound();
    } else {
      stopThemeSound();
    }
    setState(() {
      isPlayingTS = !isPlayingTS;
    });
  }
  void cheerPressed() {
    if (!isPlayingC) {
      playCheer();
    } else {
      stopCheer();
    }
    setState(() {
      isPlayingC = !isPlayingC;
    });
  }
  void defensePressed() {
    if (!isPlayingD) {
      playDefense();
    } else {
      stopDefense();
    }
    setState(() {
      isPlayingD = !isPlayingD;
    });
  }

  void scoreLeft() {
    SystemSound.play(SystemSoundType.click);
    setState(() {
      leftScore++;
    });
  }
  void scoreRight() {
    SystemSound.play(SystemSoundType.click);
    setState(() {
      rightScore++;
    });
  }
  void reduceLeft() {
    SystemSound.play(SystemSoundType.click);
    setState(() {
      if (leftScore > 0) {
        leftScore--;
      }
    });
  }
  void reduceRight() {
    SystemSound.play(SystemSoundType.click);
    setState(() {
      if (rightScore > 0) {
        rightScore--;
      }
    });
  }
// endregion

  Future<void> loadSounds() async {

    whistlesId = loadWhistles();
    singleWhistleId = loadSingleWhistle();
    buzzerId = loadBuzzer();
    themeSoundId = loadThemeSound();
    cheerId = loadCheer();
    defenseId = loadDefense();
  }

  Future<int> loadWhistles() async {
    var assetWhistles = await rootBundle.load(whistles);
    return  await soundpool.load(assetWhistles);
  }

  Future<void> playWhistles() async {
    var whistleSound = await whistlesId;
    whistlesStreamId = await soundpool.play(whistleSound);
  }

  Future<void> stopWhistles() async {
    if (whistlesStreamId != null) {
      await soundpool.stop(whistlesStreamId!);
    }
  }

  Future<int> loadSingleWhistle() async {
    var assetSingleWhistle = await rootBundle.load(singleWhistle);
    return await soundpool.load(assetSingleWhistle);
  }

  Future<void> playSingleWhistle() async {
    var singleWhistleSound = await singleWhistleId;
    singleWhistleStreamId = await soundpool.play(singleWhistleSound);
  }

  Future<void> stopSingleWhistle() async {
    if (singleWhistleStreamId != null) {
      await soundpool.stop(singleWhistleStreamId!);
    }
  }

  Future<int> loadBuzzer() async {
    var assetBuzzer = await rootBundle.load(buzzer);
    return await soundpool.load(assetBuzzer);
  }

  Future<void> playBuzzer() async {
    var buzzerSound = await buzzerId;
    buzzerStreamId = await soundpool.play(buzzerSound);
  }

  Future<void> stopBuzzer() async {
    if (buzzerStreamId != null) {
      await soundpool.stop(buzzerStreamId!);
    }
  }

  Future<int> loadThemeSound() async {
    var assetTheme = await rootBundle.load(themeSound);
    return await soundpool.load(assetTheme);
  }

  Future<void> playThemeSound() async {
    var themeSound = await themeSoundId;
    themeSoundStreamId = await soundpool.play(themeSound);
  }

  Future<void> stopThemeSound() async {
    if (themeSoundStreamId != null) {
      await soundpool.stop(themeSoundStreamId!);
    }
  }

  Future<int> loadCheer() async {
    var assetCheer = await rootBundle.load(cheer);
    return await soundpool.load(assetCheer);
  }

  Future<void> playCheer() async {
    var cheerSound = await cheerId;
    cheerStreamId = await soundpool.play(cheerSound);
  }

  Future<void> stopCheer() async {
    if (cheerStreamId != null) {
      await soundpool.stop(cheerStreamId!);
    }
  }

  Future<int> loadDefense() async {
    var assetDefense = await rootBundle.load(defense);
    return await soundpool.load(assetDefense);
  }

  Future<void> playDefense() async {
    var defenseSound = await defenseId;
    defenseStreamId = await soundpool.play(defenseSound);
  }

  Future<void> stopDefense() async {
    if (defenseStreamId != null) {
      await soundpool.stop(defenseStreamId!);
    }
  }
}
