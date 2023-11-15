import 'package:flutter/material.dart';

class PlayerStats extends StatefulWidget {
  const PlayerStats({super.key});

  @override
  State<PlayerStats> createState() => _PlayerStatsState();
}

class _PlayerStatsState extends State<PlayerStats> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: generateColumn(),
    );
  }

  generateColumn() {
    final column = Column(
      children: [
        SizedBox(height: 20,),
        teamRow("A"),
        const SizedBox(
          height: 20,
        ),
        teamRow("B")
      ],
    );

    return column;
  }

  teamRow(String s) {
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: displayModal(1),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
            child: const Column(children: [ Text('1', style: TextStyle(fontSize: 10),),Icon(Icons.person)]),),
        ElevatedButton(
            onPressed: displayModal(2),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
            child: const Column(children: [ Text('2', style: TextStyle(fontSize: 10)),Icon(Icons.person)]),),
        ElevatedButton(
            onPressed: displayModal(3),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
            child: const Column(children: [ Text('3', style: TextStyle(fontSize: 10)),Icon(Icons.person)]),),
        ElevatedButton(
            onPressed: displayModal(4),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
            child: const Column(children: [ Text('4', style: TextStyle(fontSize: 10)),Icon(Icons.person)]),),
        ElevatedButton(
            onPressed: displayModal(5),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
            child: const Column(children: [ Text('5', style: TextStyle(fontSize: 10)),Icon(Icons.person)]),),
      ],
    );

    return row;
  }

  displayModal(int s) {}
}
