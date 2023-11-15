import 'package:basketball_referee/referee.dart';
import 'package:flutter/foundation.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/material.dart';

class SoundPoolInitializer extends StatefulWidget {
  const SoundPoolInitializer({super.key});

  @override
  State<SoundPoolInitializer> createState() => _SoundPoolInitializerState();
}

class _SoundPoolInitializerState extends State<SoundPoolInitializer> {
  Soundpool? pool;
  SoundpoolOptions soundpoolOptions = const SoundpoolOptions();

  @override
  void initState() {
    super.initState();
    initPool(soundpoolOptions);
  }

  @override
  Widget build(BuildContext context) {
    if (pool == null) {
        initPool(soundpoolOptions);
    }
      return RefereeWidget(
        pool: pool!,
        onOptionsChange: initPool,
      );
  }

  void initPool(SoundpoolOptions soundOptions) {
    pool?.dispose();
    setState(() {
      soundpoolOptions = soundOptions;
      pool = Soundpool.fromOptions(options: soundpoolOptions);
      if (kDebugMode) {
        print('pool updated: $pool');
      }
    });
  }
}

