// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'http.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HttpBody {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function() bytesStream,
    required TResult Function(Map<String, String> field0) form,
    required TResult Function(MultipartPayload field0) multipart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function()? bytesStream,
    TResult? Function(Map<String, String> field0)? form,
    TResult? Function(MultipartPayload field0)? multipart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function()? bytesStream,
    TResult Function(Map<String, String> field0)? form,
    TResult Function(MultipartPayload field0)? multipart,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpBody_Text value) text,
    required TResult Function(HttpBody_Bytes value) bytes,
    required TResult Function(HttpBody_BytesStream value) bytesStream,
    required TResult Function(HttpBody_Form value) form,
    required TResult Function(HttpBody_Multipart value) multipart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpBody_Text value)? text,
    TResult? Function(HttpBody_Bytes value)? bytes,
    TResult? Function(HttpBody_BytesStream value)? bytesStream,
    TResult? Function(HttpBody_Form value)? form,
    TResult? Function(HttpBody_Multipart value)? multipart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpBody_Text value)? text,
    TResult Function(HttpBody_Bytes value)? bytes,
    TResult Function(HttpBody_BytesStream value)? bytesStream,
    TResult Function(HttpBody_Form value)? form,
    TResult Function(HttpBody_Multipart value)? multipart,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HttpBodyCopyWith<$Res> {
  factory $HttpBodyCopyWith(HttpBody value, $Res Function(HttpBody) then) =
      _$HttpBodyCopyWithImpl<$Res, HttpBody>;
}

/// @nodoc
class _$HttpBodyCopyWithImpl<$Res, $Val extends HttpBody>
    implements $HttpBodyCopyWith<$Res> {
  _$HttpBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$HttpBody_TextImplCopyWith<$Res> {
  factory _$$HttpBody_TextImplCopyWith(
          _$HttpBody_TextImpl value, $Res Function(_$HttpBody_TextImpl) then) =
      __$$HttpBody_TextImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$HttpBody_TextImplCopyWithImpl<$Res>
    extends _$HttpBodyCopyWithImpl<$Res, _$HttpBody_TextImpl>
    implements _$$HttpBody_TextImplCopyWith<$Res> {
  __$$HttpBody_TextImplCopyWithImpl(
      _$HttpBody_TextImpl _value, $Res Function(_$HttpBody_TextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$HttpBody_TextImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HttpBody_TextImpl extends HttpBody_Text {
  const _$HttpBody_TextImpl(this.field0) : super._();

  @override
  final String field0;

  @override
  String toString() {
    return 'HttpBody.text(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpBody_TextImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpBody_TextImplCopyWith<_$HttpBody_TextImpl> get copyWith =>
      __$$HttpBody_TextImplCopyWithImpl<_$HttpBody_TextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function() bytesStream,
    required TResult Function(Map<String, String> field0) form,
    required TResult Function(MultipartPayload field0) multipart,
  }) {
    return text(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function()? bytesStream,
    TResult? Function(Map<String, String> field0)? form,
    TResult? Function(MultipartPayload field0)? multipart,
  }) {
    return text?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function()? bytesStream,
    TResult Function(Map<String, String> field0)? form,
    TResult Function(MultipartPayload field0)? multipart,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpBody_Text value) text,
    required TResult Function(HttpBody_Bytes value) bytes,
    required TResult Function(HttpBody_BytesStream value) bytesStream,
    required TResult Function(HttpBody_Form value) form,
    required TResult Function(HttpBody_Multipart value) multipart,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpBody_Text value)? text,
    TResult? Function(HttpBody_Bytes value)? bytes,
    TResult? Function(HttpBody_BytesStream value)? bytesStream,
    TResult? Function(HttpBody_Form value)? form,
    TResult? Function(HttpBody_Multipart value)? multipart,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpBody_Text value)? text,
    TResult Function(HttpBody_Bytes value)? bytes,
    TResult Function(HttpBody_BytesStream value)? bytesStream,
    TResult Function(HttpBody_Form value)? form,
    TResult Function(HttpBody_Multipart value)? multipart,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }
}

abstract class HttpBody_Text extends HttpBody {
  const factory HttpBody_Text(final String field0) = _$HttpBody_TextImpl;
  const HttpBody_Text._() : super._();

  String get field0;
  @JsonKey(ignore: true)
  _$$HttpBody_TextImplCopyWith<_$HttpBody_TextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HttpBody_BytesImplCopyWith<$Res> {
  factory _$$HttpBody_BytesImplCopyWith(_$HttpBody_BytesImpl value,
          $Res Function(_$HttpBody_BytesImpl) then) =
      __$$HttpBody_BytesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uint8List field0});
}

