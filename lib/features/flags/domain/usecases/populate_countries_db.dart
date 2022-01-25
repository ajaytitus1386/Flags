import 'package:flags_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flags_task/core/usecases/usecase.dart';
import 'package:flags_task/features/flags/domain/repos/country_repo.dart';

class PopulateCountriesDB extends UseCase<void, NoParams> {
  final CountryRepo repo;

  PopulateCountriesDB(this.repo);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repo.populateCountriesDB();
  }
}
