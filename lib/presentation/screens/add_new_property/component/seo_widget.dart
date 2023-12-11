import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/utils/utils.dart';
import '../../../../logic/bloc/create_property/bloc/property_create_bloc.dart';
import '../../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../widget/form_header_title.dart';

class SeoWidget extends StatelessWidget {
  const SeoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PropertyCreateBloc>();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.5,
            color: Colors.black,
          )),
      child: Column(
        children: [
          const FormHeaderTitle(title: "SEO Information"),
          Utils.verticalSpace(14.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<CreateInfoCubit, CreateInfoState>(
              builder: (context, state) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                        builder: (context, state) {
                          return TextFormField(
                            initialValue: state.seoTitle,
                            onChanged: (value) => bloc
                                .add(PropertySeoTitleEvent(seoTitle: value)),
                            decoration: const InputDecoration(
                                hintText: 'SEO Title',
                                labelText: 'SEO Title',
                                hintStyle: TextStyle(color: Colors.black38),
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                            keyboardType: TextInputType.text,
                          );
                        },
                      ),
                      Utils.verticalSpace(16),
                      BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
                        builder: (context, state) {
                          return TextFormField(
                            initialValue: state.seoMetaDescription,
                            onChanged: (value) => bloc.add(
                                PropertySeoMetaDescriptionEvent(
                                    seoMetaDescription: value)),
                            decoration: const InputDecoration(
                                hintText: 'SEO Description',
                                labelText: 'SEO Description',
                                hintStyle: TextStyle(color: Colors.black38),
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                            keyboardType: TextInputType.text,
                          );
                        },
                      ),
                    ]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
