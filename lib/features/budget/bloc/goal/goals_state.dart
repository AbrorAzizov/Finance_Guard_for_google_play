
import 'package:finance_guard/features/budget/data/entity/limits_entity.dart';

import '../../data/entity/goal_entity.dart';


abstract class GoalsState {}

class GoalsInitial extends GoalsState {}

class GoalsLoading extends GoalsState {}

class GoalsLoaded extends GoalsState {
  final List<GoalEntity> goals;
  final LimitsEntity limitsEntity;
  GoalsLoaded(this.goals, this.limitsEntity);
}

class GoalsError extends GoalsState {
  final String message;
  GoalsError(this.message);
}