/// @nodoc
class __$$HttpBody_BytesImplCopyWithImpl<$Res>
    extends _$HttpBodyCopyWithImpl<$Res, _$HttpBody_BytesImpl>
    implements _$$HttpBody_BytesImplCopyWith<$Res> {
  __$$HttpBody_BytesImplCopyWithImpl(
      _$HttpBody_BytesImpl _value, $Res Function(_$HttpBody_BytesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$HttpBody_BytesImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$HttpBody_BytesImpl extends HttpBody_Bytes {
  const _$HttpBody_BytesImpl(this.field0) : super._();

  @override
  final Uint8List field0;

  @override
  String toString() {
    return 'HttpBody.bytes(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpBody_BytesImpl &&
            const DeepCollectionEquality().equals(other.field0, field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(field0));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpBody_BytesImplCopyWith<_$HttpBody_BytesImpl> get copyWith =>
      __$$HttpBody_BytesImplCopyWithImpl<_$HttpBody_BytesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function() bytesStream,
    required TResult Function(Map<String, String> field0) form,
    required TResult Function(MultipartPayload field0) multipart,
  }) {
    return bytes(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function()? bytesStream,
    TResult? Function(Map<String, String> field0)? form,
    TResult? Function(MultipartPayload field0)? multipart,
  }) {
    return bytes?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function()? bytesStream,
    TResult Function(Map<String, String> field0)? form,
    TResult Function(MultipartPayload field0)? multipart,
    required TResult orElse(),
  }) {
    if (bytes != null) {
      return bytes(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpBody_Text value) text,
    required TResult Function(HttpBody_Bytes value) bytes,
    required TResult Function(HttpBody_BytesStream value) bytesStream,
    required TResult Function(HttpBody_Form value) form,
    required TResult Function(HttpBody_Multipart value) multipart,
  }) {
    return bytes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpBody_Text value)? text,
    TResult? Function(HttpBody_Bytes value)? bytes,
    TResult? Function(HttpBody_BytesStream value)? bytesStream,
    TResult? Function(HttpBody_Form value)? form,
    TResult? Function(HttpBody_Multipart value)? multipart,
  }) {
    return bytes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpBody_Text value)? text,
    TResult Function(HttpBody_Bytes value)? bytes,
    TResult Function(HttpBody_BytesStream value)? bytesStream,
    TResult Function(HttpBody_Form value)? form,
    TResult Function(HttpBody_Multipart value)? multipart,
    required TResult orElse(),
  }) {
    if (bytes != null) {
      return bytes(this);
    }
    return orElse();
  }
}

abstract class HttpBody_Bytes extends HttpBody {
  const factory HttpBody_Bytes(final Uint8List field0) = _$HttpBody_BytesImpl;
  const HttpBody_Bytes._() : super._();

  Uint8List get field0;
  @JsonKey(ignore: true)
  _$$HttpBody_BytesImplCopyWith<_$HttpBody_BytesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HttpBody_BytesStreamImplCopyWith<$Res> {
  factory _$$HttpBody_BytesStreamImplCopyWith(_$HttpBody_BytesStreamImpl value,
          $Res Function(_$HttpBody_BytesStreamImpl) then) =
      __$$HttpBody_BytesStreamImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HttpBody_BytesStreamImplCopyWithImpl<$Res>
    extends _$HttpBodyCopyWithImpl<$Res, _$HttpBody_BytesStreamImpl>
    implements _$$HttpBody_BytesStreamImplCopyWith<$Res> {
  __$$HttpBody_BytesStreamImplCopyWithImpl(_$HttpBody_BytesStreamImpl _value,
      $Res Function(_$HttpBody_BytesStreamImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$HttpBody_BytesStreamImpl extends HttpBody_BytesStream {
  const _$HttpBody_BytesStreamImpl() : super._();

  @override
  String toString() {
    return 'HttpBody.bytesStream()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpBody_BytesStreamImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function() bytesStream,
    required TResult Function(Map<String, String> field0) form,
    required TResult Function(MultipartPayload field0) multipart,
  }) {
    return bytesStream();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function()? bytesStream,
    TResult? Function(Map<String, String> field0)? form,
    TResult? Function(MultipartPayload field0)? multipart,
  }) {
    return bytesStream?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function()? bytesStream,
    TResult Function(Map<String, String> field0)? form,
    TResult Function(MultipartPayload field0)? multipart,
    required TResult orElse(),
  }) {
    if (bytesStream != null) {
      return bytesStream();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpBody_Text value) text,
    required TResult Function(HttpBody_Bytes value) bytes,
    required TResult Function(HttpBody_BytesStream value) bytesStream,
    required TResult Function(HttpBody_Form value) form,
    required TResult Function(HttpBody_Multipart value) multipart,
  }) {
    return bytesStream(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpBody_Text value)? text,
    TResult? Function(HttpBody_Bytes value)? bytes,
    TResult? Function(HttpBody_BytesStream value)? bytesStream,
    TResult? Function(HttpBody_Form value)? form,
    TResult? Function(HttpBody_Multipart value)? multipart,
  }) {
    return bytesStream?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpBody_Text value)? text,
    TResult Function(HttpBody_Bytes value)? bytes,
    TResult Function(HttpBody_BytesStream value)? bytesStream,
    TResult Function(HttpBody_Form value)? form,
    TResult Function(HttpBody_Multipart value)? multipart,
    required TResult orElse(),
  }) {
    if (bytesStream != null) {
      return bytesStream(this);
    }
    return orElse();
  }
}

