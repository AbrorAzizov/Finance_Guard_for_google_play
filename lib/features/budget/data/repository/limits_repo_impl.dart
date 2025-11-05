import 'package:finance_guard/features/budget/data/entity/limits_entity.dart';
import 'package:hive/hive.dart';

import '../../domain/model/limit/limits_model.dart';
import '../../domain/repo/limits_repo.dart';


class LimitsRepoImpl implements LimitsRepo {
  final Box<LimitsModel> box;

  LimitsRepoImpl({required this.box});

  @override
  Future<void> saveMonthlyLimit(double monthlyLimit) async {
    final model = LimitsModel(monthlyLimit: monthlyLimit);
    await box.put('limits', model); 
  }

  @override
  Future<LimitsEntity> getLimits() async {
    final model = box.get('limits');
    if (model != null) {
      return model.toEntity();
    } else {
      return LimitsEntity(monthlyLimit: 0);
    }
  }


  @override
  Future<void> clearLimits() async {
    await box.delete('limits');
  }
}
