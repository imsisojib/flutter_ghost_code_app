import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield_with_label.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/helpers/validation_helper.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ScreenSignup extends StatefulWidget {
  const ScreenSignup({super.key});

  @override
  State<ScreenSignup> createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  TextEditingController? _firstNameController, _lastNameController, _emailController, _passwordController, _confirmPasswordController;
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController?.dispose();
    _lastNameController?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    _confirmPasswordController?.dispose();
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
          "Sign up",
          style: theme.textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Background(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 70.w,
            vertical: 32.h,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AdvanceTextFormFieldWithLabel(
                          hintText: "First name",
                          controller: _firstNameController,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: AdvanceTextFormFieldWithLabel(
                          hintText: "Last name",
                          controller: _lastNameController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  AdvanceTextFormFieldWithLabel(
                    hintText: "Email",
                    width: MediaQuery.of(context).size.width,
                    controller: _emailController,
                    validator: (String? value) {
                      if (!ValidationHelper.isValidEmail(value)) return "* Invalid email";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AdvanceTextFormFieldWithLabel(
                          hintText: "Password",
                          controller: _passwordController,
                          validator: (String? value) {
                            if ((value?.length ?? 0) < 8) return "* Password requires minimum of 8 digits";
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: AdvanceTextFormFieldWithLabel(
                          hintText: "Confirm password",
                          controller: _confirmPasswordController,
                          validator: (String? value) {
                            if (value != _passwordController?.text) return "* Password doesn't match";
                            return null;
                          },
                        ),
                      ),
                    ],
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
                                buttonText: "Join",
                                backgroundColor: AppColors.primaryColorDark.withOpacity(.5),
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    Fluttertoast.showToast(msg: 'Please check your inputs!');
                                    return;
                                  }

                                  context.read<ProviderAccount>().createUserByEmailAndPassword(
                                        firstName: _firstNameController?.text??"",
                                        lastName: _lastNameController?.text??"",
                                        email: _emailController?.text??"",
                                        password: _passwordController?.text??"",
                                      );
                                },
                              );
                      },
                      selector: (_, providerAccount) => providerAccount.loading),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
