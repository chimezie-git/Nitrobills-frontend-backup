import 'package:either_dart/either.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';

typedef AsyncOrError<T> = Future<Either<AppError, T>>;
