import 'package:flutter/cupertino.dart';

import '/data/model/home/agents_model.dart';
import '../../../core/dummy_text.dart';
import '../../../router/route_names.dart';
import 'headline_text.dart';
import 'single_broker_agent_card_view.dart';

class PropertyAgentView extends StatelessWidget {
  const PropertyAgentView({Key? key, required this.agentsModel})
      : super(key: key);
  final AgentsModel agentsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadlineText(
            text: 'Property Agents',
            onTap: () => Navigator.pushNamed(
                context, RouteNames.allBrokerAgentListScreen)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(
              agentsModel.agents.length > 4 ? 5 : agentsModel.agents.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? 0.0 : 12.0,
                    right: index == brokerList.length - 1 ? 14.0 : 0.0),
                child: SingleBrokerAgentCartView(
                  agent: agentsModel.agents[index],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
