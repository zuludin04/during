import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/input_section.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/category/controllers/category_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryCreateScreen extends StatefulWidget {
  const CategoryCreateScreen({super.key});

  @override
  State<CategoryCreateScreen> createState() => _CategoryCreateScreenState();
}

class _CategoryCreateScreenState extends State<CategoryCreateScreen> {
  final CategoryCreateController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'category'.tr,
        actions: [
          IconButton(
            onPressed: () {
              _formKey.currentState!.save();
              _controller.insertCategory();
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: InputTextField(
                      title: 'name'.tr,
                      hint: 'name'.tr,
                      text: _controller.name.value,
                      onSaved: _controller.name,
                      enableValidation: false,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: InputSection(
                          title: 'type'.tr,
                          child: DropdownButtonHideUnderline(
                            child: Obx(() {
                              return DropdownButton<String>(
                                value: _controller.type.value,
                                items: types
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) =>
                                    _controller.type.value = value ?? "Saving",
                                isExpanded: true,
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: InputSection(
                          title: 'color'.tr,
                          child: DropdownButtonHideUnderline(
                            child: Obx(() {
                              return DropdownButton<String>(
                                value: _controller.color.value,
                                items: categoryColors
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 72,
                                              decoration: BoxDecoration(
                                                color:
                                                    Color(int.parse('0xff$e')),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  _controller.color.value = value ?? "F44336";
                                },
                                isExpanded: true,
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Obx(() {
                        return InputSection(
                          title: 'icon'.tr,
                          child: InkWell(
                            onTap: () async {
                              var result = await Get.toNamed(
                                  RoutePath.categoryIcons,
                                  arguments: {
                                    'icon': _controller.icon.value,
                                    'color': _controller.color.value,
                                  });
                              if (result != null) {
                                _controller.icon.value = result;
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: SvgPicture.asset(
                                'assets/category/${_controller.icon.value}',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).iconTheme.color!,
                                  BlendMode.srcIn,
                                ),
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: _controller.isUpdate,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'delete_category_title'.tr,
                            content: Text(
                              'delete_category_message'.tr,
                              textAlign: TextAlign.center,
                            ),
                            confirm: TextButton(
                              onPressed: () {
                                Get.back();
                                _controller.deleteCategory();
                              },
                              child: Text(
                                'ok'.tr,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                            cancel: TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                'cancel'.tr,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.delete_outlined,
                              color: Colors.red,
                            ),
                            Text(
                              'delete'.tr,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