abstract class HttpBody_BytesStream extends HttpBody {
  const factory HttpBody_BytesStream() = _$HttpBody_BytesStreamImpl;
  const HttpBody_BytesStream._() : super._();
}

/// @nodoc
abstract class _$$HttpBody_FormImplCopyWith<$Res> {
  factory _$$HttpBody_FormImplCopyWith(
          _$HttpBody_FormImpl value, $Res Function(_$HttpBody_FormImpl) then) =
      __$$HttpBody_FormImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, String> field0});
}

/// @nodoc
class __$$HttpBody_FormImplCopyWithImpl<$Res>
    extends _$HttpBodyCopyWithImpl<$Res, _$HttpBody_FormImpl>
    implements _$$HttpBody_FormImplCopyWith<$Res> {
  __$$HttpBody_FormImplCopyWithImpl(
      _$HttpBody_FormImpl _value, $Res Function(_$HttpBody_FormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$HttpBody_FormImpl(
      null == field0
          ? _value._field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

class _$HttpBody_FormImpl extends HttpBody_Form {
  const _$HttpBody_FormImpl(final Map<String, String> field0)
      : _field0 = field0,
        super._();

  final Map<String, String> _field0;
  @override
  Map<String, String> get field0 {
    if (_field0 is EqualUnmodifiableMapView) return _field0;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_field0);
  }

  @override
  String toString() {
    return 'HttpBody.form(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpBody_FormImpl &&
            const DeepCollectionEquality().equals(other._field0, _field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_field0));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpBody_FormImplCopyWith<_$HttpBody_FormImpl> get copyWith =>
      __$$HttpBody_FormImplCopyWithImpl<_$HttpBody_FormImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function() bytesStream,
    required TResult Function(Map<String, String> field0) form,
    required TResult Function(MultipartPayload field0) multipart,
  }) {
    return form(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function()? bytesStream,
    TResult? Function(Map<String, String> field0)? form,
    TResult? Function(MultipartPayload field0)? multipart,
  }) {
    return form?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function()? bytesStream,
    TResult Function(Map<String, String> field0)? form,
    TResult Function(MultipartPayload field0)? multipart,
    required TResult orElse(),
  }) {
    if (form != null) {
      return form(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpBody_Text value) text,
    required TResult Function(HttpBody_Bytes value) bytes,
    required TResult Function(HttpBody_BytesStream value) bytesStream,
    required TResult Function(HttpBody_Form value) form,
    required TResult Function(HttpBody_Multipart value) multipart,
  }) {
    return form(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpBody_Text value)? text,
    TResult? Function(HttpBody_Bytes value)? bytes,
    TResult? Function(HttpBody_BytesStream value)? bytesStream,
    TResult? Function(HttpBody_Form value)? form,
    TResult? Function(HttpBody_Multipart value)? multipart,
  }) {
    return form?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpBody_Text value)? text,
    TResult Function(HttpBody_Bytes value)? bytes,
    TResult Function(HttpBody_BytesStream value)? bytesStream,
    TResult Function(HttpBody_Form value)? form,
    TResult Function(HttpBody_Multipart value)? multipart,
    required TResult orElse(),
  }) {
    if (form != null) {
      return form(this);
    }
    return orElse();
  }
}

abstract class HttpBody_Form extends HttpBody {
  const factory HttpBody_Form(final Map<String, String> field0) =
      _$HttpBody_FormImpl;
  const HttpBody_Form._() : super._();

  Map<String, String> get field0;
  @JsonKey(ignore: true)
  _$$HttpBody_FormImplCopyWith<_$HttpBody_FormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HttpBody_MultipartImplCopyWith<$Res> {
  factory _$$HttpBody_MultipartImplCopyWith(_$HttpBody_MultipartImpl value,
          $Res Function(_$HttpBody_MultipartImpl) then) =
      __$$HttpBody_MultipartImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MultipartPayload field0});
}

/// @nodoc
class __$$HttpBody_MultipartImplCopyWithImpl<$Res>
    extends _$HttpBodyCopyWithImpl<$Res, _$HttpBody_MultipartImpl>
    implements _$$HttpBody_MultipartImplCopyWith<$Res> {
  __$$HttpBody_MultipartImplCopyWithImpl(_$HttpBody_MultipartImpl _value,
      $Res Function(_$HttpBody_MultipartImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$HttpBody_MultipartImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as MultipartPayload,
    ));
  }
}

/// @nodoc

class _$HttpBody_MultipartImpl extends HttpBody_Multipart {
  const _$HttpBody_MultipartImpl(this.field0) : super._();

  @override
  final MultipartPayload field0;

