import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmsmobile/bloc/house_hold_bloc.dart';
import 'package:tmsmobile/bloc/owner_nrc_bloc.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';
import 'package:tmsmobile/utils/strings.dart';
import '../../data/app_data/app_data.dart';


class OwnerNrcView extends StatefulWidget {
  const OwnerNrcView({
    super.key,
  });
  @override
  NRCViewState createState() => NRCViewState();
}

class NRCViewState extends State<OwnerNrcView> {
  final List<String> _nrcTypes = ['C', 'N', 'P', 'T'];
  final _nrcTextController = TextEditingController();

  @override
  void initState() {
    var bloc = context.read<OwnerNRCBloc>();
    bloc.nrcNumber = null;
    bloc.selectedTownshipCodes = [];
    bloc.selectedStateRegionCode = null;
    bloc.selectedStateRegionCode = null;
    bloc.selectedNRCType = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OwnerNRCBloc>(
      builder: (context, bloc, child) => InkWell(
        onTap: () => showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: _nrcBottomsheet(bloc),
                )),
        child: Container(
            height: kMargin45 + 1,
            padding: EdgeInsets.only(left: kMargin10, top: kMargin12),
            width: double.infinity,
            child: Text(
              bloc.nrcNumber ?? 'Add NRC number',
              style: TextStyle(fontSize: AppData.shared.getSmallFontSize()),
            )),
      ),
    );
  }

  Widget _nrcBottomsheet(OwnerNRCBloc newbloc) {
    return Consumer<OwnerNRCBloc>(
      builder: (context, bloc, child) => SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: kMargin24, vertical: kMargin24),
            child: Column(
              children: [
                ///nrc view
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: kMarginMedium),
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
                            hint: Text('0 /'),
                            menuMaxHeight: kMargin110,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: kMarginMedium),
                        decoration: BoxDecoration(
                            color: kInputBackgroundColor,
                            borderRadius: BorderRadius.circular(kMarginMedium)),
                        height: 40,
                        child: DropdownButton<String>(
                          value: bloc.selectedTownshipCode ?? 'Select',
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
                        padding:
                            EdgeInsets.symmetric(horizontal: kMarginMedium),
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
                          fontSize: AppData.shared.getSmallFontSize(),
                          fontWeight: FontWeight.w600),
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
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        controller: _nrcTextController,
                        onChanged: (value) => bloc.onChangeNrcNumber(value),
                        decoration: InputDecoration(
                            counterText: '',
                            hintText: 'NRC Number',
                            border: InputBorder.none),
                      ),
                    ),
                    5.vGap,
                    Consumer<OwnerNRCBloc>(builder: (context, bloc, child) {
                      return AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        child: SizedBox(
                          height: bloc.isEmptyNrc == true ? null : 0,
                          child: Text(
                            '* Please Select your NRC and enter Number.',
                            style: TextStyle(
                                fontSize: kTextSmall,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                40.vGap,
                InkWell(
                  onTap: () {
                    if (bloc.isEmptyNrc == false) {
                      if (bloc.selectedStateRegionCode == null &&
                          bloc.selectedTownshipCode == null &&
                          bloc.selectedNRCType == null) {
                        ///alert
                      } else {
                        bloc.onTapConfirm(
                            '${bloc.selectedStateRegionCode}/${bloc.selectedTownshipCode}(${bloc.selectedNRCType})${_nrcTextController.text.trim()}');

                        var houseHoldBloc = context.read<HouseHoldBloc>();
                        houseHoldBloc.onChangedNrcOwner(bloc.nrcNumber ?? '');

                        _nrcTextController.clear();
                        bloc.isEmptyNrc = true;
                        Navigator.pop(context);
                      }
                    }
                  },
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
                            fontSize: AppData.shared.getSmallFontSize(),
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
      ),
    );
  }
}
