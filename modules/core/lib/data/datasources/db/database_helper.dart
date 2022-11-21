import 'dart:async';

import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _movieTableWatchList = 'movieWatchlist';
  static const String _tvTableWatchList = 'tvWatchList';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/core.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_movieTableWatchList (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE $_tvTableWatchList (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_movieTableWatchList, movie.toJson());
  }

  Future<int> insertTvWatchlist(TvTable tv) async {
    final db = await database;
    return await db!.insert(_tvTableWatchList, tv.toJson());
  }

  Future<int> removeMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _movieTableWatchList,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> removeTvWatchlist(TvTable tv) async {
    final db = await database;
    return await db!.delete(
      _tvTableWatchList,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _movieTableWatchList,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tvTableWatchList,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_movieTableWatchList);

    return results;
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tvTableWatchList);

    return results;
  }
}
