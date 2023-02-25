import 'package:during/data/during_repository.dart';
import 'package:during/data/during_repository_impl.dart';
import 'package:during/data/source/during_db_provider.dart';
import 'package:get/get.dart';

class RepositoryService extends GetxService {
  @override
  void onInit() {
    super.onInit();
    initRepository();
  }

  void initRepository() {
    Get.lazyPut(() => DuringDbProvider());

    Get.put<DuringRepository>(DuringRepositoryImpl(Get.find()));
  }
}
