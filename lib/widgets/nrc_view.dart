import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/house_hold_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';

class NRCView extends StatefulWidget {
  const NRCView({super.key});

  @override
  NRCViewState createState() => NRCViewState();
}

class NRCViewState extends State<NRCView> {
  final List<String> _nrcTypes = ['C', 'N', 'P', 'T'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HouseHoldBloc(context),
      child: Consumer<HouseHoldBloc>(
        builder: (context, bloc, child) => InkWell(
          onTap: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => _nrcBottomsheet(bloc)),
          child: Container(
            height: kMargin45 + 1,
            padding: EdgeInsets.only(left: kMargin10, top: kMargin12),
            width: double.infinity,
            child: Text(
              'Enter NRC number',
              style: TextStyle(fontSize: kTextRegular2x),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nrcBottomsheet(HouseHoldBloc bloc) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: kMargin24, vertical: kMargin24),
          child: Column(
            children: [
              ///nrc view
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
                      decoration: BoxDecoration(
                          color: kInputBackgroundColor,
                          borderRadius: BorderRadius.circular(kMarginMedium)),
                      height: 40,
                      child: Center(
                        child: DropdownButton<String>(
                          value: bloc.selectedStateRegionCode,
                          iconDisabledColor: Colors.black,
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          menuMaxHeight: kMargin110,
                          hint: Text('1 /'),
                          underline: SizedBox(),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: kMargin5),
                          items: bloc.stateRegionCodes.map((code) {
                            return DropdownMenuItem(
                              value: code,
                              child: Text(code),
                            );
                          }).toList(),
                          onChanged: (value) {
                            bloc.getTownshipByRegionCode(value ?? '');
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Add some spacing
        
                  // Township Dropdown
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
                      decoration: BoxDecoration(
                          color: kInputBackgroundColor,
                          borderRadius: BorderRadius.circular(kMarginMedium)),
                      height: 40,
                      child: DropdownButton<String>(
                        value: bloc.selectedTownshipCode,
                        isExpanded: true,
                        menuMaxHeight: kMargin110,
                        iconDisabledColor: Colors.black,
                        iconEnabledColor: Colors.black,
                        underline: SizedBox(),
                        hint: Text('Select'),
                        alignment: Alignment.center,
                        items: bloc.selectedTownshipCodes.map((code) {
                          return DropdownMenuItem(
                            value: code,
                            child: Text(code),
                          );
                        }).toList(),
                        onChanged: (value) {
                          bloc.onChangeTownship(value ?? '');
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Add some spacing
        
                  // NRC Type Dropdown
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
                      decoration: BoxDecoration(
                          color: kInputBackgroundColor,
                          borderRadius: BorderRadius.circular(kMarginMedium)),
                      height: 40,
                      child: DropdownButton<String>(
                        value: bloc.selectedNRCType,
                        isExpanded: true,
                        hint: Text('Type'),
                        menuMaxHeight: kMargin110,
                        iconDisabledColor: Colors.black,
                        iconEnabledColor: Colors.black,
                        underline: SizedBox(),
                        alignment: Alignment.center,
                        items: _nrcTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          bloc.onChangeType(value ?? '');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              20.vGap,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter NRC number',
                    style: TextStyle(
                        fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
                  ),
                  5.vGap,
                  Container(
                    height: kSize45,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
                    decoration: BoxDecoration(
                        color: kInputBackgroundColor,
                        borderRadius: BorderRadius.circular(kMarginMedium)),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'NRC Number', border: InputBorder.none),
                    ),
                  ),
                ],
              ),
              40.vGap,
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: kSize46,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMargin10),
                      color: kDarkBlueColor),
                  child: Center(
                    child: Text(
                      kConfirmLabel,
                      style: TextStyle(
                          fontSize: kTextRegular2x,
                          fontWeight: FontWeight.w600,
                          color: kWhiteColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
