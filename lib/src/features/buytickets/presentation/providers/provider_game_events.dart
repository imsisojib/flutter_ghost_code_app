import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/domain/i_repository_game_events.dart';

class ProviderGameEvents extends ChangeNotifier{
  //states
  ELoading? _loading;
  //getters
  ELoading? get loading => _loading;

  //setters
  set loading(ELoading? state){
    _loading = state;
    notifyListeners();
  }

  Future<void> generateTickets() async {
    loading = ELoading.submitButtonLoading;
    await sl<IRepositoryGameEvents>().generateTickets();
    loading = null;
  }
}