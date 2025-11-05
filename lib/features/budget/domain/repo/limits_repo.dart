
import '../../data/entity/limits_entity.dart';


abstract class LimitsRepo {
  Future<void> saveMonthlyLimit(double monthlyLimit);
  Future<LimitsEntity> getLimits();
  Future<void> clearLimits();
}
