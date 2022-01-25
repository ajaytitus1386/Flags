import 'package:flags_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flags_task/core/usecases/usecase.dart';
import 'package:flags_task/features/flags/domain/repos/country_repo.dart';

class CheckIfDataNotPersists extends UseCase<bool, NoParams> {
  final CountryRepo repo;

  CheckIfDataNotPersists(this.repo);
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repo.checkIfDataNotPersists();
  }
}