  @override
  String toString() {
    return 'HttpBody.multipart(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpBody_MultipartImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpBody_MultipartImplCopyWith<_$HttpBody_MultipartImpl> get copyWith =>
      __$$HttpBody_MultipartImplCopyWithImpl<_$HttpBody_MultipartImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function() bytesStream,
    required TResult Function(Map<String, String> field0) form,
    required TResult Function(MultipartPayload field0) multipart,
  }) {
    return multipart(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function()? bytesStream,
    TResult? Function(Map<String, String> field0)? form,
    TResult? Function(MultipartPayload field0)? multipart,
  }) {
    return multipart?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function()? bytesStream,
    TResult Function(Map<String, String> field0)? form,
    TResult Function(MultipartPayload field0)? multipart,
    required TResult orElse(),
  }) {
    if (multipart != null) {
      return multipart(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpBody_Text value) text,
    required TResult Function(HttpBody_Bytes value) bytes,
    required TResult Function(HttpBody_BytesStream value) bytesStream,
    required TResult Function(HttpBody_Form value) form,
    required TResult Function(HttpBody_Multipart value) multipart,
  }) {
    return multipart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpBody_Text value)? text,
    TResult? Function(HttpBody_Bytes value)? bytes,
    TResult? Function(HttpBody_BytesStream value)? bytesStream,
    TResult? Function(HttpBody_Form value)? form,
    TResult? Function(HttpBody_Multipart value)? multipart,
  }) {
    return multipart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpBody_Text value)? text,
    TResult Function(HttpBody_Bytes value)? bytes,
    TResult Function(HttpBody_BytesStream value)? bytesStream,
    TResult Function(HttpBody_Form value)? form,
    TResult Function(HttpBody_Multipart value)? multipart,
    required TResult orElse(),
  }) {
    if (multipart != null) {
      return multipart(this);
    }
    return orElse();
  }
}

abstract class HttpBody_Multipart extends HttpBody {
  const factory HttpBody_Multipart(final MultipartPayload field0) =
      _$HttpBody_MultipartImpl;
  const HttpBody_Multipart._() : super._();

  MultipartPayload get field0;
  @JsonKey(ignore: true)
  _$$HttpBody_MultipartImplCopyWith<_$HttpBody_MultipartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HttpHeaders {
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, String> field0) map,
    required TResult Function(List<(String, String)> field0) list,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, String> field0)? map,
    TResult? Function(List<(String, String)> field0)? list,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, String> field0)? map,
    TResult Function(List<(String, String)> field0)? list,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpHeaders_Map value) map,
    required TResult Function(HttpHeaders_List value) list,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpHeaders_Map value)? map,
    TResult? Function(HttpHeaders_List value)? list,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpHeaders_Map value)? map,
    TResult Function(HttpHeaders_List value)? list,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HttpHeadersCopyWith<$Res> {
  factory $HttpHeadersCopyWith(
          HttpHeaders value, $Res Function(HttpHeaders) then) =
      _$HttpHeadersCopyWithImpl<$Res, HttpHeaders>;
}

/// @nodoc
class _$HttpHeadersCopyWithImpl<$Res, $Val extends HttpHeaders>
    implements $HttpHeadersCopyWith<$Res> {
  _$HttpHeadersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$HttpHeaders_MapImplCopyWith<$Res> {
  factory _$$HttpHeaders_MapImplCopyWith(_$HttpHeaders_MapImpl value,
          $Res Function(_$HttpHeaders_MapImpl) then) =
      __$$HttpHeaders_MapImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, String> field0});
}

/// @nodoc
class __$$HttpHeaders_MapImplCopyWithImpl<$Res>
    extends _$HttpHeadersCopyWithImpl<$Res, _$HttpHeaders_MapImpl>
    implements _$$HttpHeaders_MapImplCopyWith<$Res> {
  __$$HttpHeaders_MapImplCopyWithImpl(
      _$HttpHeaders_MapImpl _value, $Res Function(_$HttpHeaders_MapImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$HttpHeaders_MapImpl(
      null == field0
          ? _value._field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

class _$HttpHeaders_MapImpl extends HttpHeaders_Map {
  const _$HttpHeaders_MapImpl(final Map<String, String> field0)
      : _field0 = field0,
        super._();

  final Map<String, String> _field0;
  @override
  Map<String, String> get field0 {
    if (_field0 is EqualUnmodifiableMapView) return _field0;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_field0);
  }

  @override
  String toString() {
    return 'HttpHeaders.map(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpHeaders_MapImpl &&
            const DeepCollectionEquality().equals(other._field0, _field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_field0));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpHeaders_MapImplCopyWith<_$HttpHeaders_MapImpl> get copyWith =>
      __$$HttpHeaders_MapImplCopyWithImpl<_$HttpHeaders_MapImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, String> field0) map,
    required TResult Function(List<(String, String)> field0) list,
  }) {
    return map(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, String> field0)? map,
    TResult? Function(List<(String, String)> field0)? list,
  }) {
    return map?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, String> field0)? map,
    TResult Function(List<(String, String)> field0)? list,
    required TResult orElse(),
  }) {
    if (map != null) {
      return map(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpHeaders_Map value) map,
    required TResult Function(HttpHeaders_List value) list,
  }) {
    return map(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpHeaders_Map value)? map,
    TResult? Function(HttpHeaders_List value)? list,
  }) {
    return map?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpHeaders_Map value)? map,
    TResult Function(HttpHeaders_List value)? list,
    required TResult orElse(),
  }) {
    if (map != null) {
      return map(this);
    }
    return orElse();
  }
}

