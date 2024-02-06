// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDataInfoCollection on Isar {
  IsarCollection<DataInfo> get dataInfos => this.collection();
}

const DataInfoSchema = CollectionSchema(
  name: r'DataInfo',
  id: -9204448878137503073,
  properties: {
    r'fetchedAt': PropertySchema(
      id: 0,
      name: r'fetchedAt',
      type: IsarType.string,
    ),
    r'gpa': PropertySchema(
      id: 1,
      name: r'gpa',
      type: IsarType.double,
    )
  },
  estimateSize: _dataInfoEstimateSize,
  serialize: _dataInfoSerialize,
  deserialize: _dataInfoDeserialize,
  deserializeProp: _dataInfoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dataInfoGetId,
  getLinks: _dataInfoGetLinks,
  attach: _dataInfoAttach,
  version: '3.1.0+1',
);

int _dataInfoEstimateSize(
  DataInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fetchedAt.length * 3;
  return bytesCount;
}

void _dataInfoSerialize(
  DataInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.fetchedAt);
  writer.writeDouble(offsets[1], object.gpa);
}

DataInfo _dataInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DataInfo();
  object.fetchedAt = reader.readString(offsets[0]);
  object.gpa = reader.readDouble(offsets[1]);
  object.id = id;
  return object;
}

P _dataInfoDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dataInfoGetId(DataInfo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dataInfoGetLinks(DataInfo object) {
  return [];
}

void _dataInfoAttach(IsarCollection<dynamic> col, Id id, DataInfo object) {
  object.id = id;
}

extension DataInfoQueryWhereSort on QueryBuilder<DataInfo, DataInfo, QWhere> {
  QueryBuilder<DataInfo, DataInfo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DataInfoQueryWhere on QueryBuilder<DataInfo, DataInfo, QWhereClause> {
  QueryBuilder<DataInfo, DataInfo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<DataInfo, DataInfo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterWhereClause> idBetween(
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

extension DataInfoQueryFilter
    on QueryBuilder<DataInfo, DataInfo, QFilterCondition> {
  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> fetchedAtEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fetchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> fetchedAtGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fetchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> fetchedAtLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fetchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> fetchedAtBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fetchedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> fetchedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fetchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> fetchedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fetchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> fetchedAtContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fetchedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> fetchedAtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fetchedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> fetchedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fetchedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition>
      fetchedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fetchedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> gpaEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gpa',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> gpaGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gpa',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> gpaLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gpa',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> gpaBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gpa',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DataInfo, DataInfo, QAfterFilterCondition> idBetween(
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
}

extension DataInfoQueryObject
    on QueryBuilder<DataInfo, DataInfo, QFilterCondition> {}

extension DataInfoQueryLinks
    on QueryBuilder<DataInfo, DataInfo, QFilterCondition> {}

extension DataInfoQuerySortBy on QueryBuilder<DataInfo, DataInfo, QSortBy> {
  QueryBuilder<DataInfo, DataInfo, QAfterSortBy> sortByFetchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fetchedAt', Sort.asc);
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterSortBy> sortByFetchedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fetchedAt', Sort.desc);
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterSortBy> sortByGpa() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpa', Sort.asc);
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterSortBy> sortByGpaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpa', Sort.desc);
    });
  }
}

extension DataInfoQuerySortThenBy
    on QueryBuilder<DataInfo, DataInfo, QSortThenBy> {
  QueryBuilder<DataInfo, DataInfo, QAfterSortBy> thenByFetchedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fetchedAt', Sort.asc);
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterSortBy> thenByFetchedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fetchedAt', Sort.desc);
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterSortBy> thenByGpa() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpa', Sort.asc);
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterSortBy> thenByGpaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpa', Sort.desc);
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DataInfo, DataInfo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DataInfoQueryWhereDistinct
    on QueryBuilder<DataInfo, DataInfo, QDistinct> {
  QueryBuilder<DataInfo, DataInfo, QDistinct> distinctByFetchedAt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fetchedAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DataInfo, DataInfo, QDistinct> distinctByGpa() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpa');
    });
  }
}

extension DataInfoQueryProperty
    on QueryBuilder<DataInfo, DataInfo, QQueryProperty> {
  QueryBuilder<DataInfo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DataInfo, String, QQueryOperations> fetchedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fetchedAt');
    });
  }

  QueryBuilder<DataInfo, double, QQueryOperations> gpaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpa');
    });
  }
}
