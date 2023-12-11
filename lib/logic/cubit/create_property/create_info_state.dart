part of 'create_info_cubit.dart';

abstract class CreateInfoState extends Equatable {
  const CreateInfoState();

  @override
  List<Object> get props => [];
}

class CreateInfoInitial extends CreateInfoState {}

class CreateInfoLoading extends CreateInfoState {}

class CreateInfoError extends CreateInfoState {
  final String error;
  final int statusCode;

  const CreateInfoError({required this.error, required this.statusCode});

  @override
  List<Object> get props => [error];
}

class CreateInfoLoaded extends CreateInfoState {
  final CreatePropertyInfo infoData;

  const CreateInfoLoaded({required this.infoData});

  @override
  List<Object> get props => [infoData];
}

class PropertyChooseInfoLoaded extends CreateInfoState {
  final PropertyChooseModel chooseProperty;

  const PropertyChooseInfoLoaded(this.chooseProperty);

  @override
  List<Object> get props => [chooseProperty];
}
