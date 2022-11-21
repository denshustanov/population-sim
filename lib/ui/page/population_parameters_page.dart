import 'package:flutter/material.dart';
import 'package:population_sim/data/populations.dart';
import 'package:population_sim/ui/dialog/new_system_dialog.dart';
import 'package:population_sim/ui/widget/amount_edit_widget.dart';
import 'package:population_sim/ui/widget/interaction_matrix_widget.dart';

class PopulationParametersPage extends StatefulWidget {
  PopulationParametersPage({required this.populations, Key? key})
      : super(key: key);
  final Populations populations;

  @override
  State<PopulationParametersPage> createState() =>
      _PopulationParametersPageState();
}

class _PopulationParametersPageState extends State<PopulationParametersPage> {
  late Populations _populations;

  @override
  void initState() {
    super.initState();
    _populations = widget.populations;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _populations);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Populations params'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AmountEditWidget(populations: _populations),
              InteractionMatrixWidget(populations: _populations),
            ],
          ),
        ),
      ),
    );
  }
}
