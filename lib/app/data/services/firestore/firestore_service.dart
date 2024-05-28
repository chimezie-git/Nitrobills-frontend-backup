import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';

class FirestoreService {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<void> addData(
    String id,
    String collection,
    Map<String, dynamic> json,
  ) async {
    await db.collection(collection).doc(id).set(json);
  }

  static Future<void> updateData(
    String id,
    String collection,
    Map<String, dynamic> json,
  ) async {
    await db.collection(collection).doc(id).update(json);
  }

  static Future<void> incrementField(
    String id,
    String collection,
    String fieldKey,
    int incrementValue,
  ) async {
    await db
        .collection(collection)
        .doc(id)
        .update({fieldKey: FieldValue.increment(incrementValue)});
  }

  static AsyncOrError<List<Map<String, dynamic>>?> getAllData(
      String collection) async {
    try {
      final snapshot = await db.collection(collection).get();
      List<Map<String, dynamic>> data =
          snapshot.docs.map((e) => e.data()).toList();
      return Right(data);
    } on FirebaseException catch (e) {
      return Left(AppError(e.message ?? ""));
    }
  }

  static AsyncOrError<bool> dataExists(String collection, String id) async {
    try {
      final snapshot = await db.collection(collection).doc(id).get();
      if (snapshot.exists) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on FirebaseException catch (e) {
      return Left(AppError(e.message ?? ""));
    }
  }

  static AsyncOrError<Map<String, dynamic>> getData(
      String collection, String id) async {
    try {
      final snapshot = await db.collection(collection).doc(id).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.data()!);
        return Right(data);
      } else {
        return const Left(AppError("Data does not exist in database"));
      }
    } on FirebaseException catch (e) {
      return Left(AppError(e.message ?? ""));
    }
  }

  static Future<void> deleteData(String collection, String id) async {
    await db.collection(collection).doc(id).delete();
  }
}
