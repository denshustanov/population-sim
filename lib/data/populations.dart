import 'package:population_sim/data/population.dart';
import 'package:population_sim/data/population_point.dart';

class Populations {
  List<Population> populations = [];
  List<List<double>> interactionMatrix = [];

  Populations(int amount) {
    populations = [];
    interactionMatrix = [];
    for (int i = 0; i < amount; i++) {
      populations.add(Population(100, [], i == 0 ? 0.01 : -0.01));
    }
    for (int i = 0; i < amount; i++) {
      List<double> row = [];
      for (int j = 0; j < amount; j++) {
        if (i == j) {
          row.add(0);
        } else if (j < i) {
          row.add(0.00001);
        } else {
          row.add(-0.00001);
        }
      }
      interactionMatrix.add(row);
    }
  }

  void calculateSeries(double timeStep, double simulationPeriod) {
    for (Population p in populations) {
      p.populationSeries = [PopulationPoint(p.initialAmount, 0)];
    }

    double time = 0;
    final int iterations = (simulationPeriod / timeStep).round();
    for (int i = 0; i < iterations - 1; i++) {
      time += timeStep;
      for (int j = 0; j < populations.length; j++) {
        double interactionValue = 0;
        for (int k = 0; k < populations.length; k++) {
          interactionValue += interactionMatrix[j][k] *
              populations[k].populationSeries[i].amount;
        }

        double newAmount = populations[j].populationSeries[i].amount *
            (1 +
                timeStep *
                    (populations[j].naturalIncreaseCoeff + interactionValue));
        newAmount = newAmount < 2 ? 0 : newAmount;
        populations[j].populationSeries.add(PopulationPoint(newAmount, time));
      }
    }
  }
}