abstract class HttpHeaders_Map extends HttpHeaders {
  const factory HttpHeaders_Map(final Map<String, String> field0) =
      _$HttpHeaders_MapImpl;
  const HttpHeaders_Map._() : super._();

  @override
  Map<String, String> get field0;
  @JsonKey(ignore: true)
  _$$HttpHeaders_MapImplCopyWith<_$HttpHeaders_MapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HttpHeaders_ListImplCopyWith<$Res> {
  factory _$$HttpHeaders_ListImplCopyWith(_$HttpHeaders_ListImpl value,
          $Res Function(_$HttpHeaders_ListImpl) then) =
      __$$HttpHeaders_ListImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<(String, String)> field0});
}

/// @nodoc
class __$$HttpHeaders_ListImplCopyWithImpl<$Res>
    extends _$HttpHeadersCopyWithImpl<$Res, _$HttpHeaders_ListImpl>
    implements _$$HttpHeaders_ListImplCopyWith<$Res> {
  __$$HttpHeaders_ListImplCopyWithImpl(_$HttpHeaders_ListImpl _value,
      $Res Function(_$HttpHeaders_ListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$HttpHeaders_ListImpl(
      null == field0
          ? _value._field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as List<(String, String)>,
    ));
  }
}

/// @nodoc

class _$HttpHeaders_ListImpl extends HttpHeaders_List {
  const _$HttpHeaders_ListImpl(final List<(String, String)> field0)
      : _field0 = field0,
        super._();

  final List<(String, String)> _field0;
  @override
  List<(String, String)> get field0 {
    if (_field0 is EqualUnmodifiableListView) return _field0;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_field0);
  }

  @override
  String toString() {
    return 'HttpHeaders.list(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpHeaders_ListImpl &&
            const DeepCollectionEquality().equals(other._field0, _field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_field0));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpHeaders_ListImplCopyWith<_$HttpHeaders_ListImpl> get copyWith =>
      __$$HttpHeaders_ListImplCopyWithImpl<_$HttpHeaders_ListImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, String> field0) map,
    required TResult Function(List<(String, String)> field0) list,
  }) {
    return list(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, String> field0)? map,
    TResult? Function(List<(String, String)> field0)? list,
  }) {
    return list?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, String> field0)? map,
    TResult Function(List<(String, String)> field0)? list,
    required TResult orElse(),
  }) {
    if (list != null) {
      return list(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpHeaders_Map value) map,
    required TResult Function(HttpHeaders_List value) list,
  }) {
    return list(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpHeaders_Map value)? map,
    TResult? Function(HttpHeaders_List value)? list,
  }) {
    return list?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpHeaders_Map value)? map,
    TResult Function(HttpHeaders_List value)? list,
    required TResult orElse(),
  }) {
    if (list != null) {
      return list(this);
    }
    return orElse();
  }
}

abstract class HttpHeaders_List extends HttpHeaders {
  const factory HttpHeaders_List(final List<(String, String)> field0) =
      _$HttpHeaders_ListImpl;
  const HttpHeaders_List._() : super._();

  @override
  List<(String, String)> get field0;
  @JsonKey(ignore: true)
  _$$HttpHeaders_ListImplCopyWith<_$HttpHeaders_ListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HttpResponseBody {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function() stream,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function()? stream,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function()? stream,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpResponseBody_Text value) text,
    required TResult Function(HttpResponseBody_Bytes value) bytes,
    required TResult Function(HttpResponseBody_Stream value) stream,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpResponseBody_Text value)? text,
    TResult? Function(HttpResponseBody_Bytes value)? bytes,
    TResult? Function(HttpResponseBody_Stream value)? stream,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpResponseBody_Text value)? text,
    TResult Function(HttpResponseBody_Bytes value)? bytes,
    TResult Function(HttpResponseBody_Stream value)? stream,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HttpResponseBodyCopyWith<$Res> {
  factory $HttpResponseBodyCopyWith(
          HttpResponseBody value, $Res Function(HttpResponseBody) then) =
      _$HttpResponseBodyCopyWithImpl<$Res, HttpResponseBody>;
}

