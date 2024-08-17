import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/ghost_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield_with_label.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenLocations extends StatelessWidget {
  const ScreenLocations({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: GhostAppBar(
        title: 'Locations',
        onBack: (){
          Navigator.pop(context);
        },
        onHome: (){
          Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
        },
        onNext: (){
          Navigator.pushNamed(
            context,
            Routes.settingsScreen,
          );
        },
      ),
      body: Background(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AdvanceTextFormFieldWithLabel(
                    hintText: "Search by ZIP Code",
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Use gps instead",
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Map api key is not found!",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
