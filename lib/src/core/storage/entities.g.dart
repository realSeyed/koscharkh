// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProfileRecordCollection on Isar {
  IsarCollection<ProfileRecord> get profileRecords => this.collection();
}

const ProfileRecordSchema = CollectionSchema(
  name: r'ProfileRecord',
  id: 4570135406082580845,
  properties: {
    r'age': PropertySchema(
      id: 0,
      name: r'age',
      type: IsarType.string,
    ),
    r'firstName': PropertySchema(
      id: 1,
      name: r'firstName',
      type: IsarType.string,
    ),
    r'lastName': PropertySchema(
      id: 2,
      name: r'lastName',
      type: IsarType.string,
    )
  },
  estimateSize: _profileRecordEstimateSize,
  serialize: _profileRecordSerialize,
  deserialize: _profileRecordDeserialize,
  deserializeProp: _profileRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _profileRecordGetId,
  getLinks: _profileRecordGetLinks,
  attach: _profileRecordAttach,
  version: '3.1.0+1',
);

int _profileRecordEstimateSize(
  ProfileRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.age.length * 3;
  bytesCount += 3 + object.firstName.length * 3;
  bytesCount += 3 + object.lastName.length * 3;
  return bytesCount;
}

void _profileRecordSerialize(
  ProfileRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.age);
  writer.writeString(offsets[1], object.firstName);
  writer.writeString(offsets[2], object.lastName);
}

ProfileRecord _profileRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProfileRecord();
  object.age = reader.readString(offsets[0]);
  object.firstName = reader.readString(offsets[1]);
  object.id = id;
  object.lastName = reader.readString(offsets[2]);
  return object;
}

P _profileRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _profileRecordGetId(ProfileRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _profileRecordGetLinks(ProfileRecord object) {
  return [];
}

void _profileRecordAttach(
    IsarCollection<dynamic> col, Id id, ProfileRecord object) {
  object.id = id;
}

extension ProfileRecordQueryWhereSort
    on QueryBuilder<ProfileRecord, ProfileRecord, QWhere> {
  QueryBuilder<ProfileRecord, ProfileRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProfileRecordQueryWhere
    on QueryBuilder<ProfileRecord, ProfileRecord, QWhereClause> {
  QueryBuilder<ProfileRecord, ProfileRecord, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProfileRecordQueryFilter
    on QueryBuilder<ProfileRecord, ProfileRecord, QFilterCondition> {
  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition> ageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      ageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition> ageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition> ageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'age',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      ageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition> ageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition> ageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition> ageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'age',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      ageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'age',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      ageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'age',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      firstNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      firstNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      firstNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      firstNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      firstNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      firstNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      firstNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      firstNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firstName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      firstNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      firstNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      lastNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      lastNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      lastNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      lastNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      lastNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      lastNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      lastNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      lastNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      lastNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterFilterCondition>
      lastNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastName',
        value: '',
      ));
    });
  }
}

extension ProfileRecordQueryObject
    on QueryBuilder<ProfileRecord, ProfileRecord, QFilterCondition> {}

extension ProfileRecordQueryLinks
    on QueryBuilder<ProfileRecord, ProfileRecord, QFilterCondition> {}

extension ProfileRecordQuerySortBy
    on QueryBuilder<ProfileRecord, ProfileRecord, QSortBy> {
  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy> sortByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy> sortByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy> sortByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy>
      sortByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy> sortByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy>
      sortByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }
}

extension ProfileRecordQuerySortThenBy
    on QueryBuilder<ProfileRecord, ProfileRecord, QSortThenBy> {
  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy> thenByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy> thenByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy> thenByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy>
      thenByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy> thenByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QAfterSortBy>
      thenByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }
}

extension ProfileRecordQueryWhereDistinct
    on QueryBuilder<ProfileRecord, ProfileRecord, QDistinct> {
  QueryBuilder<ProfileRecord, ProfileRecord, QDistinct> distinctByAge(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'age', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QDistinct> distinctByFirstName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfileRecord, ProfileRecord, QDistinct> distinctByLastName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastName', caseSensitive: caseSensitive);
    });
  }
}

extension ProfileRecordQueryProperty
    on QueryBuilder<ProfileRecord, ProfileRecord, QQueryProperty> {
  QueryBuilder<ProfileRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProfileRecord, String, QQueryOperations> ageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'age');
    });
  }

  QueryBuilder<ProfileRecord, String, QQueryOperations> firstNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstName');
    });
  }

  QueryBuilder<ProfileRecord, String, QQueryOperations> lastNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastName');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCharkhRecordCollection on Isar {
  IsarCollection<CharkhRecord> get charkhRecords => this.collection();
}

const CharkhRecordSchema = CollectionSchema(
  name: r'CharkhRecord',
  id: 2071436420640971140,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'stableId': PropertySchema(
      id: 3,
      name: r'stableId',
      type: IsarType.string,
    ),
    r'timeMinutes': PropertySchema(
      id: 4,
      name: r'timeMinutes',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _charkhRecordEstimateSize,
  serialize: _charkhRecordSerialize,
  deserialize: _charkhRecordDeserialize,
  deserializeProp: _charkhRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'stableId': IndexSchema(
      id: 8172736602419351792,
      name: r'stableId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'stableId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _charkhRecordGetId,
  getLinks: _charkhRecordGetLinks,
  attach: _charkhRecordAttach,
  version: '3.1.0+1',
);

int _charkhRecordEstimateSize(
  CharkhRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.stableId.length * 3;
  return bytesCount;
}

void _charkhRecordSerialize(
  CharkhRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.description);
  writer.writeString(offsets[2], object.name);
  writer.writeString(offsets[3], object.stableId);
  writer.writeLong(offsets[4], object.timeMinutes);
  writer.writeDateTime(offsets[5], object.updatedAt);
}

CharkhRecord _charkhRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CharkhRecord();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.description = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.name = reader.readString(offsets[2]);
  object.stableId = reader.readString(offsets[3]);
  object.timeMinutes = reader.readLong(offsets[4]);
  object.updatedAt = reader.readDateTime(offsets[5]);
  return object;
}

