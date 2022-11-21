import 'package:flutter/material.dart';

import '../../data/populations.dart';

class InteractionMatrixWidget extends StatefulWidget {
  InteractionMatrixWidget({required this.populations, Key? key})
      : super(key: key);
  Populations populations;

  @override
  State<InteractionMatrixWidget> createState() =>
      _InteractionMatrixWidgetState();
}

class _InteractionMatrixWidgetState extends State<InteractionMatrixWidget> {
  final GlobalKey key = GlobalKey();
  late Populations _populations;
  late List<List<TextEditingController>> _controllers;

  @override
  void initState() {
    super.initState();
    _populations = widget.populations;
    _controllers = List.generate(
        _populations.interactionMatrix.length,
        (i) => List.generate(
            _populations.interactionMatrix[i].length,
            (j) => TextEditingController(
                text: _populations.interactionMatrix[i][j].toStringAsExponential(1))));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      key: key,
      title: const Text('Interaction'),
      children: [
        for (int i = 0; i < _populations.interactionMatrix.length; i++) ...[
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int j = 0;
                  j < _populations.interactionMatrix[i].length;
                  j++) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[i][j],
                      onChanged: (value){
                        if(value.isNotEmpty && double.tryParse(value)!=null){
                          _populations.interactionMatrix[i][j] = double.parse(value);
                        }
                      },
                    ),
                  ),
                )
              ],
            ],
          )
        ]
      ],
    );
  }
}
