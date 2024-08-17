import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield_with_label.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/helpers/validation_helper.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenLoginByEmail extends StatefulWidget {
  const ScreenLoginByEmail({super.key});

  @override
  State<ScreenLoginByEmail> createState() => _ScreenLoginByEmailState();
}

class _ScreenLoginByEmailState extends State<ScreenLoginByEmail> {
  TextEditingController? _emailController, _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.onPrimaryColorDark,
        automaticallyImplyLeading: false,
        title: Text(
          "Login",
          style: theme.textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.appLogo,
                  height: 60.h,
                ),
                SizedBox(
                  height: 24.h,
                ),
                AdvanceTextFormFieldWithLabel(
                  hintText: "Email",
                  width: 400.w,
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (!ValidationHelper.isValidEmail(value)) {
                      return "* Invalid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                AdvanceTextFormFieldWithLabel(
                  width: 400.w,
                  hintText: "Password",
                  controller: _passwordController,
                ),
                SizedBox(
                  height: 32.h,
                ),
                Selector<ProviderAccount, ELoading?>(
                    builder: (_, loading, child) {
                      return loading == ELoading.submitButtonLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : BasicButton(
                        width: 160.w,
                        buttonText: "Login",
                        backgroundColor: AppColors.primaryColorDark.withOpacity(.5),
                        onPressed: () {
                          context.read<ProviderAccount>().loginByEmailAndPassword(
                            email: _emailController?.text ?? "",
                            password: _passwordController?.text ?? "",
                          );
                        },
                      );
                    },
                    selector: (_, providerAccount)=> providerAccount.loading)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
