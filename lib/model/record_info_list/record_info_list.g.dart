// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_info_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordInfoListBoxAdapter extends TypeAdapter<RecordInfoListBox> {
  @override
  final int typeId = 2;

  @override
  RecordInfoListBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecordInfoListBox(
      list: (fields[0] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, RecordInfoListBox obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordInfoListBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
