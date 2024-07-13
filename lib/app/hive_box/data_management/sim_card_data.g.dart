// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_card_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SimCardDataAdapter extends TypeAdapter<SimCardData> {
  @override
  final int typeId = 2;

  @override
  SimCardData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimCardData(
      provider: fields[0] as String,
      phoneNumber: fields[1] as String,
      remainingData: fields[2] as int,
      totalData: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SimCardData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.provider)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.remainingData)
      ..writeByte(3)
      ..write(obj.totalData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimCardDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
