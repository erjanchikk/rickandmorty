import 'package:flutter/material.dart';
import 'package:rickandmorty/models/characterModel.dart';

class CharacterPage extends StatefulWidget {
  final Result character;
  const CharacterPage({super.key, required this.character});
  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.character.name.toString(),),
      ),
      body: Column(
        children: [
          Container(),
        ],
      ),
    );
  }
}