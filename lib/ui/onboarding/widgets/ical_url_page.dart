import 'package:dhbwstudentapp/common/i18n/localizations.dart';
import 'package:dhbwstudentapp/ui/onboarding/viewmodels/ical_url_view_model.dart';
import 'package:dhbwstudentapp/ui/onboarding/viewmodels/onboarding_view_model_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class IcalUrlPage extends StatefulWidget {
  @override
  _IcalUrlPageState createState() => _IcalUrlPageState();
}

class _IcalUrlPageState extends State<IcalUrlPage> {
  final TextEditingController _urlTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: Center(
            child: Text(
              L.of(context).onboardingIcalPageTitle,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Divider(),
        ),
        Text(
          L.of(context).onboardingIcalPageDescription,
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: PropertyChangeConsumer(
              builder: (BuildContext context, OnboardingStepViewModel model,
                  Set<Object> _) {
                var viewModel = model as IcalUrlViewModel;

                if (_urlTextController.text != viewModel.url)
                  _urlTextController.text = viewModel.url;

                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _urlTextController,
                          decoration: InputDecoration(
                            errorText: (viewModel.urlHasError ?? false)
                                ? L.of(context).onboardingRaplaUrlInvalid
                                : null,
                            hintText: L.of(context).onboardingIcalUrlHint,
                          ),
                          onChanged: (value) {
                            viewModel.setUrl(value);
                          },
                        ),
                      ),
                      FlatButton.icon(
                        onPressed: () async {
                          await viewModel.pasteUrl();
                        },
                        icon: Icon(Icons.content_paste),
                        label: Text(
                          L.of(context).onboardingRaplaUrlPaste.toUpperCase(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
