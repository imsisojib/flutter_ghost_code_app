import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/applications/usecase_fetch_ticket_purchases.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/applications/usecase_fetch_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/applications/usecase_purchase_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/game_event.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/purchased_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/request_bodys/requestbody_purchased_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/ticket.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/domain/i_repository_game_events.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProviderGameEvents extends ChangeNotifier {
  //states
  ELoading? _loading;
  GameEvent? _event;
  Map<String, List<Ticket>> _mappedTickets = {};
  Set<Ticket> _selectedTickets = {};
  List<PurchasedTickets> _purchases = [];

  //getters
  ELoading? get loading => _loading;

  GameEvent? get event => _event;

  Map<String, List<Ticket>> get mappedTickets => _mappedTickets;

  Set<Ticket> get selectedTickets => _selectedTickets;

  List<PurchasedTickets> get purchases => _purchases;

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
    _selectedTickets.clear();
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
        for (Ticket ticket in _event?.tickets ?? []) {
          if (_mappedTickets.containsKey(ticket.slot)) {
            var tickets = _mappedTickets[ticket.slot] ?? [];
            tickets.add(ticket);
            _mappedTickets[ticket.slot!] = tickets;
          } else {
            _mappedTickets[ticket.slot!] = [ticket];
          }
        }
        print(_mappedTickets);
      },
    );
    loading = null;
  }

  void updateSelectedTicket(Ticket ticket) {
    //first find ticket index from _mappedTickets
    if (ticket.slot == null || ticket.id == null) return;

    // List<Ticket> slotWiseTickets = _mappedTickets[ticket.slot]??[];
    // int index = slotWiseTickets.indexWhere((element) => element.id==ticket.id);
    // if(index!=-1){
    //   //means found,
    //   if(slotWiseTickets[index].selected){
    //     //means, deselect this tikcet
    //     slotWiseTickets[index].selected = false;
    //   }else{
    //     //means, make selection
    //     slotWiseTickets[index].selected = true;
    //   }
    //   //update the list
    //   _mappedTickets[ticket.slot!] = slotWiseTickets;
    // }
    // notifyListeners();

    if (_selectedTickets.contains(ticket)) {
      //means, already selected-> deselect now
      _selectedTickets.remove(ticket);
    } else {
      //means, add as selected
      _selectedTickets.add(ticket);
    }

    notifyListeners();
  }

  double calculateSelectedTicketsTotal() {
    double total = 0;
    for (var element in _selectedTickets) {
      total += _event?.ticketPrice ?? 0;
    }

    return total;
  }

  Future<void> purchaseTickets(RequestBodyPurchasedTickets request) async {
    loading = ELoading.submitButtonLoading;
    var result = await UseCasePurchaseTickets(repositoryGameEvents: sl()).execute(request);
    result.fold(
      (error) {
        Fluttertoast.showToast(msg: error.message);
      },
      (message) {
        Fluttertoast.showToast(msg: message);
        Navigator.pushNamedAndRemoveUntil(sl<NavigationService>().navigatorKey.currentContext!, Routes.homeScreen, (route) => false);
      },
    );
    loading = null;
  }

  Future<void> fetchPurchasedTickets() async {
    _purchases.clear();
    loading = ELoading.fetchingData;
    var result = await UseCaseTicketPurchases(repositoryGameEvents: sl()).execute(Empty());
    result.fold(
      (error) {
        Fluttertoast.showToast(msg: error.message);
      },
      (data) {
        _purchases = data;
      },
    );
    loading = null;
  }
}
