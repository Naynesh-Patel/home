import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/model/agent/agent_details_model.dart';
import '/data/model/agent/agent_list_model.dart';
import '/data/model/auth/auth_error_model.dart';
import '../../../presentation/error/failure.dart';
import '../../repository/agent_repository.dart';
import 'agent_state_model.dart';

part 'agent_state.dart';

class AgentCubit extends Cubit<AgentStateModel> {
  final AgentRepository _agentRepository;

  AgentCubit({
    required AgentRepository agentRepository,
  })  : _agentRepository = agentRepository,
        super(const AgentStateModel());

  void nameChange(String text) {
    emit(state.copyWith(name: text, agentState: const AgentInitial()));
  }

  void emailChange(String text) {
    emit(state.copyWith(email: text, agentState: const AgentInitial()));
  }

  void agentEmailChange(String text) {
    emit(state.copyWith(agentEmail: text, agentState: const AgentInitial()));
  }

  void subjectChange(String text) {
    emit(state.copyWith(subject: text, agentState: const AgentInitial()));
  }

  void messageChange(String text) {
    emit(state.copyWith(message: text, agentState: const AgentInitial()));
  }

  AgentListModel? agents;
  AgentDetailsModel? agentDetailsModel;

  Future<void> getAllAgent() async {
    emit(state.copyWith(agentState: AgentLoading()));
    final result = await _agentRepository.getAllAgent();
    result.fold((failure) {
      emit(state.copyWith(
          agentState: AgentError(failure.message, failure.statusCode)));
    }, (success) {
      agents = success;
      emit(state.copyWith(agentState: AgentLoaded(success)));
    });
  }

  Future<void> getAgentDetails(String userName) async {
    emit(state.copyWith(agentState: AgentDetailsLoading()));
    // final Map<String, String> param = {
    //   'agent_type': 'agent',
    //   'user_name': userName
    // };
    final result = await _agentRepository.getAgentDetails(userName);
    result.fold((failure) {
      emit(state.copyWith(
          agentState: AgentDetailsError(failure.message, failure.statusCode)));
    }, (success) {
      agentDetailsModel = success;
      emit(state.copyWith(agentState: AgentDetailsLoaded(success)));
    });
  }

  Future<void> sendMessageToAgent() async {
    emit(state.copyWith(agentState: AgentSendMessageLoading()));
    print('messages: $state');
    final result = await _agentRepository.sendMessageToAgent(state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = AgentSendMessageFormValidate(failure.errors);
        emit(state.copyWith(agentState: errors));
      } else {
        emit(state.copyWith(
            agentState:
                AgentSendMessageError(failure.message, failure.statusCode)));
      }
    }, (message) {
      emit(state.copyWith(agentState: AgentSendMessageLoad(message)));
      emit(state.clear());
    });
  }
}
