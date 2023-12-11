import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/logic/cubit/agent/agent_cubit.dart';
import '/presentation/widget/custom_test_style.dart';
import '/presentation/widget/loading_widget.dart';
import '../../../../data/model/auth/user_profile_model.dart';
import '../../../../logic/cubit/agent/agent_state_model.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_app_bar.dart';
import 'single_broker_agent_card_view.dart';

class AllBrokerAgentListScreen extends StatelessWidget {
  const AllBrokerAgentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final agentListCubit = context.read<AgentCubit>();
    agentListCubit.getAllAgent();
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: CustomAppBar(
        title:
            agentListCubit.agents!.seoSetting!.pageName ?? 'All Broker Agent',
      ),
      body: BlocBuilder<AgentCubit, AgentStateModel>(
        builder: (context, state) {
          final agent = state.agentState;
          if (agent is AgentLoading) {
            return const LoadingWidget();
          } else if (agent is AgentError) {
            if (agent.statusCode == 503) {
              return LoadedAgentList(agents: agentListCubit.agents!.agents!);
            } else {
              return Center(
                child: CustomTextStyle(
                  text: agent.message,
                  color: redColor,
                ),
              );
            }
          }

          // else if (state is AgentListLoaded) {
          //   return LoadedAgentList(agents: state.agents.agents!);
          // }
          return LoadedAgentList(agents: agentListCubit.agents!.agents!);
        },
      ),
    );
  }
}

class LoadedAgentList extends StatelessWidget {
  const LoadedAgentList({Key? key, required this.agents}) : super(key: key);
  final List<UserProfileModel> agents;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: agents.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
            .copyWith(bottom: 40.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            crossAxisCount: 2,
            mainAxisExtent: 225.0),
        itemBuilder: (context, index) =>
            SingleBrokerAgentCartView(agent: agents[index]));
  }
}
