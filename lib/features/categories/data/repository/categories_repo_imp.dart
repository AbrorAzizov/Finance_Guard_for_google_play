import 'package:finance_guard/features/categories/domain/repo/categories_repo.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/default_icons.dart';
import '../../domain/model/categories_model.dart';
import '../entity/category_entity.dart';

class CategoriesRepoImp implements CategoriesRepo {
  final Box<CategoryModel> box;

  CategoriesRepoImp({required this.box});


  @override
  Future<void> addDefaultCategories() async {
    final categories = defaultCategories;

    for (final category in categories) {
      final exists = box.values.any((element) => element.name == category.name);
      if (!exists) {
        await box.put(category.id, CategoryModel.fromEntity(category));
      }
    }
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    return box.values.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> deleteCategory(String id) async {
    await box.delete(id);
  }

  @override
  Future<void> editCategory(CategoryEntity updatedCategory) async {
    await box.put(updatedCategory.id, CategoryModel.fromEntity(updatedCategory));
  }

  @override
  Future<void> addCategory(CategoryEntity category) async {
    final alreadyExists = box.values.any((c) => c.name == category.name);
    if (!alreadyExists) {
      await box.put(category.id, CategoryModel.fromEntity(category));
    }
  }
}
