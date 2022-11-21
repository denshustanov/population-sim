import 'package:flutter/material.dart';

import '../../data/populations.dart';

class AmountEditWidget extends StatefulWidget {
  AmountEditWidget({required this.populations, Key? key}) : super(key: key);
  Populations populations;

  @override
  State<AmountEditWidget> createState() => _AmountEditWidgetState();
}

class _AmountEditWidgetState extends State<AmountEditWidget> {
  late Populations _populations;
  late List<TextEditingController> _amountControllers = [];
  late List<TextEditingController> _increaseControllers = [];

  static const double numberWidth = 30;
  static const double amountWidth = 150;
  static const double increaseCoeffWidth = 150;

  @override
  void initState() {
    super.initState();
    _populations = widget.populations;
    _amountControllers = List.generate(
      _populations.populations.length,
      (index) => TextEditingController(
          text: _populations.populations[index].initialAmount.toString()),
    );
    _increaseControllers = List.generate(
      _populations.populations.length,
      (index) => TextEditingController(
          text:
              _populations.populations[index].naturalIncreaseCoeff.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text('Amount'),
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: numberWidth,
                child: Text('#'),
              ),
            ),
            SizedBox(
              width: amountWidth,
              child: Text('Initial amount'),
            ),
            SizedBox(
              width: increaseCoeffWidth,
              child: Text('Natural Increase'),
            )
          ],
        ),
        for (int i = 0; i < _populations.populations.length; i++) ...[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: numberWidth,
                    child: Text(i.toString()),
                  ),
                ),
                SizedBox(
                  width: amountWidth,
                  child: TextField(
                    controller: _amountControllers[i],
                    onChanged: (value) {
                      if (value.isNotEmpty && double.tryParse(value) != null) {
                        _populations.populations[i].initialAmount =
                            double.parse(value);
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: increaseCoeffWidth,
                  child: TextField(
                    controller: _increaseControllers[i],
                    onChanged: (value) {
                      if (value.isNotEmpty && double.tryParse(value) != null) {
                        _populations.populations[i].naturalIncreaseCoeff =
                            double.parse(value);
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ]
      ],
    );
  }
}
