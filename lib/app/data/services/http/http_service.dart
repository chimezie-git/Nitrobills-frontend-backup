import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';

class HttpService {
  static AsyncOrError<Response> get(String url,
      {Map<String, dynamic>? header, int timeout = 20}) async {
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
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.toString()));
    }
  }

  static AsyncOrError<Response> post(String url, Object? body,
      {Map<String, dynamic>? header, int timeout = 20}) async {
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
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.toString()));
    }
  }

  static AsyncOrError<Response> put(String url, Object? body,
      {Map<String, dynamic>? header, int timeout = 20}) async {
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
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.toString()));
    }
  }

  static AsyncOrError<Response> delete(String url, Object? body,
      {Map<String, dynamic>? header, int timeout = 20}) async {
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
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      Dio().close(force: true);
      return Left(AppError(e.toString()));
    }
  }
}
