import 'package:during/data/during_repository.dart';
import 'package:during/data/during_repository_impl.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/ui/transaction/controllers/transaction_detail_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/dummy_data.dart';

class MockRepository extends Mock implements DuringRepositoryImpl {}

void main() {
  late MockRepository repository;
  late TransactionDetailController controller;

  setUpAll(() {
    repository = MockRepository();
    Get.put<DuringRepository>(repository);
  });

  test('load saving data to show transaction saving', () async {
    TransactionEntity entity = TransactionEntity(id: 1);
    controller = TransactionDetailController(entity, 'normal');

    when(() => repository.loadSingleSaving(any()))
        .thenAnswer((_) async => mockSavings[0]);

    Get.put<TransactionDetailController>(controller);
    await controller.loadTransactionSaving(1);

    var actual = controller.saving;
    var matcher = mockSavings[0];
    expect(actual, matcher);
    expect(actual.id, matcher.id);
  });
}
