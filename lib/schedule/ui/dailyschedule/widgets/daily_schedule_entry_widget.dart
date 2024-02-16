import 'package:dhbwstudentapp/common/i18n/localizations.dart';
import 'package:dhbwstudentapp/common/ui/colors.dart';
import 'package:dhbwstudentapp/common/ui/schedule_entry_type_mappings.dart';
import 'package:dhbwstudentapp/common/ui/text_styles.dart';
import 'package:dhbwstudentapp/schedule/model/schedule_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/ui/hex_color.dart';

class DailyScheduleEntryWidget extends StatelessWidget {
  final ScheduleEntry scheduleEntry;

  const DailyScheduleEntryWidget({Key key, this.scheduleEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (scheduleEntry == null) return Container();

    var timeFormatter = DateFormat.Hm(L.of(context).locale.languageCode);

    var startTime = timeFormatter.format(scheduleEntry.start);
    var endTime = timeFormatter.format(scheduleEntry.end);

    Color color;

    if (scheduleEntry.color != null && scheduleEntry.color.isNotEmpty) {
      color = HexColor.fromHex(scheduleEntry.color);
    }else{
      color = scheduleEntryTypeToColor(context, scheduleEntry.type);
    }

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    startTime,
                    style: textStyleDailyScheduleEntryWidgetTimeStart(context),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        width: 1,
                        color: colorDailyScheduleTimeVerticalConnector(),
                      ),
                    ),
                  ),
                  Text(
                    endTime,
                    style: textStyleDailyScheduleEntryWidgetTimeEnd(context),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Card(
              margin: const EdgeInsets.all(0),
              elevation: 8,
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Text(
                        scheduleEntry.title,
                        style: textStyleDailyScheduleEntryWidgetTitle(context),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              scheduleEntry.professor,
                              style: textStyleDailyScheduleEntryWidgetProfessor(
                                  context),
                            ),
                            Text(
                              scheduleEntryTypeToReadableString(
                                  context, scheduleEntry.type),
                              style: textStyleDailyScheduleEntryWidgetType(
                                  context),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                            child: Text(
                              scheduleEntry.room ?? "",
                              softWrap: true,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),
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
