import 'package:flutter/material.dart';
import 'package:population_sim/ui/dialog/calculate_system_dialog.dart';
import 'package:population_sim/ui/page/population_parameters_page.dart';
import 'package:charts_flutter/flutter.dart';
import '../../data/population.dart';
import '../../data/population_point.dart';
import '../../data/populations.dart';
import '../dialog/new_system_dialog.dart';

class PopulationChartPage extends StatefulWidget {
  const PopulationChartPage({Key? key}) : super(key: key);

  @override
  State<PopulationChartPage> createState() => _PopulationChartPageState();
}

class _PopulationChartPageState extends State<PopulationChartPage> {
  Populations _populations = Populations(2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Populations chart'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('System parameters'),
                      onTap: () =>
                          Future.delayed(const Duration(seconds: 0), () {
                        _parametersActionHandler();
                      }),
                    ),
                    PopupMenuItem(
                      child: const Text('New system'),
                      onTap: () =>
                          Future.delayed(const Duration(seconds: 0), () {
                        _newSystemHandler();
                      }),
                    ),
                    PopupMenuItem(
                      child: const Text('Calculate series'),
                      onTap: () => Future.delayed(const Duration(seconds: 0),
                          () => calculateSystemHandler()),
                    ),
                  ])
        ],
      ),
      body: LineChart(
        createSeriesList(),
        animate: true,
      ),
    );
  }

  Future<void> _parametersActionHandler() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PopulationParametersPage(
          populations: _populations,
        ),
      ),
    );
  }

  Future<void> _newSystemHandler() async {
    final Populations? newPopulations = await showDialog(
        context: context, builder: (context) => const NewSystemDialog());
    if (newPopulations != null) {
      _populations = newPopulations;
      _parametersActionHandler();
    }
  }

  List<Series<PopulationPoint, double>> createSeriesList() {
    List<Series<PopulationPoint, double>> seriesList = [];
    for (int i = 0; i < _populations.populations.length; i++) {
      seriesList.add(
        Series(
            id: i.toString(),
            data: _populations.populations[i].populationSeries,
            domainFn: (PopulationPoint point, _) => point.time,
            measureFn: (PopulationPoint point, _) => point.amount),
      );
    }
    return seriesList;
  }

  Future<void> calculateSystemHandler() async {
    await showDialog(
      context: context,
      builder: (context) => CalculateSystemDialog(populations: _populations),
    );
    setState(() {});
  }
}