P _charkhRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _charkhRecordGetId(CharkhRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _charkhRecordGetLinks(CharkhRecord object) {
  return [];
}

void _charkhRecordAttach(
    IsarCollection<dynamic> col, Id id, CharkhRecord object) {
  object.id = id;
}

extension CharkhRecordByIndex on IsarCollection<CharkhRecord> {
  Future<CharkhRecord?> getByStableId(String stableId) {
    return getByIndex(r'stableId', [stableId]);
  }

  CharkhRecord? getByStableIdSync(String stableId) {
    return getByIndexSync(r'stableId', [stableId]);
  }

  Future<bool> deleteByStableId(String stableId) {
    return deleteByIndex(r'stableId', [stableId]);
  }

  bool deleteByStableIdSync(String stableId) {
    return deleteByIndexSync(r'stableId', [stableId]);
  }

  Future<List<CharkhRecord?>> getAllByStableId(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'stableId', values);
  }

  List<CharkhRecord?> getAllByStableIdSync(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'stableId', values);
  }

  Future<int> deleteAllByStableId(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'stableId', values);
  }

  int deleteAllByStableIdSync(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'stableId', values);
  }

  Future<Id> putByStableId(CharkhRecord object) {
    return putByIndex(r'stableId', object);
  }

  Id putByStableIdSync(CharkhRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'stableId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByStableId(List<CharkhRecord> objects) {
    return putAllByIndex(r'stableId', objects);
  }

  List<Id> putAllByStableIdSync(List<CharkhRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'stableId', objects, saveLinks: saveLinks);
  }
}

extension CharkhRecordQueryWhereSort
    on QueryBuilder<CharkhRecord, CharkhRecord, QWhere> {
  QueryBuilder<CharkhRecord, CharkhRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CharkhRecordQueryWhere
    on QueryBuilder<CharkhRecord, CharkhRecord, QWhereClause> {
  QueryBuilder<CharkhRecord, CharkhRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterWhereClause> stableIdEqualTo(
      String stableId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'stableId',
        value: [stableId],
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterWhereClause>
      stableIdNotEqualTo(String stableId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [],
              upper: [stableId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [stableId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [stableId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [],
              upper: [stableId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CharkhRecordQueryFilter
    on QueryBuilder<CharkhRecord, CharkhRecord, QFilterCondition> {
  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      stableIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      stableIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      stableIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      stableIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stableId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      stableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      stableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      stableIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      stableIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stableId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      stableIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stableId',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      stableIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stableId',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      timeMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      timeMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      timeMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      timeMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CharkhRecordQueryObject
    on QueryBuilder<CharkhRecord, CharkhRecord, QFilterCondition> {}

extension CharkhRecordQueryLinks
    on QueryBuilder<CharkhRecord, CharkhRecord, QFilterCondition> {}

extension CharkhRecordQuerySortBy
    on QueryBuilder<CharkhRecord, CharkhRecord, QSortBy> {
  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> sortByStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> sortByStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> sortByTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeMinutes', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy>
      sortByTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeMinutes', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CharkhRecordQuerySortThenBy
    on QueryBuilder<CharkhRecord, CharkhRecord, QSortThenBy> {
  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeMinutes', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy>
      thenByTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeMinutes', Sort.desc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CharkhRecordQueryWhereDistinct
    on QueryBuilder<CharkhRecord, CharkhRecord, QDistinct> {
  QueryBuilder<CharkhRecord, CharkhRecord, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QDistinct> distinctByStableId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stableId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QDistinct> distinctByTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeMinutes');
    });
  }

  QueryBuilder<CharkhRecord, CharkhRecord, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CharkhRecordQueryProperty
    on QueryBuilder<CharkhRecord, CharkhRecord, QQueryProperty> {
  QueryBuilder<CharkhRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CharkhRecord, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CharkhRecord, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<CharkhRecord, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CharkhRecord, String, QQueryOperations> stableIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stableId');
    });
  }

  QueryBuilder<CharkhRecord, int, QQueryOperations> timeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeMinutes');
    });
  }

  QueryBuilder<CharkhRecord, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDestinationRecordCollection on Isar {
  IsarCollection<DestinationRecord> get destinationRecords => this.collection();
}

const DestinationRecordSchema = CollectionSchema(
  name: r'DestinationRecord',
  id: -5628655307630875617,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'charkhStableId': PropertySchema(
      id: 1,
      name: r'charkhStableId',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'latitude': PropertySchema(
      id: 3,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 4,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'position': PropertySchema(
      id: 6,
      name: r'position',
      type: IsarType.long,
    ),
    r'stableId': PropertySchema(
      id: 7,
      name: r'stableId',
      type: IsarType.string,
    )
  },
  estimateSize: _destinationRecordEstimateSize,
  serialize: _destinationRecordSerialize,
  deserialize: _destinationRecordDeserialize,
  deserializeProp: _destinationRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'stableId': IndexSchema(
      id: 8172736602419351792,
      name: r'stableId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'stableId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'charkhStableId': IndexSchema(
      id: 6016995830658189940,
      name: r'charkhStableId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'charkhStableId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _destinationRecordGetId,
  getLinks: _destinationRecordGetLinks,
  attach: _destinationRecordAttach,
  version: '3.1.0+1',
);

int _destinationRecordEstimateSize(
  DestinationRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.address;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.charkhStableId.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.stableId.length * 3;
  return bytesCount;
}

void _destinationRecordSerialize(
  DestinationRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeString(offsets[1], object.charkhStableId);
  writer.writeString(offsets[2], object.description);
  writer.writeDouble(offsets[3], object.latitude);
  writer.writeDouble(offsets[4], object.longitude);
  writer.writeString(offsets[5], object.name);
  writer.writeLong(offsets[6], object.position);
  writer.writeString(offsets[7], object.stableId);
}

DestinationRecord _destinationRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DestinationRecord();
  object.address = reader.readStringOrNull(offsets[0]);
  object.charkhStableId = reader.readString(offsets[1]);
  object.description = reader.readString(offsets[2]);
  object.id = id;
  object.latitude = reader.readDoubleOrNull(offsets[3]);
  object.longitude = reader.readDoubleOrNull(offsets[4]);
  object.name = reader.readString(offsets[5]);
  object.position = reader.readLong(offsets[6]);
  object.stableId = reader.readString(offsets[7]);
  return object;
}

P _destinationRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _destinationRecordGetId(DestinationRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _destinationRecordGetLinks(
    DestinationRecord object) {
  return [];
}

void _destinationRecordAttach(
    IsarCollection<dynamic> col, Id id, DestinationRecord object) {
  object.id = id;
}

extension DestinationRecordByIndex on IsarCollection<DestinationRecord> {
  Future<DestinationRecord?> getByStableId(String stableId) {
    return getByIndex(r'stableId', [stableId]);
  }

  DestinationRecord? getByStableIdSync(String stableId) {
    return getByIndexSync(r'stableId', [stableId]);
  }

  Future<bool> deleteByStableId(String stableId) {
    return deleteByIndex(r'stableId', [stableId]);
  }

  bool deleteByStableIdSync(String stableId) {
    return deleteByIndexSync(r'stableId', [stableId]);
  }

  Future<List<DestinationRecord?>> getAllByStableId(
      List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'stableId', values);
  }

  List<DestinationRecord?> getAllByStableIdSync(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'stableId', values);
  }

  Future<int> deleteAllByStableId(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'stableId', values);
  }

  int deleteAllByStableIdSync(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'stableId', values);
  }

  Future<Id> putByStableId(DestinationRecord object) {
    return putByIndex(r'stableId', object);
  }

  Id putByStableIdSync(DestinationRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'stableId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByStableId(List<DestinationRecord> objects) {
    return putAllByIndex(r'stableId', objects);
  }

  List<Id> putAllByStableIdSync(List<DestinationRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'stableId', objects, saveLinks: saveLinks);
  }
}

extension DestinationRecordQueryWhereSort
    on QueryBuilder<DestinationRecord, DestinationRecord, QWhere> {
  QueryBuilder<DestinationRecord, DestinationRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DestinationRecordQueryWhere
    on QueryBuilder<DestinationRecord, DestinationRecord, QWhereClause> {
  QueryBuilder<DestinationRecord, DestinationRecord, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterWhereClause>
      stableIdEqualTo(String stableId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'stableId',
        value: [stableId],
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterWhereClause>
      stableIdNotEqualTo(String stableId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [],
              upper: [stableId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [stableId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [stableId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [],
              upper: [stableId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterWhereClause>
      charkhStableIdEqualTo(String charkhStableId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'charkhStableId',
        value: [charkhStableId],
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterWhereClause>
      charkhStableIdNotEqualTo(String charkhStableId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [],
              upper: [charkhStableId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [charkhStableId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [charkhStableId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [],
              upper: [charkhStableId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DestinationRecordQueryFilter
    on QueryBuilder<DestinationRecord, DestinationRecord, QFilterCondition> {
  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      charkhStableIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      charkhStableIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      charkhStableIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      charkhStableIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'charkhStableId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      charkhStableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      charkhStableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      charkhStableIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      charkhStableIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'charkhStableId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      charkhStableIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charkhStableId',
        value: '',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      charkhStableIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'charkhStableId',
        value: '',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      latitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      longitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      positionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      positionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      positionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      positionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      stableIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      stableIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      stableIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      stableIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stableId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      stableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      stableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      stableIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      stableIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stableId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      stableIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stableId',
        value: '',
      ));
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterFilterCondition>
      stableIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stableId',
        value: '',
      ));
    });
  }
}

extension DestinationRecordQueryObject
    on QueryBuilder<DestinationRecord, DestinationRecord, QFilterCondition> {}

extension DestinationRecordQueryLinks
    on QueryBuilder<DestinationRecord, DestinationRecord, QFilterCondition> {}

extension DestinationRecordQuerySortBy
    on QueryBuilder<DestinationRecord, DestinationRecord, QSortBy> {
  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByCharkhStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByCharkhStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      sortByStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.desc);
    });
  }
}

extension DestinationRecordQuerySortThenBy
    on QueryBuilder<DestinationRecord, DestinationRecord, QSortThenBy> {
  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByCharkhStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByCharkhStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.asc);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QAfterSortBy>
      thenByStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.desc);
    });
  }
}

