import 'package:flutter/material.dart';

import '../../data/populations.dart';

class CalculateSystemDialog extends StatefulWidget {
  CalculateSystemDialog({required this.populations, Key? key}) : super(key: key);
  Populations populations;

  @override
  State<CalculateSystemDialog> createState() => _CalculateSystemDialogState();
}

class _CalculateSystemDialogState extends State<CalculateSystemDialog> {
  final TextEditingController _timeStepController = TextEditingController(text: '0.1');
  final TextEditingController _calculationPeriodController =
      TextEditingController(text: '1000');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Calculation parameters'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _timeStepController,
              decoration: const InputDecoration(
                suffixText: 's',
                labelText: 'Time step',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _calculationPeriodController,
              decoration: const InputDecoration(
                suffixText: 's',
                labelText: 'Calculation period',
              ),
            ),
          )
        ],
      ),
      actions: [
        TextButton(onPressed: (){
          final double timeStep = double.parse(_timeStepController.text);
          final double simPeriod = double.parse(_calculationPeriodController.text);
          widget.populations.calculateSeries(timeStep, simPeriod);
          Navigator.of(context).pop();
        }, child: const Text('Ok'))
      ],
    );
  }
}
