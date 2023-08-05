import 'package:flutter/material.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/presentation/company_info/company_info_state.dart';

class ComapnyInfoViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = const CompanyInfoState();

  ComapnyInfoViewModel(this._repository, String symbol) {
    loadCompanyInfo(symbol);
  }

  CompanyInfoState get state => _state;

  Future<void> loadCompanyInfo(String symbol) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getCompanyInfo(symbol);
    result.when(success: (info) {
      _state = _state.copyWith(
        companyInfo: info,
        isLoading: false,
      );
    }, error: (e) {
      _state = state.copyWith(
        companyInfo: null,
        isLoading: false,
        errorMessage: e.toString(),
      );
    });

    notifyListeners();

    final intradayInfos = await _repository.getIntradayInfos(symbol);
    intradayInfos.when(
      success: (infos) {
        _state = state.copyWith(
          stockInfos: infos,
          isLoading: false,
          errorMessage: null,
        );
      },
      error: (e) {
        _state = state.copyWith(
          stockInfos: [],
          isLoading: false,
          errorMessage: e.toString(),
        );
      },
    );
    notifyListeners();
  }
}
