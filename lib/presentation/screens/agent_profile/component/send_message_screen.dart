import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/logic/cubit/agent/agent_cubit.dart';
import '/logic/cubit/agent/agent_state_model.dart';
import '/presentation/widget/custom_app_bar.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/error_text.dart';
import '../../../widget/loading_widget.dart';
import '../../../widget/primary_button.dart';

class SendMessageScreen extends StatelessWidget {
  const SendMessageScreen({Key? key, required this.agentEmail})
      : super(key: key);
  final _className = "SendMessageScreen";
  final String agentEmail;

  @override
  Widget build(BuildContext context) {
    final agentCubit = context.read<AgentCubit>();
    const spacer = SizedBox(height: 12.0);
    print('email $agentEmail');
    agentCubit.agentEmailChange(agentEmail);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(title: 'Send Message'),
      body: BlocListener<AgentCubit, AgentStateModel>(
        listener: (_, state) {
          final agent = state.agentState;
          if (agent is AgentSendMessageLoading) {
            log(_className, name: agent.toString());
          } else if (agent is AgentSendMessageError) {
            Utils.errorSnackBar(context, agent.message);
          } else if (agent is AgentSendMessageLoad) {
            Navigator.of(context).pop();
            Utils.showSnackBar(context, agent.message);
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const CustomTextStyle(
            //       text: 'Write Message',
            //       fontWeight: FontWeight.w600,
            //       fontSize: 18.0,
            //       color: blackColor,
            //     ),
            //     GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).pop();
            //           print('cancelll');
            //         },
            //         child: const CustomImage(path: KImages.cancelIcon))
            //   ],
            // ),
            // const SizedBox(height: 14.0),
            BlocBuilder<AgentCubit, AgentStateModel>(builder: (_, state) {
              final s = state.agentState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                    onChanged: (String name) => agentCubit.nameChange(name),
                    initialValue: state.name,
                  ),
                  if (s is AgentSendMessageFormValidate) ...[
                    if (s.errors.name.isNotEmpty)
                      ErrorText(text: s.errors.name.first)
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<AgentCubit, AgentStateModel>(builder: (_, state) {
              final s = state.agentState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    onChanged: (String name) => agentCubit.emailChange(name),
                    initialValue: state.email,
                  ),
                  if (s is AgentSendMessageFormValidate) ...[
                    if (s.errors.email.isNotEmpty)
                      ErrorText(text: s.errors.email.first)
                  ]
                ],
              );
            }),
            // spacer,
            // BlocBuilder<AgentCubit, AgentStateModel>(builder: (_, state) {
            //   final s = state.agentState;
            //   return Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       TextFormField(
            //         decoration: const InputDecoration(
            //           hintText: 'Agent Email',
            //         ),
            //         onChanged: (String name) =>
            //             agentCubit.agentEmailChange(name),
            //         initialValue: state.agentEmail,
            //       ),
            //       if (s is AgentSendMessageFormValidate) ...[
            //         if (s.errors.agentEmail.isNotEmpty)
            //           ErrorText(text: s.errors.agentEmail.first)
            //       ]
            //     ],
            //   );
            // }),
            spacer,
            BlocBuilder<AgentCubit, AgentStateModel>(builder: (_, state) {
              final s = state.agentState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Subject',
                    ),
                    onChanged: (String name) => agentCubit.subjectChange(name),
                    initialValue: state.subject,
                  ),
                  if (s is AgentSendMessageFormValidate) ...[
                    if (s.errors.subject.isNotEmpty)
                      ErrorText(text: s.errors.subject.first)
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<AgentCubit, AgentStateModel>(builder: (_, state) {
              final s = state.agentState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLines: 6,
                    decoration: const InputDecoration(
                      hintText: 'Message',
                    ),
                    onChanged: (String name) => agentCubit.messageChange(name),
                    initialValue: state.message,
                  ),
                  if (s is AgentSendMessageFormValidate) ...[
                    if (s.errors.message.isNotEmpty)
                      ErrorText(text: s.errors.message.first)
                  ]
                ],
              );
            }),
            const SizedBox(height: 20.0),
            BlocBuilder<AgentCubit, AgentStateModel>(
              builder: (context, state) {
                final s = state.agentState;
                if (s is AgentSendMessageLoading) {
                  return const LoadingWidget();
                }
                return PrimaryButton(
                    text: 'Send Message',
                    onPressed: () {
                      Utils.closeKeyBoard(context);
                      agentCubit.sendMessageToAgent();
                    },
                    textColor: blackColor,
                    fontSize: 20.0,
                    borderRadiusSize: radius,
                    bgColor: yellowColor);
              },
            )
          ],
        ),
      ),
    );
  }
}
