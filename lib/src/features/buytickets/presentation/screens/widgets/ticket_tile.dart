import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/purchased_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/ticket.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketTile extends StatefulWidget {
  final PurchasedTickets purchasedTickets;
  final Function? onSelect;

  const TicketTile({
    super.key,
    this.onSelect,
    required this.purchasedTickets,
  });

  @override
  State<TicketTile> createState() => _TicketTileState();
}

class _TicketTileState extends State<TicketTile> {
  String _generateSerials(List<Ticket>? tickets) {
    String serial = "";
    if (tickets?.isEmpty ?? true) {
      return "Empty";
    }
    for (int i = 0; i < tickets!.length; i++) {
      serial += tickets[i].serial ?? "";
      if (i != tickets.length - 1) {
        serial += " , ";
      }
    }
    return serial;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        widget.onSelect?.call();
      },
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: 152.h,
                width: 64.w,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColorLight.withOpacity(.8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
              ),
              Positioned(
                left: -16.w,
                top: 0,
                bottom: 0,
                child: Container(
                  height: 37.h,
                  width: 28.w,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.brightness == Brightness.dark ? const Color(0xff27292D) : Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: DottedBorder(
              padding: EdgeInsets.zero,
              strokeWidth: 4.w,
              dashPattern: const [4, 4],
              radius: const Radius.circular(6),
              color: AppColors.secondaryColorLight.withOpacity(.8),
              borderType: BorderType.RRect,
              child: Container(
                height: 150.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight.withOpacity(.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Event ID: ",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.secondaryColorLight.withOpacity(.8),
                          ),
                        ),
                        Text(
                          "${widget.purchasedTickets.eventId}",
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Customer: ",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.secondaryColorLight.withOpacity(.8),
                          ),
                        ),
                        Text(
                          "${widget.purchasedTickets.customerName}, ${widget.purchasedTickets.phoneNumber}",
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Serial: ",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.secondaryColorLight.withOpacity(.8),
                          ),
                        ),
                        Text(
                          _generateSerials(widget.purchasedTickets.tickets),
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
