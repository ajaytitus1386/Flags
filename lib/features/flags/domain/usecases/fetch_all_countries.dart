import 'package:flags_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flags_task/core/usecases/usecase.dart';
import 'package:flags_task/features/flags/data/models/country_model.dart';
import 'package:flags_task/features/flags/domain/repos/country_repo.dart';

class FetchAllCountries implements UseCase<List<CountryModel>, NoParams> {
  final CountryRepo repo;

  FetchAllCountries(this.repo);

  @override
  Future<Either<Failure, List<CountryModel>>> call(NoParams params) async {
    return await repo.fetchAllCountriesFromApi();
  }
}
