// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_management.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataManagementAdapter extends TypeAdapter<DataManagement> {
  @override
  final int typeId = 1;

  @override
  DataManagement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataManagement(
      lastDay: fields[0] as DateTime,
      enabled: fields[1] as bool,
      simData: (fields[2] as List).cast<SimCardData>(),
    );
  }

  @override
  void write(BinaryWriter writer, DataManagement obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.lastDay)
      ..writeByte(1)
      ..write(obj.enabled)
      ..writeByte(2)
      ..write(obj.simData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataManagementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
