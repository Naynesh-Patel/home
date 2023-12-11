import 'package:dartz/dartz.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/auth/set_password_model.dart';
import '../../data/model/auth/user_login_response_model.dart';
import '../../presentation/error/exception.dart';
import '../../presentation/error/failure.dart';

abstract class AuthRepository {
  Future<Either<dynamic, UserLoginResponseModel>> login(
      Map<String, dynamic> body);

  Either<Failure, UserLoginResponseModel> getCashedUserInfo();

  Future<Either<dynamic, String>> signUp(Map<String, dynamic> body);

  Future<Either<dynamic, String>> sendForgotPassCode(Map<String, dynamic> body);

  Future<Either<dynamic, String>> setPassword(SetPasswordModel body);

  Future<Either<Failure, String>> sendActiveAccountCode(String email);

  Future<Either<Failure, String>> activeAccountCodeSubmit(
      Map<String, String> body);

  Future<Either<dynamic, String>> resendVerificationCode(
      Map<String, String> email);

  Future<Either<Failure, String>> logOut(String token);
}

class AuthRepositoryImp extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<dynamic, UserLoginResponseModel>> login(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.signIn(body);
      final data = UserLoginResponseModel.fromMap(result);
      localDataSource.cacheUserResponse(data);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> logOut(String token) async {
    try {
      final result = await remoteDataSource.logOut(token);
      localDataSource.clearUserProfile();
      // localDataSource.clearCoupon();
      // localDataSource.clearCoupon();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, UserLoginResponseModel> getCashedUserInfo() {
    try {
      final result = localDataSource.getUserResponseModel();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<dynamic, String>> signUp(Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.userRegister(body);
      return Right(result);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> sendForgotPassCode(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.sendForgotPassCode(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> setPassword(SetPasswordModel body) async {
    try {
      final result = await remoteDataSource.setPassword(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> sendActiveAccountCode(String email) async {
    try {
      final result = await remoteDataSource.sendActiveAccountCode(email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> activeAccountCodeSubmit(
      Map<String, String> body) async {
    try {
      final result = await remoteDataSource.activeAccountCodeSubmit(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> resendVerificationCode(
      Map<String, String> email) async {
    try {
      final result = await remoteDataSource.resendVerificationCode(email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
