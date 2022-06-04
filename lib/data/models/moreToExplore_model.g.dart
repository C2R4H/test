// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moreToExplore_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoreToExploreAdapter extends TypeAdapter<MoreToExplore> {
  @override
  final int typeId = 0;

  @override
  MoreToExplore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoreToExplore();
  }

  @override
  void write(BinaryWriter writer, MoreToExplore obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoreToExploreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
