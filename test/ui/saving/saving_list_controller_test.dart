import 'package:during/data/during_repository.dart';
import 'package:during/data/during_repository_impl.dart';
import 'package:during/ui/saving/controllers/saving_manage_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/dummy_data.dart';

class MockRepository extends Mock implements DuringRepositoryImpl {}

void main() {
  late MockRepository repository;
  late SavingManageController controller;

  setUpAll(() {
    repository = MockRepository();
    Get.put<DuringRepository>(repository);
  });

  group('testing load saving list from db', () {
    test('load all saving success', () async {
      controller = SavingManageController();

      when(() => repository.loadSaving()).thenAnswer((_) async => mockSavings);

      Get.put<SavingManageController>(controller);
      await controller.loadSavings();

      var actual = controller.savings;
      var matcher = mockSavings;

      expect(actual, matcher);
      expect(actual.length, matcher.length);
      expect(controller.savings.isEmpty, isFalse);
    });

    test('load savings with empty result', () async {
      controller = SavingManageController();

      when(() => repository.loadSaving()).thenAnswer((_) async => []);

      Get.put<SavingManageController>(controller);
      await controller.loadSavings();

      var actual = controller.savings;
      var matcher = [];

      expect(actual, matcher);
      expect(controller.savings.isEmpty, isTrue);
    });
  });
}
