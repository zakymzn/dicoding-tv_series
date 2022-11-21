import 'package:core/data/datasources/db/database_helper.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/annotations.dart';
import 'package:http/io_client.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
