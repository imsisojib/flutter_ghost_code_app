import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield_with_label.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/request_bodys/requestbody_purchased_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/presentation/providers/provider_game_events.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/requstbody/requestbody_checkout.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/providers/provider_merchandise.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DialogPurchaseTickets extends StatefulWidget {
  const DialogPurchaseTickets({
    super.key,
  });

  @override
  State<DialogPurchaseTickets> createState() => _DialogPurchaseTicketsState();
}

class _DialogPurchaseTicketsState extends State<DialogPurchaseTickets> {
  TextEditingController? customerNameController, phoneNumberController, addressController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    customerNameController = TextEditingController();
    customerNameController?.text =
        "${context.read<ProviderAccount>().currentModel?.firstName ?? ""} ${context.read<ProviderAccount>().currentModel?.lastName ?? ""}";
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ProviderGameEvents>(builder: (_, providerGameEvents, child) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Checkout",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total"),
                  Text(
                    "\$${providerGameEvents.calculateSelectedTicketsTotal()}",
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              AdvanceTextFormFieldWithLabel(
                controller: customerNameController,
                hintText: "Customer Name",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Name can't be empty!";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              AdvanceTextFormFieldWithLabel(
                controller: phoneNumberController,
                hintText: "Phone Number",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Phone number can't be empty!";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              AdvanceTextFormFieldWithLabel(
                controller: addressController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: "Address",
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Address can't be empty!";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 24.h,
              ),
              providerGameEvents.loading == ELoading.submitButtonLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : BasicButton(
                      backgroundColor: const Color(0xffAD9898).withOpacity(.6),
                      buttonText: "Purchase Now",
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        if (providerGameEvents.event?.id == null || context.read<ProviderAccount>().currentModel?.uid == null) {
                          //event id or current user id is null
                          Fluttertoast.showToast(msg: "Something is went wrong. Please try again later.");
                          return;
                        }

                        RequestBodyPurchasedTickets request = RequestBodyPurchasedTickets(
                          total: providerGameEvents.calculateSelectedTicketsTotal(),
                          customerName: customerNameController?.text ?? "",
                          phoneNumber: phoneNumberController?.text ?? "",
                          address: addressController?.text ?? "",
                          ticketIds: providerGameEvents.selectedTickets.map((e) => e.id!).toList(),
                          userId: context.read<ProviderAccount>().currentModel!.uid!,
                          eventId: providerGameEvents.event!.id!,
                        );

                        providerGameEvents.purchaseTickets(request);
                      },
                    ),
            ],
          ),
        ),
      );
    });
  }
}
