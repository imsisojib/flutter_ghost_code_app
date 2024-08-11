import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/applications/usecase_fetch_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/game_event.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/ticket.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/domain/i_repository_game_events.dart';

class ProviderGameEvents extends ChangeNotifier {
  //states
  ELoading? _loading;
  GameEvent? _event;
  Map<String, List<Ticket>> _mappedTickets = {};

  //getters
  ELoading? get loading => _loading;
  GameEvent? get event => _event;
  Map<String, List<Ticket>> get mappedTickets => _mappedTickets;

  //setters
  set loading(ELoading? state) {
    _loading = state;
    notifyListeners();
  }

  Future<void> generateTickets() async {
    loading = ELoading.submitButtonLoading;
    await sl<IRepositoryGameEvents>().generateTickets();
    loading = null;
  }

  Future<void> fetchTickets() async {
    loading = ELoading.loading;
    var result = await UseCaseFetchTickets(repositoryGameEvents: sl()).execute(Empty());
    result.fold(
      (error) {
        _event = null;
      },
      (result) {
        _event = result;
        _mappedTickets.clear();
        //sorting tickets by slot
        for(Ticket ticket in _event?.tickets??[]){
          if(_mappedTickets.containsKey(ticket.slot)){
            var tickets = _mappedTickets[ticket.slot]??[];
            tickets.add(ticket);
            _mappedTickets[ticket.slot!] = tickets;
          }else{
            _mappedTickets[ticket.slot!] = [ticket];
          }
        }
        print(_mappedTickets);
      },
    );
    loading = null;
  }
}