/// @nodoc
class _$HttpResponseBodyCopyWithImpl<$Res, $Val extends HttpResponseBody>
    implements $HttpResponseBodyCopyWith<$Res> {
  _$HttpResponseBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$HttpResponseBody_TextImplCopyWith<$Res> {
  factory _$$HttpResponseBody_TextImplCopyWith(
          _$HttpResponseBody_TextImpl value,
          $Res Function(_$HttpResponseBody_TextImpl) then) =
      __$$HttpResponseBody_TextImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$HttpResponseBody_TextImplCopyWithImpl<$Res>
    extends _$HttpResponseBodyCopyWithImpl<$Res, _$HttpResponseBody_TextImpl>
    implements _$$HttpResponseBody_TextImplCopyWith<$Res> {
  __$$HttpResponseBody_TextImplCopyWithImpl(_$HttpResponseBody_TextImpl _value,
      $Res Function(_$HttpResponseBody_TextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$HttpResponseBody_TextImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HttpResponseBody_TextImpl extends HttpResponseBody_Text {
  const _$HttpResponseBody_TextImpl(this.field0) : super._();

  @override
  final String field0;

  @override
  String toString() {
    return 'HttpResponseBody.text(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpResponseBody_TextImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpResponseBody_TextImplCopyWith<_$HttpResponseBody_TextImpl>
      get copyWith => __$$HttpResponseBody_TextImplCopyWithImpl<
          _$HttpResponseBody_TextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function() stream,
  }) {
    return text(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function()? stream,
  }) {
    return text?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function()? stream,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpResponseBody_Text value) text,
    required TResult Function(HttpResponseBody_Bytes value) bytes,
    required TResult Function(HttpResponseBody_Stream value) stream,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpResponseBody_Text value)? text,
    TResult? Function(HttpResponseBody_Bytes value)? bytes,
    TResult? Function(HttpResponseBody_Stream value)? stream,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpResponseBody_Text value)? text,
    TResult Function(HttpResponseBody_Bytes value)? bytes,
    TResult Function(HttpResponseBody_Stream value)? stream,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }
}

abstract class HttpResponseBody_Text extends HttpResponseBody {
  const factory HttpResponseBody_Text(final String field0) =
      _$HttpResponseBody_TextImpl;
  const HttpResponseBody_Text._() : super._();

  String get field0;
  @JsonKey(ignore: true)
  _$$HttpResponseBody_TextImplCopyWith<_$HttpResponseBody_TextImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HttpResponseBody_BytesImplCopyWith<$Res> {
  factory _$$HttpResponseBody_BytesImplCopyWith(
          _$HttpResponseBody_BytesImpl value,
          $Res Function(_$HttpResponseBody_BytesImpl) then) =
      __$$HttpResponseBody_BytesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uint8List field0});
}

/// @nodoc
class __$$HttpResponseBody_BytesImplCopyWithImpl<$Res>
    extends _$HttpResponseBodyCopyWithImpl<$Res, _$HttpResponseBody_BytesImpl>
    implements _$$HttpResponseBody_BytesImplCopyWith<$Res> {
  __$$HttpResponseBody_BytesImplCopyWithImpl(
      _$HttpResponseBody_BytesImpl _value,
      $Res Function(_$HttpResponseBody_BytesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$HttpResponseBody_BytesImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$HttpResponseBody_BytesImpl extends HttpResponseBody_Bytes {
  const _$HttpResponseBody_BytesImpl(this.field0) : super._();

  @override
  final Uint8List field0;

  @override
  String toString() {
    return 'HttpResponseBody.bytes(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpResponseBody_BytesImpl &&
            const DeepCollectionEquality().equals(other.field0, field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(field0));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpResponseBody_BytesImplCopyWith<_$HttpResponseBody_BytesImpl>
      get copyWith => __$$HttpResponseBody_BytesImplCopyWithImpl<
          _$HttpResponseBody_BytesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function() stream,
  }) {
    return bytes(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function()? stream,
  }) {
    return bytes?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function()? stream,
    required TResult orElse(),
  }) {
    if (bytes != null) {
      return bytes(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpResponseBody_Text value) text,
    required TResult Function(HttpResponseBody_Bytes value) bytes,
    required TResult Function(HttpResponseBody_Stream value) stream,
  }) {
    return bytes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpResponseBody_Text value)? text,
    TResult? Function(HttpResponseBody_Bytes value)? bytes,
    TResult? Function(HttpResponseBody_Stream value)? stream,
  }) {
    return bytes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpResponseBody_Text value)? text,
    TResult Function(HttpResponseBody_Bytes value)? bytes,
    TResult Function(HttpResponseBody_Stream value)? stream,
    required TResult orElse(),
  }) {
    if (bytes != null) {
      return bytes(this);
    }
    return orElse();
  }
}

abstract class HttpResponseBody_Bytes extends HttpResponseBody {
  const factory HttpResponseBody_Bytes(final Uint8List field0) =
      _$HttpResponseBody_BytesImpl;
  const HttpResponseBody_Bytes._() : super._();

