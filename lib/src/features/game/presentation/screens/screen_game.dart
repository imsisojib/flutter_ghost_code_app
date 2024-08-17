import 'package:ar_location_view/ar_location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/stroke_button.dart';
import 'package:flutter_boilerplate_code/src/features/game/data/annotations.dart';
import 'package:flutter_boilerplate_code/src/features/game/presentation/screens/widgets/annotations_view.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

class ScreenGame extends StatefulWidget {
  const ScreenGame({super.key});

  @override
  State<ScreenGame> createState() => _ScreenGameState();
}

class _ScreenGameState extends State<ScreenGame> {
  List<Annotation> annotations = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Background(
        child: Row(
          children: [
            SizedBox(
              width: 150.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 32.h,
                  ),
                  Image.asset(
                    AppImages.emfMeter,
                    height: 120.h,
                    width: 120.h,
                  ),
                  Image.asset(
                    AppImages.demoWaveForm,
                    height: 120.h,
                    width: 120.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorLight.withOpacity(.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Text(
                          "Record",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorLight.withOpacity(.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Text(
                          "Save",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ArLocationWidget(
                annotations: annotations,
                showDebugInfoSensor: false,
                annotationWidth: MediaQuery.of(context).size.width,
                annotationHeight: MediaQuery.of(context).size.height,
                radarPosition: RadarPosition.bottomCenter,
                annotationViewBuilder: (context, annotation) {
                  // return AnnotationView(
                  //   key: ValueKey(annotation.uid),
                  //   annotation: annotation as Annotation,
                  // );
                  return Image.asset(
                    "assets/gifs/skeleton_ghost.gif",
                    fit: BoxFit.cover,
                  );
                },
                radarWidth: 160,
                scaleWithDistance: false,
                onLocationChange: (Position position) {
                  Future.delayed(const Duration(seconds: 5), () {
                    annotations = fakeAnnotation(position: position, numberMaxPoi: 1);
                    setState(() {});
                  });
                },
              ),
            ),
            SizedBox(
              width: 150.w,
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Image.asset(
                      AppImages.ad1,
                      height: 110.h,
                      width: 110.h,
                    ),
                    Image.asset(
                      AppImages.ad2,
                      height: 110.h,
                      width: 110.h,
                    ),
                    Image.asset(
                      AppImages.appLogo,
                      height: 70,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                      ),
                      child: StrokeButton(
                        height: 36,
                        borderRadius: 20,
                        strokeColor: AppColors.red,
                        strokeWidth: 2,
                        width: 140.w,
                        buttonText: "END TOUR",
                        buttonTextStyle: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: AppColors.green.withOpacity(.6),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
