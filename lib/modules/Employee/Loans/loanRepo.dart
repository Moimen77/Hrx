import 'package:hrx/data/models/LoanModel.dart';
import 'package:hrx/modules/Employee/Loans/loanServices.dart';

class AdvanceRepo {
  final AdvanceServices advanceServices;

  AdvanceRepo(this.advanceServices);

  Future<dynamic> requestAdvance(AdvanceModel advanceModel) async {
    // تحضير البيانات للإرسال
    return await advanceServices.submitAdvanceRequest(advanceModel.toJson());
  }
}
