import 'package:equatable/equatable.dart';
import 'package:flags_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flags_task/core/usecases/usecase.dart';
import 'package:flags_task/features/flags/domain/entities/country.dart';
import 'package:flags_task/features/flags/domain/repos/country_repo.dart';

class GetCountriesByRegion extends UseCase<List<Country>, RegionParams> {
  final CountryRepo repo;

  GetCountriesByRegion(this.repo);

  @override
  Future<Either<Failure, List<Country>>> call(RegionParams params) async {
    return await repo.getCountriesByRegion(params.region);
  }
}

class RegionParams extends Equatable {
  final String region;

  const RegionParams(this.region);

  @override
  List<Object?> get props => [region];
}
