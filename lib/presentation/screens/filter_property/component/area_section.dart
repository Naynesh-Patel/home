import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../logic/cubit/filter_property/filter_property_cubit.dart';
import '../../../../logic/cubit/filter_property/filter_property_state_model.dart';
import '../../../utils/constraints.dart';

class AreaSection extends StatefulWidget {
  const AreaSection({Key? key, required this.totalArea}) : super(key: key);
  final double totalArea;

  @override
  State<AreaSection> createState() => _AreaSectionState();
}

class _AreaSectionState extends State<AreaSection> {
  RangeValues? areaValuesRange;
  double minAreaValue = 0;
  double? maxAreaValue;

  @override
  void initState() {
    super.initState();
    areaValuesRange = RangeValues(0, widget.totalArea);
    maxAreaValue = widget.totalArea;
    setInitialValue();
  }

  setInitialValue() {
    final filterCubit = context.read<FilterPropertyCubit>();
    filterCubit.minAreaChange(minAreaValue.round());
    filterCubit.maxAreaChange(maxAreaValue!.round());
  }

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<FilterPropertyCubit>();
    return BlocBuilder<FilterPropertyCubit, FilterPropertyStateModel>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RangeSlider(
                values: areaValuesRange!,
                min: 0,
                max: widget.totalArea,
                // divisions: 5,
                activeColor: primaryColor,
                inactiveColor: scaffoldBackground,

                labels: RangeLabels(areaValuesRange!.start.round().toString(),
                    areaValuesRange!.end.round().toString()),
                //labels: labels,
                onChanged: (RangeValues values) {
                  // setState(() {
                  //   // areaRangeValue = values;
                  //   areaValuesRange = values;
                  //   minAreaValue = double.parse(values.start.round()
                  //       .toString());
                  //   maxAreaValue = double.parse(values.end.round().toString());
                  //   filterCubit.minAreaChange(minAreaValue);
                  //   filterCubit.maxAreaChange(maxAreaValue!);
                  //   //print(areaValuesRange);
                  // });
                  areaValuesRange = values;
                  minAreaValue = double.parse(values.start.round().toString());
                  maxAreaValue = double.parse(values.end.round().toString());
                  filterCubit.minAreaChange(minAreaValue.round());
                  filterCubit.maxAreaChange(maxAreaValue!.round());
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: minAreaValue.toStringAsFixed(1),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              color: blackColor,
                            )),
                        TextSpan(
                          text: ' m',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                            color: blackColor,
                          ),
                        ),
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(0.0, -10.0),
                            child: const Text('2'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.0,
                    width: 10.0,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 4.0),
                    padding: const EdgeInsets.only(top: 0.0),
                    color: redColor,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: maxAreaValue!.toStringAsFixed(1),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              color: blackColor,
                            )),
                        TextSpan(
                          text: ' m',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                            color: blackColor,
                          ),
                        ),
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(0.0, -10.0),
                            child: const Text('2'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