extension DestinationRecordQueryWhereDistinct
    on QueryBuilder<DestinationRecord, DestinationRecord, QDistinct> {
  QueryBuilder<DestinationRecord, DestinationRecord, QDistinct>
      distinctByAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QDistinct>
      distinctByCharkhStableId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'charkhStableId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QDistinct>
      distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QDistinct>
      distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QDistinct>
      distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'position');
    });
  }

  QueryBuilder<DestinationRecord, DestinationRecord, QDistinct>
      distinctByStableId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stableId', caseSensitive: caseSensitive);
    });
  }
}

extension DestinationRecordQueryProperty
    on QueryBuilder<DestinationRecord, DestinationRecord, QQueryProperty> {
  QueryBuilder<DestinationRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DestinationRecord, String?, QQueryOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<DestinationRecord, String, QQueryOperations>
      charkhStableIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'charkhStableId');
    });
  }

  QueryBuilder<DestinationRecord, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<DestinationRecord, double?, QQueryOperations>
      latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<DestinationRecord, double?, QQueryOperations>
      longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<DestinationRecord, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<DestinationRecord, int, QQueryOperations> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'position');
    });
  }

  QueryBuilder<DestinationRecord, String, QQueryOperations> stableIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stableId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSavedDestinationRecordCollection on Isar {
  IsarCollection<SavedDestinationRecord> get savedDestinationRecords =>
      this.collection();
}

