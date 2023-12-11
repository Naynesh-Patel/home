import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/model/product/property_choose_model.dart';

import '../../../data/model/create_property/create_property_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/property_repository.dart';

part 'create_info_state.dart';

class CreateInfoCubit extends Cubit<CreateInfoState> {
  final PropertyRepository _repository;
  final LoginBloc _loginBloc;

  CreateInfoCubit(
      {required PropertyRepository repository, required LoginBloc loginBloc})
      : _repository = repository,
        _loginBloc = loginBloc,
        super(CreateInfoInitial()) {
    getCreateInfo('rent');
  }

  late CreatePropertyInfo createPropertyInfo;
  PropertyChooseModel? chooseProperty;

  Future<void> getCreateInfo(String purpose) async {
    emit(CreateInfoLoading());

    final result = await _repository.getPropertyCreateInfo(
        _loginBloc.userInfo!.accessToken, purpose);
    result.fold((failuer) {
      emit(CreateInfoError(
          error: failuer.message, statusCode: failuer.statusCode));
    }, (data) {
      createPropertyInfo = data;
      print("check ${createPropertyInfo.requestPurpose}");
      emit(CreateInfoLoaded(infoData: data));
    });
  }

  Future<void> getPropertyChooseInfo() async {
    emit(CreateInfoLoading());
    final result = await _repository
        .getPropertyChooseInfo(_loginBloc.userInfo!.accessToken);
    result.fold((failure) {
      emit(CreateInfoError(
          error: failure.message, statusCode: failure.statusCode));
    }, (data) {
      chooseProperty = data;
      emit(PropertyChooseInfoLoaded(data));
    });
  }
}
