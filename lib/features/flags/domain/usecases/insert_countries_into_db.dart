import 'package:equatable/equatable.dart';
import 'package:flags_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flags_task/core/usecases/usecase.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/domain/repos/country_repo.dart';

class InsertCountriesIntoDB extends UseCase<void, Params> {
  final CountryRepo repo;

  InsertCountriesIntoDB(this.repo);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repo.insertCountriesIntoDB(params.countries);
  }
}

class Params extends Equatable {
  final List<CountryModel> countries;

  const Params(this.countries);

  @override
  List<Object?> get props => [countries];
}