const SavedDestinationRecordSchema = CollectionSchema(
  name: r'SavedDestinationRecord',
  id: 8980120991637219945,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'latitude': PropertySchema(
      id: 3,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 4,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'stableId': PropertySchema(
      id: 6,
      name: r'stableId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 7,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _savedDestinationRecordEstimateSize,
  serialize: _savedDestinationRecordSerialize,
  deserialize: _savedDestinationRecordDeserialize,
  deserializeProp: _savedDestinationRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'stableId': IndexSchema(
      id: 8172736602419351792,
      name: r'stableId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'stableId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _savedDestinationRecordGetId,
  getLinks: _savedDestinationRecordGetLinks,
  attach: _savedDestinationRecordAttach,
  version: '3.1.0+1',
);

int _savedDestinationRecordEstimateSize(
  SavedDestinationRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.address;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.stableId.length * 3;
  return bytesCount;
}

void _savedDestinationRecordSerialize(
  SavedDestinationRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.description);
  writer.writeDouble(offsets[3], object.latitude);
  writer.writeDouble(offsets[4], object.longitude);
  writer.writeString(offsets[5], object.name);
  writer.writeString(offsets[6], object.stableId);
  writer.writeDateTime(offsets[7], object.updatedAt);
}

SavedDestinationRecord _savedDestinationRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SavedDestinationRecord();
  object.address = reader.readStringOrNull(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.description = reader.readString(offsets[2]);
  object.id = id;
  object.latitude = reader.readDoubleOrNull(offsets[3]);
  object.longitude = reader.readDoubleOrNull(offsets[4]);
  object.name = reader.readString(offsets[5]);
  object.stableId = reader.readString(offsets[6]);
  object.updatedAt = reader.readDateTime(offsets[7]);
  return object;
}

P _savedDestinationRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _savedDestinationRecordGetId(SavedDestinationRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _savedDestinationRecordGetLinks(
    SavedDestinationRecord object) {
  return [];
}

void _savedDestinationRecordAttach(
    IsarCollection<dynamic> col, Id id, SavedDestinationRecord object) {
  object.id = id;
}

extension SavedDestinationRecordByIndex
    on IsarCollection<SavedDestinationRecord> {
  Future<SavedDestinationRecord?> getByStableId(String stableId) {
    return getByIndex(r'stableId', [stableId]);
  }

  SavedDestinationRecord? getByStableIdSync(String stableId) {
    return getByIndexSync(r'stableId', [stableId]);
  }

  Future<bool> deleteByStableId(String stableId) {
    return deleteByIndex(r'stableId', [stableId]);
  }

  bool deleteByStableIdSync(String stableId) {
    return deleteByIndexSync(r'stableId', [stableId]);
  }

  Future<List<SavedDestinationRecord?>> getAllByStableId(
      List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'stableId', values);
  }

  List<SavedDestinationRecord?> getAllByStableIdSync(
      List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'stableId', values);
  }

  Future<int> deleteAllByStableId(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'stableId', values);
  }

  int deleteAllByStableIdSync(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'stableId', values);
  }

  Future<Id> putByStableId(SavedDestinationRecord object) {
    return putByIndex(r'stableId', object);
  }

  Id putByStableIdSync(SavedDestinationRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'stableId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByStableId(List<SavedDestinationRecord> objects) {
    return putAllByIndex(r'stableId', objects);
  }

  List<Id> putAllByStableIdSync(List<SavedDestinationRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'stableId', objects, saveLinks: saveLinks);
  }
}

