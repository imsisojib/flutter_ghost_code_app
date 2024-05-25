import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield_with_label.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ScreenSignupComplete extends StatefulWidget {
  const ScreenSignupComplete({super.key});

  @override
  State<ScreenSignupComplete> createState() => _ScreenSignupCompleteState();
}

class _ScreenSignupCompleteState extends State<ScreenSignupComplete> {
  TextEditingController? _displayNameController, _ageController, _genderController;
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _displayNameController = TextEditingController();
    _ageController = TextEditingController();
    _genderController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _displayNameController?.dispose();
    _ageController?.dispose();
    _genderController?.dispose();
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
          "Setup",
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
          child: Row(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AdvanceTextFormFieldWithLabel(
                        hintText: "Display name",
                        controller: _displayNameController,
                        maxLength: 30,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "* Display name can't be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      AdvanceTextFormFieldWithLabel(
                        hintText: "Age",
                        controller: _ageController,
                        maxLength: 2,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      AdvanceTextFormFieldWithLabel(
                        hintText: "Gender",
                        controller: _genderController,
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
                                    buttonText: "Save",
                                    backgroundColor: AppColors.primaryColorDark.withOpacity(.5),
                                    onPressed: () {
                                      if(!_formKey.currentState!.validate()){
                                        Fluttertoast.showToast(msg: "Please check your inputs!");
                                        return;
                                      }

                                      int? age = int.tryParse(_ageController?.text??"");

                                      context.read<ProviderAccount>().completeSignup(
                                        displayName: _displayNameController?.text??"",
                                        age: age,
                                        gender: _genderController?.text??""
                                      );
                                    },
                                  );
                          },
                          selector: (_, providerAccount) => providerAccount.loading)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Upload photo or choose your avatar",
                      style: theme.textTheme.labelSmall,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CircleAvatar(
                      radius: 40.w,
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                      ),
                      itemCount: 8,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (_, index) {
                        return SizedBox(
                          height: 45.h,
                          width: 45.h,
                          child: Image.asset(AppImages.demoAvatar),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