  Uint8List get field0;
  @JsonKey(ignore: true)
  _$$HttpResponseBody_BytesImplCopyWith<_$HttpResponseBody_BytesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HttpResponseBody_StreamImplCopyWith<$Res> {
  factory _$$HttpResponseBody_StreamImplCopyWith(
          _$HttpResponseBody_StreamImpl value,
          $Res Function(_$HttpResponseBody_StreamImpl) then) =
      __$$HttpResponseBody_StreamImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HttpResponseBody_StreamImplCopyWithImpl<$Res>
    extends _$HttpResponseBodyCopyWithImpl<$Res, _$HttpResponseBody_StreamImpl>
    implements _$$HttpResponseBody_StreamImplCopyWith<$Res> {
  __$$HttpResponseBody_StreamImplCopyWithImpl(
      _$HttpResponseBody_StreamImpl _value,
      $Res Function(_$HttpResponseBody_StreamImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$HttpResponseBody_StreamImpl extends HttpResponseBody_Stream {
  const _$HttpResponseBody_StreamImpl() : super._();

  @override
  String toString() {
    return 'HttpResponseBody.stream()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpResponseBody_StreamImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function() stream,
  }) {
    return stream();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function()? stream,
  }) {
    return stream?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function()? stream,
    required TResult orElse(),
  }) {
    if (stream != null) {
      return stream();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpResponseBody_Text value) text,
    required TResult Function(HttpResponseBody_Bytes value) bytes,
    required TResult Function(HttpResponseBody_Stream value) stream,
  }) {
    return stream(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpResponseBody_Text value)? text,
    TResult? Function(HttpResponseBody_Bytes value)? bytes,
    TResult? Function(HttpResponseBody_Stream value)? stream,
  }) {
    return stream?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpResponseBody_Text value)? text,
    TResult Function(HttpResponseBody_Bytes value)? bytes,
    TResult Function(HttpResponseBody_Stream value)? stream,
    required TResult orElse(),
  }) {
    if (stream != null) {
      return stream(this);
    }
    return orElse();
  }
}

abstract class HttpResponseBody_Stream extends HttpResponseBody {
  const factory HttpResponseBody_Stream() = _$HttpResponseBody_StreamImpl;
  const HttpResponseBody_Stream._() : super._();
}

/// @nodoc
mixin _$MultipartValue {
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function(String field0) file,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function(String field0)? file,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function(String field0)? file,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MultipartValue_Text value) text,
    required TResult Function(MultipartValue_Bytes value) bytes,
    required TResult Function(MultipartValue_File value) file,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MultipartValue_Text value)? text,
    TResult? Function(MultipartValue_Bytes value)? bytes,
    TResult? Function(MultipartValue_File value)? file,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MultipartValue_Text value)? text,
    TResult Function(MultipartValue_Bytes value)? bytes,
    TResult Function(MultipartValue_File value)? file,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultipartValueCopyWith<$Res> {
  factory $MultipartValueCopyWith(
          MultipartValue value, $Res Function(MultipartValue) then) =
      _$MultipartValueCopyWithImpl<$Res, MultipartValue>;
}

/// @nodoc
class _$MultipartValueCopyWithImpl<$Res, $Val extends MultipartValue>
    implements $MultipartValueCopyWith<$Res> {
  _$MultipartValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MultipartValue_TextImplCopyWith<$Res> {
  factory _$$MultipartValue_TextImplCopyWith(_$MultipartValue_TextImpl value,
          $Res Function(_$MultipartValue_TextImpl) then) =
      __$$MultipartValue_TextImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$MultipartValue_TextImplCopyWithImpl<$Res>
    extends _$MultipartValueCopyWithImpl<$Res, _$MultipartValue_TextImpl>
    implements _$$MultipartValue_TextImplCopyWith<$Res> {
  __$$MultipartValue_TextImplCopyWithImpl(_$MultipartValue_TextImpl _value,
      $Res Function(_$MultipartValue_TextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$MultipartValue_TextImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MultipartValue_TextImpl extends MultipartValue_Text {
  const _$MultipartValue_TextImpl(this.field0) : super._();

  @override
  final String field0;

  @override
  String toString() {
    return 'MultipartValue.text(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultipartValue_TextImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MultipartValue_TextImplCopyWith<_$MultipartValue_TextImpl> get copyWith =>
      __$$MultipartValue_TextImplCopyWithImpl<_$MultipartValue_TextImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function(String field0) file,
  }) {
    return text(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function(String field0)? file,
  }) {
    return text?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function(String field0)? file,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MultipartValue_Text value) text,
    required TResult Function(MultipartValue_Bytes value) bytes,
    required TResult Function(MultipartValue_File value) file,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MultipartValue_Text value)? text,
    TResult? Function(MultipartValue_Bytes value)? bytes,
    TResult? Function(MultipartValue_File value)? file,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MultipartValue_Text value)? text,
    TResult Function(MultipartValue_Bytes value)? bytes,
    TResult Function(MultipartValue_File value)? file,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }
}

abstract class MultipartValue_Text extends MultipartValue {
  const factory MultipartValue_Text(final String field0) =
      _$MultipartValue_TextImpl;
  const MultipartValue_Text._() : super._();

  @override
  String get field0;
  @JsonKey(ignore: true)
  _$$MultipartValue_TextImplCopyWith<_$MultipartValue_TextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MultipartValue_BytesImplCopyWith<$Res> {
  factory _$$MultipartValue_BytesImplCopyWith(_$MultipartValue_BytesImpl value,
          $Res Function(_$MultipartValue_BytesImpl) then) =
      __$$MultipartValue_BytesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uint8List field0});
}

