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
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) text,
    required TResult Function(Uint8List field0) bytes,
    required TResult Function(Map<String, String> field0) form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function(Map<String, String> field0)? form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function(Map<String, String> field0)? form,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpBody_Text value) text,
    required TResult Function(HttpBody_Bytes value) bytes,
    required TResult Function(HttpBody_Form value) form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpBody_Text value)? text,
    TResult? Function(HttpBody_Bytes value)? bytes,
    TResult? Function(HttpBody_Form value)? form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpBody_Text value)? text,
    TResult Function(HttpBody_Bytes value)? bytes,
    TResult Function(HttpBody_Form value)? form,
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
    required TResult Function(Map<String, String> field0) form,
  }) {
    return text(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function(Map<String, String> field0)? form,
  }) {
    return text?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function(Map<String, String> field0)? form,
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
    required TResult Function(HttpBody_Form value) form,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpBody_Text value)? text,
    TResult? Function(HttpBody_Bytes value)? bytes,
    TResult? Function(HttpBody_Form value)? form,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpBody_Text value)? text,
    TResult Function(HttpBody_Bytes value)? bytes,
    TResult Function(HttpBody_Form value)? form,
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

  @override
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
    required TResult Function(Map<String, String> field0) form,
  }) {
    return bytes(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function(Map<String, String> field0)? form,
  }) {
    return bytes?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function(Map<String, String> field0)? form,
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
    required TResult Function(HttpBody_Form value) form,
  }) {
    return bytes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpBody_Text value)? text,
    TResult? Function(HttpBody_Bytes value)? bytes,
    TResult? Function(HttpBody_Form value)? form,
  }) {
    return bytes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpBody_Text value)? text,
    TResult Function(HttpBody_Bytes value)? bytes,
    TResult Function(HttpBody_Form value)? form,
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

  @override
  Uint8List get field0;
  @JsonKey(ignore: true)
  _$$HttpBody_BytesImplCopyWith<_$HttpBody_BytesImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    required TResult Function(Map<String, String> field0) form,
  }) {
    return form(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? text,
    TResult? Function(Uint8List field0)? bytes,
    TResult? Function(Map<String, String> field0)? form,
  }) {
    return form?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? text,
    TResult Function(Uint8List field0)? bytes,
    TResult Function(Map<String, String> field0)? form,
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
    required TResult Function(HttpBody_Form value) form,
  }) {
    return form(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpBody_Text value)? text,
    TResult? Function(HttpBody_Bytes value)? bytes,
    TResult? Function(HttpBody_Form value)? form,
  }) {
    return form?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpBody_Text value)? text,
    TResult Function(HttpBody_Bytes value)? bytes,
    TResult Function(HttpBody_Form value)? form,
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

  @override
  Map<String, String> get field0;
  @JsonKey(ignore: true)
  _$$HttpBody_FormImplCopyWith<_$HttpBody_FormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HttpHeaders {
  Map<Object, String> get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<HttpHeaderName, String> field0) map,
    required TResult Function(Map<String, String> field0) rawMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<HttpHeaderName, String> field0)? map,
    TResult? Function(Map<String, String> field0)? rawMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<HttpHeaderName, String> field0)? map,
    TResult Function(Map<String, String> field0)? rawMap,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpHeaders_Map value) map,
    required TResult Function(HttpHeaders_RawMap value) rawMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpHeaders_Map value)? map,
    TResult? Function(HttpHeaders_RawMap value)? rawMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpHeaders_Map value)? map,
    TResult Function(HttpHeaders_RawMap value)? rawMap,
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
  $Res call({Map<HttpHeaderName, String> field0});
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
              as Map<HttpHeaderName, String>,
    ));
  }
}

/// @nodoc

class _$HttpHeaders_MapImpl extends HttpHeaders_Map {
  const _$HttpHeaders_MapImpl(final Map<HttpHeaderName, String> field0)
      : _field0 = field0,
        super._();

