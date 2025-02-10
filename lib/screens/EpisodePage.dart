import 'package:flutter/material.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({super.key});
  @override
  State<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EpisodePage'),
      ),
      body: Column(
        children: [
          Container(),
        ],
      ),
    );
  }
}