import 'package:dhbwstuttgart/common/data/database_access.dart';
import 'package:dhbwstuttgart/common/data/preferences/preferences_access.dart';
import 'package:dhbwstuttgart/common/data/preferences/preferences_provider.dart';
import 'package:dhbwstuttgart/schedule/business/schedule_provider.dart';
import 'package:dhbwstuttgart/schedule/data/schedule_entry_repository.dart';
import 'package:dhbwstuttgart/schedule/data/schedule_query_information_repository.dart';
import 'package:dhbwstuttgart/schedule/service/rapla/rapla_schedule_source.dart';
import 'package:dhbwstuttgart/schedule/service/schedule_source.dart';
import 'package:kiwi/kiwi.dart';

bool _isInjected = false;

void injectServices() {
  if (_isInjected) return;

  Container c = Container();
  c.registerInstance(PreferencesProvider(PreferencesAccess()));
  c.registerInstance<ScheduleSource, RaplaScheduleSource>(
    RaplaScheduleSource(),
  );
  c.registerInstance(DatabaseAccess());
  c.registerInstance(ScheduleEntryRepository(
    c.resolve(),
  ));
  c.registerInstance(ScheduleQueryInformationRepository(
    c.resolve(),
  ));
  c.registerInstance(ScheduleProvider(
    c.resolve(),
    c.resolve(),
    c.resolve(),
  ));

  _isInjected = true;
}
