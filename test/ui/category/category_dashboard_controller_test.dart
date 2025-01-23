import 'package:during/data/during_repository.dart';
import 'package:during/data/during_repository_impl.dart';
import 'package:during/ui/category/controllers/category_dashboard_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/dummy_data.dart';

class MockRepository extends Mock implements DuringRepositoryImpl {}

void main() {
  late CategoryDashboardController controller;
  late MockRepository repo;

  setUpAll(() {
    repo = MockRepository();
    Get.put<DuringRepository>(repo);
  });

  group('test load category items by their type', () {
    test('load income category', () async {
      controller = CategoryDashboardController();

      when(() => repo.loadCategories())
          .thenAnswer((_) async => mockCagoriesWithType);

      Get.put<CategoryDashboardController>(controller);
      await controller.loadCategory();

      var actual = controller.incomeCategory;
      var matcher = mockCagoriesWithType.where((element) => element.type == 2);
      expect(actual, matcher);
      expect(actual.length, matcher.length);
      expect(actual.isNotEmpty, isTrue);
    });

    test('load expense category', () async {
      controller = CategoryDashboardController();

      when(() => repo.loadCategories())
          .thenAnswer((_) async => mockCagoriesWithType);

      Get.put<CategoryDashboardController>(controller);
      await controller.loadCategory();

      var actual = controller.expenseCategory;
      var matcher = mockCagoriesWithType.where((element) => element.type == 3);
      expect(actual, matcher);
      expect(actual.length, matcher.length);
      expect(actual.isNotEmpty, isTrue);
    });

    test('load saving category', () async {
      controller = CategoryDashboardController();

      when(() => repo.loadCategories())
          .thenAnswer((_) async => mockCagoriesWithType);

      Get.put<CategoryDashboardController>(controller);
      await controller.loadCategory();

      var actual = controller.savingCategory;
      var matcher = mockCagoriesWithType.where((element) => element.type == 1);
      expect(actual, matcher);
      expect(actual.length, matcher.length);
      expect(actual.isNotEmpty, isTrue);
    });
  });
}
