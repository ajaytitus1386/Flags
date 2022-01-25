import 'package:equatable/equatable.dart';
import 'package:flags_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flags_task/core/usecases/usecase.dart';
import 'package:flags_task/features/flags/domain/entities/country.dart';
import 'package:flags_task/features/flags/domain/repos/country_repo.dart';

class GetCountriesByBorders extends UseCase<List<Country>, BordersParams> {
  final CountryRepo repo;

  GetCountriesByBorders(this.repo);

  @override
  Future<Either<Failure, List<Country>>> call(BordersParams params) async {
    return await repo.getCountriesByBorders(params.borders);
  }
}

class BordersParams extends Equatable {
  final List<String> borders;

  const BordersParams(this.borders);

  @override
  List<Object?> get props => [borders];
}
