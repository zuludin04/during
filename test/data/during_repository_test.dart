import 'package:during/data/source/during_db_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'during_repository_test.mocks.dart';
import 'fake_during_repository.dart';

@GenerateMocks([DuringDbProvider])
void main() {
  var dbProvider = MockDuringDbProvider();
  var repository = FakeDuringRepository(dbProvider);

  group('test daily expense and income', () {
    test('load daily expense', () async {
      when(dbProvider.totalExpense(1, 3)).thenAnswer((_) async => 10);

      repository.countTotalExpense(1, 3);

      verify(repository.countTotalExpense(1, 3));
      expect(await repository.countTotalExpense(1, 3), 10);
    });

    test('load daily income', () async {
      when(dbProvider.totalIncome(1, 5)).thenAnswer((_) async => 100);

      repository.countTotalIncome(1, 5);

      verify(repository.countTotalIncome(1, 5));
      expect(await repository.countTotalIncome(1, 5), 100);
    });
  });
}
