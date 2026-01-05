// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RhttpWebSocketEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RhttpWebSocketEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RhttpWebSocketEvent()';
}


}

/// @nodoc
class $RhttpWebSocketEventCopyWith<$Res>  {
$RhttpWebSocketEventCopyWith(RhttpWebSocketEvent _, $Res Function(RhttpWebSocketEvent) __);
}


/// @nodoc


class RhttpWebSocketEvent_Message extends RhttpWebSocketEvent {
  const RhttpWebSocketEvent_Message(this.field0): super._();
  

 final  RhttpWebSocketMessage field0;

/// Create a copy of RhttpWebSocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RhttpWebSocketEvent_MessageCopyWith<RhttpWebSocketEvent_Message> get copyWith => _$RhttpWebSocketEvent_MessageCopyWithImpl<RhttpWebSocketEvent_Message>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RhttpWebSocketEvent_Message&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'RhttpWebSocketEvent.message(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RhttpWebSocketEvent_MessageCopyWith<$Res> implements $RhttpWebSocketEventCopyWith<$Res> {
  factory $RhttpWebSocketEvent_MessageCopyWith(RhttpWebSocketEvent_Message value, $Res Function(RhttpWebSocketEvent_Message) _then) = _$RhttpWebSocketEvent_MessageCopyWithImpl;
@useResult
$Res call({
 RhttpWebSocketMessage field0
});


$RhttpWebSocketMessageCopyWith<$Res> get field0;

}
/// @nodoc
class _$RhttpWebSocketEvent_MessageCopyWithImpl<$Res>
    implements $RhttpWebSocketEvent_MessageCopyWith<$Res> {
  _$RhttpWebSocketEvent_MessageCopyWithImpl(this._self, this._then);

  final RhttpWebSocketEvent_Message _self;
  final $Res Function(RhttpWebSocketEvent_Message) _then;

/// Create a copy of RhttpWebSocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RhttpWebSocketEvent_Message(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as RhttpWebSocketMessage,
  ));
}

/// Create a copy of RhttpWebSocketEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RhttpWebSocketMessageCopyWith<$Res> get field0 {
  
  return $RhttpWebSocketMessageCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc


class RhttpWebSocketEvent_Closed extends RhttpWebSocketEvent {
  const RhttpWebSocketEvent_Closed({this.code, this.reason}): super._();
  

 final  int? code;
 final  String? reason;

/// Create a copy of RhttpWebSocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RhttpWebSocketEvent_ClosedCopyWith<RhttpWebSocketEvent_Closed> get copyWith => _$RhttpWebSocketEvent_ClosedCopyWithImpl<RhttpWebSocketEvent_Closed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RhttpWebSocketEvent_Closed&&(identical(other.code, code) || other.code == code)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,code,reason);

@override
String toString() {
  return 'RhttpWebSocketEvent.closed(code: $code, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $RhttpWebSocketEvent_ClosedCopyWith<$Res> implements $RhttpWebSocketEventCopyWith<$Res> {
  factory $RhttpWebSocketEvent_ClosedCopyWith(RhttpWebSocketEvent_Closed value, $Res Function(RhttpWebSocketEvent_Closed) _then) = _$RhttpWebSocketEvent_ClosedCopyWithImpl;
@useResult
$Res call({
 int? code, String? reason
});




}
/// @nodoc
class _$RhttpWebSocketEvent_ClosedCopyWithImpl<$Res>
    implements $RhttpWebSocketEvent_ClosedCopyWith<$Res> {
  _$RhttpWebSocketEvent_ClosedCopyWithImpl(this._self, this._then);

  final RhttpWebSocketEvent_Closed _self;
  final $Res Function(RhttpWebSocketEvent_Closed) _then;

/// Create a copy of RhttpWebSocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? reason = freezed,}) {
  return _then(RhttpWebSocketEvent_Closed(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class RhttpWebSocketEvent_Error extends RhttpWebSocketEvent {
  const RhttpWebSocketEvent_Error(this.field0): super._();
  

 final  WebSocketError field0;

/// Create a copy of RhttpWebSocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RhttpWebSocketEvent_ErrorCopyWith<RhttpWebSocketEvent_Error> get copyWith => _$RhttpWebSocketEvent_ErrorCopyWithImpl<RhttpWebSocketEvent_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RhttpWebSocketEvent_Error&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'RhttpWebSocketEvent.error(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RhttpWebSocketEvent_ErrorCopyWith<$Res> implements $RhttpWebSocketEventCopyWith<$Res> {
  factory $RhttpWebSocketEvent_ErrorCopyWith(RhttpWebSocketEvent_Error value, $Res Function(RhttpWebSocketEvent_Error) _then) = _$RhttpWebSocketEvent_ErrorCopyWithImpl;
@useResult
$Res call({
 WebSocketError field0
});


$WebSocketErrorCopyWith<$Res> get field0;

}
/// @nodoc
class _$RhttpWebSocketEvent_ErrorCopyWithImpl<$Res>
    implements $RhttpWebSocketEvent_ErrorCopyWith<$Res> {
  _$RhttpWebSocketEvent_ErrorCopyWithImpl(this._self, this._then);

  final RhttpWebSocketEvent_Error _self;
  final $Res Function(RhttpWebSocketEvent_Error) _then;

/// Create a copy of RhttpWebSocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RhttpWebSocketEvent_Error(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as WebSocketError,
  ));
}

/// Create a copy of RhttpWebSocketEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WebSocketErrorCopyWith<$Res> get field0 {
  
  return $WebSocketErrorCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc
mixin _$RhttpWebSocketMessage {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RhttpWebSocketMessage);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RhttpWebSocketMessage()';
}


}