extension SavedDestinationRecordQueryWhereSort
    on QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QWhere> {
  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SavedDestinationRecordQueryWhere on QueryBuilder<
    SavedDestinationRecord, SavedDestinationRecord, QWhereClause> {
  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterWhereClause> stableIdEqualTo(String stableId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'stableId',
        value: [stableId],
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterWhereClause> stableIdNotEqualTo(String stableId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [],
              upper: [stableId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [stableId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [stableId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [],
              upper: [stableId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SavedDestinationRecordQueryFilter on QueryBuilder<
    SavedDestinationRecord, SavedDestinationRecord, QFilterCondition> {
  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> addressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> addressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> addressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> addressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> addressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> addressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
          QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
          QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
          QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
          QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> latitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> longitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> stableIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> stableIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> stableIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> stableIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stableId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> stableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> stableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
          QAfterFilterCondition>
      stableIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
          QAfterFilterCondition>
      stableIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stableId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> stableIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stableId',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> stableIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stableId',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord,
      QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SavedDestinationRecordQueryObject on QueryBuilder<
    SavedDestinationRecord, SavedDestinationRecord, QFilterCondition> {}

extension SavedDestinationRecordQueryLinks on QueryBuilder<
    SavedDestinationRecord, SavedDestinationRecord, QFilterCondition> {}

extension SavedDestinationRecordQuerySortBy
    on QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QSortBy> {
  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension SavedDestinationRecordQuerySortThenBy on QueryBuilder<
    SavedDestinationRecord, SavedDestinationRecord, QSortThenBy> {
  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.desc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension SavedDestinationRecordQueryWhereDistinct
    on QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QDistinct> {
  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QDistinct>
      distinctByAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QDistinct>
      distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QDistinct>
      distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QDistinct>
      distinctByStableId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stableId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedDestinationRecord, SavedDestinationRecord, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension SavedDestinationRecordQueryProperty on QueryBuilder<
    SavedDestinationRecord, SavedDestinationRecord, QQueryProperty> {
  QueryBuilder<SavedDestinationRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SavedDestinationRecord, String?, QQueryOperations>
      addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<SavedDestinationRecord, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<SavedDestinationRecord, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<SavedDestinationRecord, double?, QQueryOperations>
      latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<SavedDestinationRecord, double?, QQueryOperations>
      longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<SavedDestinationRecord, String, QQueryOperations>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SavedDestinationRecord, String, QQueryOperations>
      stableIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stableId');
    });
  }

  QueryBuilder<SavedDestinationRecord, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRouteCacheRecordCollection on Isar {
  IsarCollection<RouteCacheRecord> get routeCacheRecords => this.collection();
}

const RouteCacheRecordSchema = CollectionSchema(
  name: r'RouteCacheRecord',
  id: 1957839759970794352,
  properties: {
    r'charkhStableId': PropertySchema(
      id: 0,
      name: r'charkhStableId',
      type: IsarType.string,
    ),
    r'distanceMeters': PropertySchema(
      id: 1,
      name: r'distanceMeters',
      type: IsarType.double,
    ),
    r'durationSeconds': PropertySchema(
      id: 2,
      name: r'durationSeconds',
      type: IsarType.long,
    ),
    r'latitudes': PropertySchema(
      id: 3,
      name: r'latitudes',
      type: IsarType.doubleList,
    ),
    r'longitudes': PropertySchema(
      id: 4,
      name: r'longitudes',
      type: IsarType.doubleList,
    ),
    r'source': PropertySchema(
      id: 5,
      name: r'source',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 6,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _routeCacheRecordEstimateSize,
  serialize: _routeCacheRecordSerialize,
  deserialize: _routeCacheRecordDeserialize,
  deserializeProp: _routeCacheRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'charkhStableId': IndexSchema(
      id: 6016995830658189940,
      name: r'charkhStableId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'charkhStableId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _routeCacheRecordGetId,
  getLinks: _routeCacheRecordGetLinks,
  attach: _routeCacheRecordAttach,
  version: '3.1.0+1',
);

int _routeCacheRecordEstimateSize(
  RouteCacheRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.charkhStableId.length * 3;
  bytesCount += 3 + object.latitudes.length * 8;
  bytesCount += 3 + object.longitudes.length * 8;
  bytesCount += 3 + object.source.length * 3;
  return bytesCount;
}

void _routeCacheRecordSerialize(
  RouteCacheRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.charkhStableId);
  writer.writeDouble(offsets[1], object.distanceMeters);
  writer.writeLong(offsets[2], object.durationSeconds);
  writer.writeDoubleList(offsets[3], object.latitudes);
  writer.writeDoubleList(offsets[4], object.longitudes);
  writer.writeString(offsets[5], object.source);
  writer.writeDateTime(offsets[6], object.updatedAt);
}

RouteCacheRecord _routeCacheRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RouteCacheRecord();
  object.charkhStableId = reader.readString(offsets[0]);
  object.distanceMeters = reader.readDouble(offsets[1]);
  object.durationSeconds = reader.readLong(offsets[2]);
  object.id = id;
  object.latitudes = reader.readDoubleList(offsets[3]) ?? [];
  object.longitudes = reader.readDoubleList(offsets[4]) ?? [];
  object.source = reader.readString(offsets[5]);
  object.updatedAt = reader.readDateTime(offsets[6]);
  return object;
}

P _routeCacheRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 4:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _routeCacheRecordGetId(RouteCacheRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _routeCacheRecordGetLinks(RouteCacheRecord object) {
  return [];
}

void _routeCacheRecordAttach(
    IsarCollection<dynamic> col, Id id, RouteCacheRecord object) {
  object.id = id;
}

extension RouteCacheRecordByIndex on IsarCollection<RouteCacheRecord> {
  Future<RouteCacheRecord?> getByCharkhStableId(String charkhStableId) {
    return getByIndex(r'charkhStableId', [charkhStableId]);
  }

  RouteCacheRecord? getByCharkhStableIdSync(String charkhStableId) {
    return getByIndexSync(r'charkhStableId', [charkhStableId]);
  }

  Future<bool> deleteByCharkhStableId(String charkhStableId) {
    return deleteByIndex(r'charkhStableId', [charkhStableId]);
  }

  bool deleteByCharkhStableIdSync(String charkhStableId) {
    return deleteByIndexSync(r'charkhStableId', [charkhStableId]);
  }

  Future<List<RouteCacheRecord?>> getAllByCharkhStableId(
      List<String> charkhStableIdValues) {
    final values = charkhStableIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'charkhStableId', values);
  }

  List<RouteCacheRecord?> getAllByCharkhStableIdSync(
      List<String> charkhStableIdValues) {
    final values = charkhStableIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'charkhStableId', values);
  }

  Future<int> deleteAllByCharkhStableId(List<String> charkhStableIdValues) {
    final values = charkhStableIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'charkhStableId', values);
  }

  int deleteAllByCharkhStableIdSync(List<String> charkhStableIdValues) {
    final values = charkhStableIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'charkhStableId', values);
  }

  Future<Id> putByCharkhStableId(RouteCacheRecord object) {
    return putByIndex(r'charkhStableId', object);
  }

  Id putByCharkhStableIdSync(RouteCacheRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'charkhStableId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCharkhStableId(List<RouteCacheRecord> objects) {
    return putAllByIndex(r'charkhStableId', objects);
  }

  List<Id> putAllByCharkhStableIdSync(List<RouteCacheRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'charkhStableId', objects, saveLinks: saveLinks);
  }
}

extension RouteCacheRecordQueryWhereSort
    on QueryBuilder<RouteCacheRecord, RouteCacheRecord, QWhere> {
  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RouteCacheRecordQueryWhere
    on QueryBuilder<RouteCacheRecord, RouteCacheRecord, QWhereClause> {
  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterWhereClause>
      charkhStableIdEqualTo(String charkhStableId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'charkhStableId',
        value: [charkhStableId],
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterWhereClause>
      charkhStableIdNotEqualTo(String charkhStableId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [],
              upper: [charkhStableId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [charkhStableId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [charkhStableId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [],
              upper: [charkhStableId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RouteCacheRecordQueryFilter
    on QueryBuilder<RouteCacheRecord, RouteCacheRecord, QFilterCondition> {
  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      charkhStableIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      charkhStableIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      charkhStableIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      charkhStableIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'charkhStableId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      charkhStableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      charkhStableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      charkhStableIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      charkhStableIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'charkhStableId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      charkhStableIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charkhStableId',
        value: '',
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      charkhStableIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'charkhStableId',
        value: '',
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      distanceMetersEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanceMeters',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      distanceMetersGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanceMeters',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      distanceMetersLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanceMeters',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      distanceMetersBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanceMeters',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      durationSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      durationSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      durationSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      durationSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      latitudesElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitudes',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      latitudesElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitudes',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      latitudesElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitudes',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      latitudesElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitudes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      latitudesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'latitudes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      latitudesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'latitudes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      latitudesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'latitudes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      latitudesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'latitudes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      latitudesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'latitudes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      latitudesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'latitudes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      longitudesElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitudes',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      longitudesElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitudes',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      longitudesElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitudes',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      longitudesElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitudes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      longitudesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'longitudes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      longitudesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'longitudes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      longitudesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'longitudes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      longitudesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'longitudes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      longitudesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'longitudes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      longitudesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'longitudes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      sourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      sourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      sourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      sourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RouteCacheRecordQueryObject
    on QueryBuilder<RouteCacheRecord, RouteCacheRecord, QFilterCondition> {}

extension RouteCacheRecordQueryLinks
    on QueryBuilder<RouteCacheRecord, RouteCacheRecord, QFilterCondition> {}

extension RouteCacheRecordQuerySortBy
    on QueryBuilder<RouteCacheRecord, RouteCacheRecord, QSortBy> {
  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      sortByCharkhStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      sortByCharkhStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.desc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      sortByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      sortByDistanceMetersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.desc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      sortByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      sortByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension RouteCacheRecordQuerySortThenBy
    on QueryBuilder<RouteCacheRecord, RouteCacheRecord, QSortThenBy> {
  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenByCharkhStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenByCharkhStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.desc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenByDistanceMetersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.desc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension RouteCacheRecordQueryWhereDistinct
    on QueryBuilder<RouteCacheRecord, RouteCacheRecord, QDistinct> {
  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QDistinct>
      distinctByCharkhStableId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'charkhStableId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QDistinct>
      distinctByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceMeters');
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QDistinct>
      distinctByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationSeconds');
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QDistinct>
      distinctByLatitudes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitudes');
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QDistinct>
      distinctByLongitudes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitudes');
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QDistinct> distinctBySource(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RouteCacheRecord, RouteCacheRecord, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension RouteCacheRecordQueryProperty
    on QueryBuilder<RouteCacheRecord, RouteCacheRecord, QQueryProperty> {
  QueryBuilder<RouteCacheRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RouteCacheRecord, String, QQueryOperations>
      charkhStableIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'charkhStableId');
    });
  }

  QueryBuilder<RouteCacheRecord, double, QQueryOperations>
      distanceMetersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceMeters');
    });
  }

  QueryBuilder<RouteCacheRecord, int, QQueryOperations>
      durationSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationSeconds');
    });
  }

  QueryBuilder<RouteCacheRecord, List<double>, QQueryOperations>
      latitudesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitudes');
    });
  }

  QueryBuilder<RouteCacheRecord, List<double>, QQueryOperations>
      longitudesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitudes');
    });
  }

  QueryBuilder<RouteCacheRecord, String, QQueryOperations> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<RouteCacheRecord, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetActiveRouteRecordCollection on Isar {
  IsarCollection<ActiveRouteRecord> get activeRouteRecords => this.collection();
}

const ActiveRouteRecordSchema = CollectionSchema(
  name: r'ActiveRouteRecord',
  id: 4819511070305441388,
  properties: {
    r'charkhStableId': PropertySchema(
      id: 0,
      name: r'charkhStableId',
      type: IsarType.string,
    ),
    r'currentDestinationIndex': PropertySchema(
      id: 1,
      name: r'currentDestinationIndex',
      type: IsarType.long,
    ),
    r'elapsedSeconds': PropertySchema(
      id: 2,
      name: r'elapsedSeconds',
      type: IsarType.long,
    ),
    r'etaSeconds': PropertySchema(
      id: 3,
      name: r'etaSeconds',
      type: IsarType.long,
    ),
    r'startedAt': PropertySchema(
      id: 4,
      name: r'startedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _activeRouteRecordEstimateSize,
  serialize: _activeRouteRecordSerialize,
  deserialize: _activeRouteRecordDeserialize,
  deserializeProp: _activeRouteRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _activeRouteRecordGetId,
  getLinks: _activeRouteRecordGetLinks,
  attach: _activeRouteRecordAttach,
  version: '3.1.0+1',
);

int _activeRouteRecordEstimateSize(
  ActiveRouteRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.charkhStableId.length * 3;
  return bytesCount;
}

void _activeRouteRecordSerialize(
  ActiveRouteRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.charkhStableId);
  writer.writeLong(offsets[1], object.currentDestinationIndex);
  writer.writeLong(offsets[2], object.elapsedSeconds);
  writer.writeLong(offsets[3], object.etaSeconds);
  writer.writeDateTime(offsets[4], object.startedAt);
}

ActiveRouteRecord _activeRouteRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ActiveRouteRecord();
  object.charkhStableId = reader.readString(offsets[0]);
  object.currentDestinationIndex = reader.readLong(offsets[1]);
  object.elapsedSeconds = reader.readLong(offsets[2]);
  object.etaSeconds = reader.readLong(offsets[3]);
  object.id = id;
  object.startedAt = reader.readDateTime(offsets[4]);
  return object;
}

P _activeRouteRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _activeRouteRecordGetId(ActiveRouteRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _activeRouteRecordGetLinks(
    ActiveRouteRecord object) {
  return [];
}

void _activeRouteRecordAttach(
    IsarCollection<dynamic> col, Id id, ActiveRouteRecord object) {
  object.id = id;
}

extension ActiveRouteRecordQueryWhereSort
    on QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QWhere> {
  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ActiveRouteRecordQueryWhere
    on QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QWhereClause> {
  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActiveRouteRecordQueryFilter
    on QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QFilterCondition> {
  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      charkhStableIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      charkhStableIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      charkhStableIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      charkhStableIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'charkhStableId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      charkhStableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      charkhStableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      charkhStableIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      charkhStableIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'charkhStableId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      charkhStableIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charkhStableId',
        value: '',
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      charkhStableIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'charkhStableId',
        value: '',
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      currentDestinationIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentDestinationIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      currentDestinationIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentDestinationIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      currentDestinationIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentDestinationIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      currentDestinationIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentDestinationIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      elapsedSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'elapsedSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      elapsedSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'elapsedSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      elapsedSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'elapsedSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      elapsedSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'elapsedSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      etaSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'etaSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      etaSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'etaSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      etaSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'etaSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      etaSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'etaSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      startedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      startedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      startedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterFilterCondition>
      startedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActiveRouteRecordQueryObject
    on QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QFilterCondition> {}

extension ActiveRouteRecordQueryLinks
    on QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QFilterCondition> {}

extension ActiveRouteRecordQuerySortBy
    on QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QSortBy> {
  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      sortByCharkhStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      sortByCharkhStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.desc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      sortByCurrentDestinationIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDestinationIndex', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      sortByCurrentDestinationIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDestinationIndex', Sort.desc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      sortByElapsedSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'elapsedSeconds', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      sortByElapsedSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'elapsedSeconds', Sort.desc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      sortByEtaSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etaSeconds', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      sortByEtaSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etaSeconds', Sort.desc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      sortByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      sortByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }
}

extension ActiveRouteRecordQuerySortThenBy
    on QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QSortThenBy> {
  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByCharkhStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByCharkhStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.desc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByCurrentDestinationIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDestinationIndex', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByCurrentDestinationIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDestinationIndex', Sort.desc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByElapsedSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'elapsedSeconds', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByElapsedSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'elapsedSeconds', Sort.desc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByEtaSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etaSeconds', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByEtaSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etaSeconds', Sort.desc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QAfterSortBy>
      thenByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }
}

extension ActiveRouteRecordQueryWhereDistinct
    on QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QDistinct> {
  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QDistinct>
      distinctByCharkhStableId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'charkhStableId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QDistinct>
      distinctByCurrentDestinationIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentDestinationIndex');
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QDistinct>
      distinctByElapsedSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'elapsedSeconds');
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QDistinct>
      distinctByEtaSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'etaSeconds');
    });
  }

  QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QDistinct>
      distinctByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startedAt');
    });
  }
}

