import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GhostAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function? onBack;
  final Function? onNext;
  final Function? onHome;

  const GhostAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onNext,
    this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      surfaceTintColor: AppColors.onPrimaryColorDark,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Consumer<ProviderAccount>(
                      builder: (_, providerAccount, child) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              providerAccount.currentModel?.displayName??"",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Container(
                              height: 24.h,
                              width: 24.h,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColorLight,
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: providerAccount.currentModel?.profilePic ?? "",
                                placeholder: (context, url) => const SizedBox(),
                                errorWidget: (context, url, error) => const SizedBox(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        onBack?.call();
                      },
                      icon: Icon(
                        Icons.arrow_left_sharp,
                        color: onBack==null? AppColors.primaryColorDark.withOpacity(.5): AppColors.primaryColorDark,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      iconSize: 20,
                      onPressed: () {
                        onHome?.call();
                      },
                      icon: Image.asset(
                        AppImages.iconHome,
                        height: 24.h,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onNext?.call();
                      },
                      icon: Icon(
                        Icons.arrow_right_sharp,
                        color: onNext==null? AppColors.primaryColorDark.withOpacity(.5): AppColors.primaryColorDark,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
