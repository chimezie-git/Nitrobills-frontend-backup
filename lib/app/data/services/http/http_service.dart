import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';

class HttpService {
  static AsyncOrError<Response> get(String url,
      {Map<String, dynamic>? header, int timeout = 60}) async {
    try {
      // close any previous request before this call
      Dio().close(force: true);
      final response = await Dio()
          .get(
            url,
            options: header == null ? null : Options(headers: header),
          )
          .timeout(Duration(seconds: timeout));
      Dio().close();
      return Right(response);
    } on TimeoutException catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.message ?? ""));
    } on SocketException catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.message));
    } on DioException catch (e) {
      Dio().close(force: true);
      if (e.response != null) {
        return Right(e.response!);
      }
      if (e.error is SocketException) {
        return const Left(
            AppError("Please check your internet connection and try again"));
      }
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.toString()));
    }
  }

  static AsyncOrError<Response> post(String url, Object? body,
      {Map<String, dynamic>? header, int timeout = 60}) async {
    try {
      // close any previous request before this call
      Dio().close(force: true);
      Response response = await Dio()
          .post(
            url,
            data: body,
            options: header == null ? null : Options(headers: header),
          )
          .timeout(Duration(seconds: timeout));
      Dio().close(force: true);
      return Right(response);
    } on TimeoutException catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.message ?? ""));
    } on SocketException catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.message));
    } on DioException catch (e) {
      Dio().close(force: true);
      if (e.response != null) {
        return Right(e.response!);
      }
      if (e.error is SocketException) {
        return const Left(
            AppError("Please check your internet connection and try again"));
      }
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.toString()));
    }
  }

  static AsyncOrError<Response> put(String url, Object? body,
      {Map<String, dynamic>? header, int timeout = 60}) async {
    try {
      // close any previous request before this call
      Dio().close(force: true);
      Response response = await Dio()
          .put(
            url,
            data: body,
            options: header == null ? null : Options(headers: header),
          )
          .timeout(Duration(seconds: timeout));
      Dio().close(force: true);
      return Right(response);
    } on TimeoutException catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.message ?? ""));
    } on SocketException catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.message));
    } on DioException catch (e) {
      Dio().close(force: true);
      if (e.response != null) {
        return Right(e.response!);
      }
      if (e.error is SocketException) {
        return const Left(
            AppError("Please check your internet connection and try again"));
      }
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.toString()));
    }
  }

  static AsyncOrError<Response> delete(String url, Object? body,
      {Map<String, dynamic>? header, int timeout = 60}) async {
    try {
      // close any previous request before this call
      Dio().close(force: true);
      Response response = await Dio()
          .delete(
            url,
            data: body,
            options: header == null ? null : Options(headers: header),
          )
          .timeout(Duration(seconds: timeout));
      Dio().close(force: true);
      return Right(response);
    } on TimeoutException catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.message ?? ""));
    } on SocketException catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.message));
    } on DioException catch (e) {
      Dio().close(force: true);
      if (e.response != null) {
        return Right(e.response!);
      }
      if (e.error is SocketException) {
        return const Left(
            AppError("Please check your internet connection and try again"));
      }
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.toString()));
    }
  }

  static String stringFromMap(Map data) {
    final val = data.values.first;
    if (val is List) {
      return val.first.toString();
    } else if (val is Map) {
      return val.values.first.toString();
    } else {
      return val.toString();
    }
  }

  static String stringFromAny(var val) {
    if (val is List) {
      return val.first.toString();
    } else if (val is Map) {
      return val.values.first.toString();
    } else {
      return val.toString();
    }
  }
}
