import 'package:flutter/material.dart';

import '../../data/populations.dart';

class NewSystemDialog extends StatefulWidget {
  const NewSystemDialog({Key? key}) : super(key: key);

  @override
  State<NewSystemDialog> createState() => _NewSystemDialogState();
}

class _NewSystemDialogState extends State<NewSystemDialog> {
  final TextEditingController _amountController = TextEditingController(text: '2');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New system'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.all(8.0), child:
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
            ),)
        ],
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: const Text('Cancel')),
        TextButton(onPressed: (){
          Navigator.of(context).pop(Populations(int.parse(_amountController.text)));
        }, child: const Text('Ok')),
      ],
    );
  }
}
