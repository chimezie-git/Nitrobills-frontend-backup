// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_payment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentPaymentAdapter extends TypeAdapter<RecentPayment> {
  @override
  final int typeId = 3;

  @override
  RecentPayment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentPayment(
      id: fields[0] as String,
      name: fields[1] as String,
      serviceType: fields[2] as int,
      serviceProvider: fields[3] as String,
      number: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecentPayment obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.serviceType)
      ..writeByte(3)
      ..write(obj.serviceProvider)
      ..writeByte(4)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentPaymentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
