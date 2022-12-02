import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/crew_in_season_detail_model.dart';
import 'package:tv_series/domain/entities/crew_in_season_detail.dart';

void main() {
  const tCrewInSeasonDetailModel = CrewInSeasonDetailModel(
    department: 'department',
    job: 'job',
    creditId: 'creditId',
    adult: true,
    gender: 1,
    id: 1,
    knownForDepartment: 'knownForDepartment',
    name: 'name',
    originalName: 'originalName',
    popularity: 1,
    profilePath: 'profilePath',
    order: 1,
    character: 'character',
  );

  final tCrewInSeasonDetail = CrewInSeasonDetail(
    department: 'department',
    job: 'job',
    creditId: 'creditId',
    adult: true,
    id: 1,
    knownForDepartment: 'knownForDepartment',
    originalName: 'originalName',
    popularity: 1,
    profilePath: 'profilePath',
    character: 'character',
  );

  test(
    'should be a subclass of Crew In Season Detail entity',
    () async {
      final result = tCrewInSeasonDetailModel.toEntity();
      expect(result, tCrewInSeasonDetail);
    },
  );
}
