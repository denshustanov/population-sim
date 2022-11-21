import 'package:population_sim/data/population_point.dart';

class Population {
  double initialAmount;
  List<PopulationPoint> populationSeries = [];
  double naturalIncreaseCoeff;

  Population(
    this.initialAmount,
    this.populationSeries,
    this.naturalIncreaseCoeff,
  );
}