/// @nodoc
class __$$MultipartValue_BytesImplCopyWithImpl<$Res>
    extends _$MultipartValueCopyWithImpl<$Res, _$MultipartValue_BytesImpl>
    implements _$$MultipartValue_BytesImplCopyWith<$Res> {
  __$$MultipartValue_BytesImplCopyWithImpl(_$MultipartValue_BytesImpl _value,
      $Res Function(_$MultipartValue_BytesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$MultipartValue_BytesImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$MultipartValue_BytesImpl extends MultipartValue_Bytes {
  const _$MultipartValue_BytesImpl(this.field0) : super._();

  @override
  final Uint8List field0;

  @override
  String toString() {
    return 'MultipartValue.bytes(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultipartValue_BytesImpl &&
            const DeepCollectionEquality().equals(other.field0, field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(field0));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MultipartValue_BytesImplCopyWith<_$MultipartValue_BytesImpl>
      get copyWith =>
          __$$MultipartValue_BytesImplCopyWithImpl<_$MultipartValue_BytesImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function(String field0) file,
  }) {
    return bytes(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function(String field0)? file,
  }) {
    return bytes?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function(String field0)? file,
    required TResult orElse(),
  }) {
    if (bytes != null) {
      return bytes(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MultipartValue_Text value) text,
    required TResult Function(MultipartValue_Bytes value) bytes,
    required TResult Function(MultipartValue_File value) file,
  }) {
    return bytes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MultipartValue_Text value)? text,
    TResult? Function(MultipartValue_Bytes value)? bytes,
    TResult? Function(MultipartValue_File value)? file,
  }) {
    return bytes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MultipartValue_Text value)? text,
    TResult Function(MultipartValue_Bytes value)? bytes,
    TResult Function(MultipartValue_File value)? file,
    required TResult orElse(),
  }) {
    if (bytes != null) {
      return bytes(this);
    }
    return orElse();
  }
}

abstract class MultipartValue_Bytes extends MultipartValue {
  const factory MultipartValue_Bytes(final Uint8List field0) =
      _$MultipartValue_BytesImpl;
  const MultipartValue_Bytes._() : super._();

  @override
  Uint8List get field0;
  @JsonKey(ignore: true)
  _$$MultipartValue_BytesImplCopyWith<_$MultipartValue_BytesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MultipartValue_FileImplCopyWith<$Res> {
  factory _$$MultipartValue_FileImplCopyWith(_$MultipartValue_FileImpl value,
          $Res Function(_$MultipartValue_FileImpl) then) =
      __$$MultipartValue_FileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$MultipartValue_FileImplCopyWithImpl<$Res>
    extends _$MultipartValueCopyWithImpl<$Res, _$MultipartValue_FileImpl>
    implements _$$MultipartValue_FileImplCopyWith<$Res> {
  __$$MultipartValue_FileImplCopyWithImpl(_$MultipartValue_FileImpl _value,
      $Res Function(_$MultipartValue_FileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$MultipartValue_FileImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MultipartValue_FileImpl extends MultipartValue_File {
  const _$MultipartValue_FileImpl(this.field0) : super._();

  @override
  final String field0;

  @override
  String toString() {
    return 'MultipartValue.file(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultipartValue_FileImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MultipartValue_FileImplCopyWith<_$MultipartValue_FileImpl> get copyWith =>
      __$$MultipartValue_FileImplCopyWithImpl<_$MultipartValue_FileImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function(String field0) file,
  }) {
    return file(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function(String field0)? file,
  }) {
    return file?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function(String field0)? file,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MultipartValue_Text value) text,
    required TResult Function(MultipartValue_Bytes value) bytes,
    required TResult Function(MultipartValue_File value) file,
  }) {
    return file(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MultipartValue_Text value)? text,
    TResult? Function(MultipartValue_Bytes value)? bytes,
    TResult? Function(MultipartValue_File value)? file,
  }) {
    return file?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MultipartValue_Text value)? text,
    TResult Function(MultipartValue_Bytes value)? bytes,
    TResult Function(MultipartValue_File value)? file,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(this);
    }
    return orElse();
  }
}

abstract class MultipartValue_File extends MultipartValue {
  const factory MultipartValue_File(final String field0) =
      _$MultipartValue_FileImpl;
  const MultipartValue_File._() : super._();

  @override
  String get field0;
  @JsonKey(ignore: true)
  _$$MultipartValue_FileImplCopyWith<_$MultipartValue_FileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
