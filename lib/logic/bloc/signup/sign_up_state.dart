part of 'sign_up_bloc.dart';

class SignUpModelState extends Equatable {
  final int agree;
  final String name;
  final String email;
  final String phone;
  final String countryCode;
  final String password;
  final String passwordConfirmation;
  final SignUpState state;

  const SignUpModelState({
    this.agree = 0,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.countryCode = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.state = const SignUpStateInitial(),
  });

  SignUpModelState copyWith({
    int? agree,
    String? name,
    String? email,
    String? phone,
    String? countryCode,
    String? password,
    String? passwordConfirmation,
    SignUpState? state,
  }) {
    return SignUpModelState(
      agree: agree ?? this.agree,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      countryCode: countryCode ?? this.countryCode,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'agree': agree.toString()});
    result.addAll({'name': name.trim()});
    result.addAll({'email': email.trim()});
    result.addAll({'phone': countryCode + phone.trim()});
    result.addAll({'password': password});
    result.addAll({'password_confirmation': passwordConfirmation});

    return result;
  }

  SignUpModelState clear() {
    return const SignUpModelState(
      agree: 0,
      name: '',
      email: '',
      phone: '',
      countryCode: '',
      password: '',
      passwordConfirmation: '',
      state: SignUpStateInitial(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SignUpModelState(agree: $agree, name: $name, email: $email, phone: $phone, countryCode: $countryCode, password: $password, passwordConfirmation: $passwordConfirmation, state: $state)';
  }

  @override
  List<Object> get props {
    return [
      agree,
      name,
      email,
      phone,
      countryCode,
      password,
      passwordConfirmation,
      state,
    ];
  }
}

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpStateInitial extends SignUpState {
  const SignUpStateInitial();
}

class SignUpStateLoading extends SignUpState {
  const SignUpStateLoading();
}

class SignUpStateLoaded extends SignUpState {
  const SignUpStateLoaded(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}

class SignUpStateLoadedError extends SignUpState {
  final Errors errors;

  const SignUpStateLoadedError(this.errors);

  @override
  List<Object> get props => [errors];
}

class SignUpStateFormError extends SignUpState {
  final String errorMsg;
  final int statusCode;

  const SignUpStateFormError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class AccountActivateSuccess extends SignUpState {
  final String msg;

  const AccountActivateSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}

class ResendCodeState extends SignUpState {
  final String message;

  const ResendCodeState(this.message);

  @override
  List<Object> get props => [message];
}
