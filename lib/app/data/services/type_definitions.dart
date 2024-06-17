import 'package:either_dart/either.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';

typedef AsyncOrError<T> = Future<Either<AppError, T>>;
typedef TypeOrError<T> = Either<AppError, T>;
typedef NullOrSingleFieldError<T> = Either<SingleFieldError, Null>;
typedef NullOrMultipleFieldError<T> = Either<MultipleFieldError, Null>;
