import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/created_by_model.dart';

void main() {
  const tCreatedByModel = CreatedByModel(
    id: 1,
    creditId: 'creditId',
    name: 'name',
    gender: 1,
    profilePath: 'profilePath',
  );

  test(
    'should have a correct data',
    () async {
      expect(tCreatedByModel, tCreatedByModel);
    },
  );
}
