import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/contact_us/contact_us_cubit.dart';
import '../../../../logic/cubit/contact_us/contact_us_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/error_text.dart';
import '../../../widget/primary_button.dart';

class ContactUsFormWidget extends StatelessWidget {
  const ContactUsFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 12.0);
    final contactUsCubit = context.read<ContactUsCubit>();
    return BlocListener<ContactUsCubit, ContactUsStateModel>(
      listener: (context, state) {
        final contact = state.contactUsState;
        if (contact is ContactUsMessageLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (contact is ContactUsMessageError) {
            Utils.errorSnackBar(context, contact.message);
          } else if (contact is ContactUsMessageLoad) {
            Navigator.pop(context);
            Utils.showSnackBar(context, contact.message);
            //contactUsCubit.clear();
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            BlocBuilder<ContactUsCubit, ContactUsStateModel>(
                builder: (_, state) {
              final s = state.contactUsState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                    onChanged: (String name) => contactUsCubit.nameChange(name),
                    initialValue: state.name,
                  ),
                  if (s is ContactUsMessageFormValidate) ...[
                    if (s.errors.name.isNotEmpty)
                      ErrorText(text: s.errors.name.first)
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<ContactUsCubit, ContactUsStateModel>(
                builder: (_, state) {
              final s = state.contactUsState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    onChanged: (String name) =>
                        contactUsCubit.emailChange(name),
                    initialValue: state.email,
                  ),
                  if (s is ContactUsMessageFormValidate) ...[
                    if (s.errors.email.isNotEmpty)
                      ErrorText(text: s.errors.email.first)
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<ContactUsCubit, ContactUsStateModel>(
                builder: (_, state) {
              final s = state.contactUsState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Subject',
                    ),
                    onChanged: (String name) =>
                        contactUsCubit.subjectChange(name),
                    initialValue: state.subject,
                  ),
                  if (s is ContactUsMessageFormValidate) ...[
                    if (s.errors.subject.isNotEmpty)
                      ErrorText(text: s.errors.subject.first)
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<ContactUsCubit, ContactUsStateModel>(
                builder: (_, state) {
              final s = state.contactUsState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Message',
                    ),
                    onChanged: (String name) =>
                        contactUsCubit.messageChange(name),
                    initialValue: state.message,
                  ),
                  if (s is ContactUsMessageFormValidate) ...[
                    if (s.errors.message.isNotEmpty)
                      ErrorText(text: s.errors.message.first)
                  ]
                ],
              );
            }),
            const SizedBox(height: 20.0),
            PrimaryButton(
                text: 'Send Message',
                onPressed: () {
                  Utils.closeKeyBoard(context);
                  contactUsCubit.sendContactUsMessage();
                  //contactUsCubit.clear();
                },
                textColor: blackColor,
                fontSize: 20.0,
                borderRadiusSize: radius,
                bgColor: yellowColor),
          ],
        ),
      ),
    );
  }
}