/// @nodoc
class $RhttpWebSocketMessageCopyWith<$Res>  {
$RhttpWebSocketMessageCopyWith(RhttpWebSocketMessage _, $Res Function(RhttpWebSocketMessage) __);
}


/// @nodoc


class RhttpWebSocketMessage_Text extends RhttpWebSocketMessage {
  const RhttpWebSocketMessage_Text(this.field0): super._();
  

 final  String field0;

/// Create a copy of RhttpWebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RhttpWebSocketMessage_TextCopyWith<RhttpWebSocketMessage_Text> get copyWith => _$RhttpWebSocketMessage_TextCopyWithImpl<RhttpWebSocketMessage_Text>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RhttpWebSocketMessage_Text&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'RhttpWebSocketMessage.text(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RhttpWebSocketMessage_TextCopyWith<$Res> implements $RhttpWebSocketMessageCopyWith<$Res> {
  factory $RhttpWebSocketMessage_TextCopyWith(RhttpWebSocketMessage_Text value, $Res Function(RhttpWebSocketMessage_Text) _then) = _$RhttpWebSocketMessage_TextCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$RhttpWebSocketMessage_TextCopyWithImpl<$Res>
    implements $RhttpWebSocketMessage_TextCopyWith<$Res> {
  _$RhttpWebSocketMessage_TextCopyWithImpl(this._self, this._then);

  final RhttpWebSocketMessage_Text _self;
  final $Res Function(RhttpWebSocketMessage_Text) _then;

/// Create a copy of RhttpWebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RhttpWebSocketMessage_Text(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RhttpWebSocketMessage_Binary extends RhttpWebSocketMessage {
  const RhttpWebSocketMessage_Binary(this.field0): super._();
  

 final  Uint8List field0;

/// Create a copy of RhttpWebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RhttpWebSocketMessage_BinaryCopyWith<RhttpWebSocketMessage_Binary> get copyWith => _$RhttpWebSocketMessage_BinaryCopyWithImpl<RhttpWebSocketMessage_Binary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RhttpWebSocketMessage_Binary&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'RhttpWebSocketMessage.binary(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RhttpWebSocketMessage_BinaryCopyWith<$Res> implements $RhttpWebSocketMessageCopyWith<$Res> {
  factory $RhttpWebSocketMessage_BinaryCopyWith(RhttpWebSocketMessage_Binary value, $Res Function(RhttpWebSocketMessage_Binary) _then) = _$RhttpWebSocketMessage_BinaryCopyWithImpl;
@useResult
$Res call({
 Uint8List field0
});




}
/// @nodoc
class _$RhttpWebSocketMessage_BinaryCopyWithImpl<$Res>
    implements $RhttpWebSocketMessage_BinaryCopyWith<$Res> {
  _$RhttpWebSocketMessage_BinaryCopyWithImpl(this._self, this._then);

  final RhttpWebSocketMessage_Binary _self;
  final $Res Function(RhttpWebSocketMessage_Binary) _then;

/// Create a copy of RhttpWebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RhttpWebSocketMessage_Binary(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc


class RhttpWebSocketMessage_Ping extends RhttpWebSocketMessage {
  const RhttpWebSocketMessage_Ping(this.field0): super._();
  

 final  Uint8List field0;

/// Create a copy of RhttpWebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RhttpWebSocketMessage_PingCopyWith<RhttpWebSocketMessage_Ping> get copyWith => _$RhttpWebSocketMessage_PingCopyWithImpl<RhttpWebSocketMessage_Ping>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RhttpWebSocketMessage_Ping&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'RhttpWebSocketMessage.ping(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RhttpWebSocketMessage_PingCopyWith<$Res> implements $RhttpWebSocketMessageCopyWith<$Res> {
  factory $RhttpWebSocketMessage_PingCopyWith(RhttpWebSocketMessage_Ping value, $Res Function(RhttpWebSocketMessage_Ping) _then) = _$RhttpWebSocketMessage_PingCopyWithImpl;
@useResult
$Res call({
 Uint8List field0
});




}
/// @nodoc
class _$RhttpWebSocketMessage_PingCopyWithImpl<$Res>
    implements $RhttpWebSocketMessage_PingCopyWith<$Res> {
  _$RhttpWebSocketMessage_PingCopyWithImpl(this._self, this._then);

  final RhttpWebSocketMessage_Ping _self;
  final $Res Function(RhttpWebSocketMessage_Ping) _then;

/// Create a copy of RhttpWebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RhttpWebSocketMessage_Ping(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc


class RhttpWebSocketMessage_Pong extends RhttpWebSocketMessage {
  const RhttpWebSocketMessage_Pong(this.field0): super._();
  

 final  Uint8List field0;

/// Create a copy of RhttpWebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RhttpWebSocketMessage_PongCopyWith<RhttpWebSocketMessage_Pong> get copyWith => _$RhttpWebSocketMessage_PongCopyWithImpl<RhttpWebSocketMessage_Pong>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RhttpWebSocketMessage_Pong&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'RhttpWebSocketMessage.pong(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RhttpWebSocketMessage_PongCopyWith<$Res> implements $RhttpWebSocketMessageCopyWith<$Res> {
  factory $RhttpWebSocketMessage_PongCopyWith(RhttpWebSocketMessage_Pong value, $Res Function(RhttpWebSocketMessage_Pong) _then) = _$RhttpWebSocketMessage_PongCopyWithImpl;
@useResult
$Res call({
 Uint8List field0
});




}
/// @nodoc
class _$RhttpWebSocketMessage_PongCopyWithImpl<$Res>
    implements $RhttpWebSocketMessage_PongCopyWith<$Res> {
  _$RhttpWebSocketMessage_PongCopyWithImpl(this._self, this._then);

  final RhttpWebSocketMessage_Pong _self;
  final $Res Function(RhttpWebSocketMessage_Pong) _then;

/// Create a copy of RhttpWebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RhttpWebSocketMessage_Pong(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc


class RhttpWebSocketMessage_Close extends RhttpWebSocketMessage {
  const RhttpWebSocketMessage_Close({required this.code, required this.reason}): super._();
  

 final  int code;
 final  String reason;

/// Create a copy of RhttpWebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RhttpWebSocketMessage_CloseCopyWith<RhttpWebSocketMessage_Close> get copyWith => _$RhttpWebSocketMessage_CloseCopyWithImpl<RhttpWebSocketMessage_Close>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RhttpWebSocketMessage_Close&&(identical(other.code, code) || other.code == code)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,code,reason);

@override
String toString() {
  return 'RhttpWebSocketMessage.close(code: $code, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $RhttpWebSocketMessage_CloseCopyWith<$Res> implements $RhttpWebSocketMessageCopyWith<$Res> {
  factory $RhttpWebSocketMessage_CloseCopyWith(RhttpWebSocketMessage_Close value, $Res Function(RhttpWebSocketMessage_Close) _then) = _$RhttpWebSocketMessage_CloseCopyWithImpl;
@useResult
$Res call({
 int code, String reason
});




}
/// @nodoc
class _$RhttpWebSocketMessage_CloseCopyWithImpl<$Res>
    implements $RhttpWebSocketMessage_CloseCopyWith<$Res> {
  _$RhttpWebSocketMessage_CloseCopyWithImpl(this._self, this._then);

  final RhttpWebSocketMessage_Close _self;
  final $Res Function(RhttpWebSocketMessage_Close) _then;

/// Create a copy of RhttpWebSocketMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,Object? reason = null,}) {
  return _then(RhttpWebSocketMessage_Close(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
