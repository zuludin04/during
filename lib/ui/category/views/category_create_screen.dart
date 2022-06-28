import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryCreateScreen extends StatefulWidget {
  const CategoryCreateScreen({Key? key}) : super(key: key);

  @override
  State<CategoryCreateScreen> createState() => _CategoryCreateScreenState();
}

class _CategoryCreateScreenState extends State<CategoryCreateScreen> {
  String categoryType = 'Saving';
  String categoryIcon = 'icon_wallet.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'Category',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: InputTextField(
                    title: 'name'.tr,
                    hint: 'name'.tr,
                    // onSaved: _controller.name,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () async {
                    var result = await Get.toNamed(RoutePath.categoryIcons);
                    if (result != null) {
                      setState(() {
                        categoryIcon = result;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffffa400),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(9),
                    child: SvgPicture.asset(
                      'assets/category/$categoryIcon',
                      color: const Color(0xff373a36),
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const HeaderText(title: 'Type', showTrailing: false),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: categoryType,
                  items: types
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    categoryType = value ?? "Saving";
                  }),
                  isExpanded: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