extension ActiveRouteRecordQueryProperty
    on QueryBuilder<ActiveRouteRecord, ActiveRouteRecord, QQueryProperty> {
  QueryBuilder<ActiveRouteRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ActiveRouteRecord, String, QQueryOperations>
      charkhStableIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'charkhStableId');
    });
  }

  QueryBuilder<ActiveRouteRecord, int, QQueryOperations>
      currentDestinationIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentDestinationIndex');
    });
  }

  QueryBuilder<ActiveRouteRecord, int, QQueryOperations>
      elapsedSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'elapsedSeconds');
    });
  }

  QueryBuilder<ActiveRouteRecord, int, QQueryOperations> etaSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'etaSeconds');
    });
  }

  QueryBuilder<ActiveRouteRecord, DateTime, QQueryOperations>
      startedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCharkhHistoryRecordCollection on Isar {
  IsarCollection<CharkhHistoryRecord> get charkhHistoryRecords =>
      this.collection();
}

const CharkhHistoryRecordSchema = CollectionSchema(
  name: r'CharkhHistoryRecord',
  id: -8601491083629173624,
  properties: {
    r'charkhName': PropertySchema(
      id: 0,
      name: r'charkhName',
      type: IsarType.string,
    ),
    r'charkhStableId': PropertySchema(
      id: 1,
      name: r'charkhStableId',
      type: IsarType.string,
    ),
    r'completedAt': PropertySchema(
      id: 2,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'destinationCount': PropertySchema(
      id: 3,
      name: r'destinationCount',
      type: IsarType.long,
    ),
    r'elapsedSeconds': PropertySchema(
      id: 4,
      name: r'elapsedSeconds',
      type: IsarType.long,
    ),
    r'etaSeconds': PropertySchema(
      id: 5,
      name: r'etaSeconds',
      type: IsarType.long,
    ),
    r'finalDestinationName': PropertySchema(
      id: 6,
      name: r'finalDestinationName',
      type: IsarType.string,
    ),
    r'stableId': PropertySchema(
      id: 7,
      name: r'stableId',
      type: IsarType.string,
    ),
    r'startedAt': PropertySchema(
      id: 8,
      name: r'startedAt',
      type: IsarType.dateTime,
    ),
    r'userName': PropertySchema(
      id: 9,
      name: r'userName',
      type: IsarType.string,
    )
  },
  estimateSize: _charkhHistoryRecordEstimateSize,
  serialize: _charkhHistoryRecordSerialize,
  deserialize: _charkhHistoryRecordDeserialize,
  deserializeProp: _charkhHistoryRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'stableId': IndexSchema(
      id: 8172736602419351792,
      name: r'stableId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'stableId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'charkhStableId': IndexSchema(
      id: 6016995830658189940,
      name: r'charkhStableId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'charkhStableId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _charkhHistoryRecordGetId,
  getLinks: _charkhHistoryRecordGetLinks,
  attach: _charkhHistoryRecordAttach,
  version: '3.1.0+1',
);

int _charkhHistoryRecordEstimateSize(
  CharkhHistoryRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.charkhName.length * 3;
  bytesCount += 3 + object.charkhStableId.length * 3;
  {
    final value = object.finalDestinationName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.stableId.length * 3;
  bytesCount += 3 + object.userName.length * 3;
  return bytesCount;
}

void _charkhHistoryRecordSerialize(
  CharkhHistoryRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.charkhName);
  writer.writeString(offsets[1], object.charkhStableId);
  writer.writeDateTime(offsets[2], object.completedAt);
  writer.writeLong(offsets[3], object.destinationCount);
  writer.writeLong(offsets[4], object.elapsedSeconds);
  writer.writeLong(offsets[5], object.etaSeconds);
  writer.writeString(offsets[6], object.finalDestinationName);
  writer.writeString(offsets[7], object.stableId);
  writer.writeDateTime(offsets[8], object.startedAt);
  writer.writeString(offsets[9], object.userName);
}

CharkhHistoryRecord _charkhHistoryRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CharkhHistoryRecord();
  object.charkhName = reader.readString(offsets[0]);
  object.charkhStableId = reader.readString(offsets[1]);
  object.completedAt = reader.readDateTime(offsets[2]);
  object.destinationCount = reader.readLong(offsets[3]);
  object.elapsedSeconds = reader.readLong(offsets[4]);
  object.etaSeconds = reader.readLong(offsets[5]);
  object.finalDestinationName = reader.readStringOrNull(offsets[6]);
  object.id = id;
  object.stableId = reader.readString(offsets[7]);
  object.startedAt = reader.readDateTime(offsets[8]);
  object.userName = reader.readString(offsets[9]);
  return object;
}

P _charkhHistoryRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _charkhHistoryRecordGetId(CharkhHistoryRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _charkhHistoryRecordGetLinks(
    CharkhHistoryRecord object) {
  return [];
}

void _charkhHistoryRecordAttach(
    IsarCollection<dynamic> col, Id id, CharkhHistoryRecord object) {
  object.id = id;
}

extension CharkhHistoryRecordByIndex on IsarCollection<CharkhHistoryRecord> {
  Future<CharkhHistoryRecord?> getByStableId(String stableId) {
    return getByIndex(r'stableId', [stableId]);
  }

  CharkhHistoryRecord? getByStableIdSync(String stableId) {
    return getByIndexSync(r'stableId', [stableId]);
  }

  Future<bool> deleteByStableId(String stableId) {
    return deleteByIndex(r'stableId', [stableId]);
  }

  bool deleteByStableIdSync(String stableId) {
    return deleteByIndexSync(r'stableId', [stableId]);
  }

  Future<List<CharkhHistoryRecord?>> getAllByStableId(
      List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'stableId', values);
  }

  List<CharkhHistoryRecord?> getAllByStableIdSync(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'stableId', values);
  }

  Future<int> deleteAllByStableId(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'stableId', values);
  }

  int deleteAllByStableIdSync(List<String> stableIdValues) {
    final values = stableIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'stableId', values);
  }

  Future<Id> putByStableId(CharkhHistoryRecord object) {
    return putByIndex(r'stableId', object);
  }

  Id putByStableIdSync(CharkhHistoryRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'stableId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByStableId(List<CharkhHistoryRecord> objects) {
    return putAllByIndex(r'stableId', objects);
  }

  List<Id> putAllByStableIdSync(List<CharkhHistoryRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'stableId', objects, saveLinks: saveLinks);
  }
}