  final Map<HttpHeaderName, String> _field0;
  @override
  Map<HttpHeaderName, String> get field0 {
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
    required TResult Function(Map<HttpHeaderName, String> field0) map,
    required TResult Function(Map<String, String> field0) rawMap,
  }) {
    return map(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<HttpHeaderName, String> field0)? map,
    TResult? Function(Map<String, String> field0)? rawMap,
  }) {
    return map?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<HttpHeaderName, String> field0)? map,
    TResult Function(Map<String, String> field0)? rawMap,
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
    required TResult Function(HttpHeaders_RawMap value) rawMap,
  }) {
    return map(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpHeaders_Map value)? map,
    TResult? Function(HttpHeaders_RawMap value)? rawMap,
  }) {
    return map?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpHeaders_Map value)? map,
    TResult Function(HttpHeaders_RawMap value)? rawMap,
    required TResult orElse(),
  }) {
    if (map != null) {
      return map(this);
    }
    return orElse();
  }
}

abstract class HttpHeaders_Map extends HttpHeaders {
  const factory HttpHeaders_Map(final Map<HttpHeaderName, String> field0) =
      _$HttpHeaders_MapImpl;
  const HttpHeaders_Map._() : super._();

  @override
  Map<HttpHeaderName, String> get field0;
  @JsonKey(ignore: true)
  _$$HttpHeaders_MapImplCopyWith<_$HttpHeaders_MapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HttpHeaders_RawMapImplCopyWith<$Res> {
  factory _$$HttpHeaders_RawMapImplCopyWith(_$HttpHeaders_RawMapImpl value,
          $Res Function(_$HttpHeaders_RawMapImpl) then) =
      __$$HttpHeaders_RawMapImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, String> field0});
}

/// @nodoc
class __$$HttpHeaders_RawMapImplCopyWithImpl<$Res>
    extends _$HttpHeadersCopyWithImpl<$Res, _$HttpHeaders_RawMapImpl>
    implements _$$HttpHeaders_RawMapImplCopyWith<$Res> {
  __$$HttpHeaders_RawMapImplCopyWithImpl(_$HttpHeaders_RawMapImpl _value,
      $Res Function(_$HttpHeaders_RawMapImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$HttpHeaders_RawMapImpl(
      null == field0
          ? _value._field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

class _$HttpHeaders_RawMapImpl extends HttpHeaders_RawMap {
  const _$HttpHeaders_RawMapImpl(final Map<String, String> field0)
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
    return 'HttpHeaders.rawMap(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpHeaders_RawMapImpl &&
            const DeepCollectionEquality().equals(other._field0, _field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_field0));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpHeaders_RawMapImplCopyWith<_$HttpHeaders_RawMapImpl> get copyWith =>
      __$$HttpHeaders_RawMapImplCopyWithImpl<_$HttpHeaders_RawMapImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<HttpHeaderName, String> field0) map,
    required TResult Function(Map<String, String> field0) rawMap,
  }) {
    return rawMap(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<HttpHeaderName, String> field0)? map,
    TResult? Function(Map<String, String> field0)? rawMap,
  }) {
    return rawMap?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<HttpHeaderName, String> field0)? map,
    TResult Function(Map<String, String> field0)? rawMap,
    required TResult orElse(),
  }) {
    if (rawMap != null) {
      return rawMap(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HttpHeaders_Map value) map,
    required TResult Function(HttpHeaders_RawMap value) rawMap,
  }) {
    return rawMap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HttpHeaders_Map value)? map,
    TResult? Function(HttpHeaders_RawMap value)? rawMap,
  }) {
    return rawMap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HttpHeaders_Map value)? map,
    TResult Function(HttpHeaders_RawMap value)? rawMap,
    required TResult orElse(),
  }) {
    if (rawMap != null) {
      return rawMap(this);
    }
    return orElse();
  }
}

abstract class HttpHeaders_RawMap extends HttpHeaders {
  const factory HttpHeaders_RawMap(final Map<String, String> field0) =
      _$HttpHeaders_RawMapImpl;
  const HttpHeaders_RawMap._() : super._();

  @override
  Map<String, String> get field0;
  @JsonKey(ignore: true)
  _$$HttpHeaders_RawMapImplCopyWith<_$HttpHeaders_RawMapImpl> get copyWith =>
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