extension CharkhHistoryRecordQueryWhereSort
    on QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QWhere> {
  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CharkhHistoryRecordQueryWhere
    on QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QWhereClause> {
  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterWhereClause>
      stableIdEqualTo(String stableId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'stableId',
        value: [stableId],
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterWhereClause>
      stableIdNotEqualTo(String stableId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [],
              upper: [stableId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [stableId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [stableId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'stableId',
              lower: [],
              upper: [stableId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterWhereClause>
      charkhStableIdEqualTo(String charkhStableId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'charkhStableId',
        value: [charkhStableId],
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterWhereClause>
      charkhStableIdNotEqualTo(String charkhStableId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [],
              upper: [charkhStableId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [charkhStableId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [charkhStableId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'charkhStableId',
              lower: [],
              upper: [charkhStableId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CharkhHistoryRecordQueryFilter on QueryBuilder<CharkhHistoryRecord,
    CharkhHistoryRecord, QFilterCondition> {
  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charkhName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'charkhName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'charkhName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'charkhName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'charkhName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'charkhName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'charkhName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'charkhName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charkhName',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'charkhName',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhStableIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhStableIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhStableIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhStableIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'charkhStableId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhStableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhStableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhStableIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'charkhStableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhStableIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'charkhStableId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhStableIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charkhStableId',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      charkhStableIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'charkhStableId',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      completedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      completedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      completedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      destinationCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'destinationCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      destinationCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'destinationCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      destinationCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'destinationCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      destinationCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'destinationCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      elapsedSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'elapsedSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      elapsedSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'elapsedSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      elapsedSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'elapsedSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      elapsedSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'elapsedSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      etaSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'etaSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      etaSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'etaSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      etaSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'etaSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      etaSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'etaSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'finalDestinationName',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'finalDestinationName',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finalDestinationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finalDestinationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finalDestinationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finalDestinationName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'finalDestinationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'finalDestinationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'finalDestinationName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'finalDestinationName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finalDestinationName',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      finalDestinationNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'finalDestinationName',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      stableIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      stableIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      stableIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      stableIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stableId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      stableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      stableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      stableIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      stableIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stableId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      stableIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stableId',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      stableIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stableId',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      startedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      startedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      startedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      startedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      userNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      userNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      userNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      userNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      userNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      userNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      userNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      userNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      userNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterFilterCondition>
      userNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userName',
        value: '',
      ));
    });
  }
}

extension CharkhHistoryRecordQueryObject on QueryBuilder<CharkhHistoryRecord,
    CharkhHistoryRecord, QFilterCondition> {}

extension CharkhHistoryRecordQueryLinks on QueryBuilder<CharkhHistoryRecord,
    CharkhHistoryRecord, QFilterCondition> {}

extension CharkhHistoryRecordQuerySortBy
    on QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QSortBy> {
  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByCharkhName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhName', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByCharkhNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhName', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByCharkhStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByCharkhStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByDestinationCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationCount', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByDestinationCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationCount', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByElapsedSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'elapsedSeconds', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByElapsedSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'elapsedSeconds', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByEtaSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etaSeconds', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByEtaSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etaSeconds', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByFinalDestinationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalDestinationName', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByFinalDestinationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalDestinationName', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      sortByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension CharkhHistoryRecordQuerySortThenBy
    on QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QSortThenBy> {
  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByCharkhName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhName', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByCharkhNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhName', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByCharkhStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByCharkhStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charkhStableId', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByDestinationCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationCount', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByDestinationCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'destinationCount', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByElapsedSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'elapsedSeconds', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByElapsedSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'elapsedSeconds', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByEtaSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etaSeconds', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByEtaSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'etaSeconds', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByFinalDestinationName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalDestinationName', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByFinalDestinationNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalDestinationName', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByStableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByStableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stableId', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QAfterSortBy>
      thenByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension CharkhHistoryRecordQueryWhereDistinct
    on QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct> {
  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct>
      distinctByCharkhName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'charkhName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct>
      distinctByCharkhStableId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'charkhStableId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct>
      distinctByDestinationCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'destinationCount');
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct>
      distinctByElapsedSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'elapsedSeconds');
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct>
      distinctByEtaSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'etaSeconds');
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct>
      distinctByFinalDestinationName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finalDestinationName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct>
      distinctByStableId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stableId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct>
      distinctByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startedAt');
    });
  }

  QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QDistinct>
      distinctByUserName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userName', caseSensitive: caseSensitive);
    });
  }
}

extension CharkhHistoryRecordQueryProperty
    on QueryBuilder<CharkhHistoryRecord, CharkhHistoryRecord, QQueryProperty> {
  QueryBuilder<CharkhHistoryRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CharkhHistoryRecord, String, QQueryOperations>
      charkhNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'charkhName');
    });
  }

  QueryBuilder<CharkhHistoryRecord, String, QQueryOperations>
      charkhStableIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'charkhStableId');
    });
  }

  QueryBuilder<CharkhHistoryRecord, DateTime, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<CharkhHistoryRecord, int, QQueryOperations>
      destinationCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'destinationCount');
    });
  }

  QueryBuilder<CharkhHistoryRecord, int, QQueryOperations>
      elapsedSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'elapsedSeconds');
    });
  }

  QueryBuilder<CharkhHistoryRecord, int, QQueryOperations>
      etaSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'etaSeconds');
    });
  }

  QueryBuilder<CharkhHistoryRecord, String?, QQueryOperations>
      finalDestinationNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finalDestinationName');
    });
  }

  QueryBuilder<CharkhHistoryRecord, String, QQueryOperations>
      stableIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stableId');
    });
  }

  QueryBuilder<CharkhHistoryRecord, DateTime, QQueryOperations>
      startedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startedAt');
    });
  }

  QueryBuilder<CharkhHistoryRecord, String, QQueryOperations>
      userNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userName');
    });
  }
}
