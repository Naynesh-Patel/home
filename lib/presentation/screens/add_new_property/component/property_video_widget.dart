import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/create_property/property_video_dto.dart';
import '../../../../logic/bloc/create_property/bloc/property_create_bloc.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/error_text.dart';
import '../../../widget/form_header_title.dart';
import '../../profile/component/person_single_property.dart';

class PropertyVideoWidget extends StatefulWidget {
  const PropertyVideoWidget({super.key});

  @override
  State<PropertyVideoWidget> createState() => _PropertyVideoWidgetState();
}

class _PropertyVideoWidgetState extends State<PropertyVideoWidget> {
  String thumbImage = KImages.placeholderImage;
  String videoId = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PropertyCreateBloc>();
    return BlocBuilder<PropertyCreateBloc, PropertyCreateModel>(
      builder: (context, state) {
        final imageItem = state.propertyVideoDto.videoThumbnail;
        videoId = state.propertyVideoDto.videoId;
        description = state.propertyVideoDto.videoDescription;
        thumbImage = imageItem.isEmpty ? KImages.placeholderImage : imageItem;

        bool isFile = imageItem.isNotEmpty
            ? imageItem.contains('https://')
                ? false
                : true
            : false;

        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 0.5,
                color: Colors.black,
              )),
          child: Column(
            children: [
              const FormHeaderTitle(title: "Property Video"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextStyle(text: "Video Thumbnail Image"),
                    Utils.verticalSpace(14.0),
                    Container(
                      height: 170.h,
                      decoration: BoxDecoration(
                          color: const Color(0xffF5F4FF),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 0.2,
                            color: Colors.grey,
                          )),
                      child: Stack(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CustomImage(
                                path: thumbImage,
                                height: imageItem.isEmpty ? 60 : 170,
                                width: double.infinity,
                                fit: imageItem.isEmpty
                                    ? BoxFit.contain
                                    : BoxFit.cover,
                                isFile: isFile,
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                  onTap: () async {
                                    final imageSourcePath =
                                        await Utils.pickSingleImage();
                                    thumbImage = imageSourcePath!;

                                    bloc.add(PropertyPropertyVideoEvent(
                                        propertyVideo: PropertyVideoDto(
                                      videoThumbnail: thumbImage,
                                      videoId: videoId,
                                      videoDescription: description,
                                    )));
                                  },
                                  child: const EditBtn())),
                        ],
                      ),
                    ),

                    Utils.verticalSpace(16),
                    TextFormField(
                      initialValue: state.propertyVideoDto.videoId,
                      onChanged: (value) {
                        videoId = value;
                        // bloc.propertyVideoDto = PropertyVideoDto(
                        //   videoThumbnail: thumbImage,
                        //   videoId: videoId,
                        //   videoDescription: description,
                        // );
                        bloc.add(PropertyPropertyVideoEvent(
                            propertyVideo: PropertyVideoDto(
                          videoThumbnail: thumbImage,
                          videoId: videoId,
                          videoDescription: description,
                        )));
                      },
                      decoration: const InputDecoration(
                          hintText: 'Video Id *',
                          labelText: 'Video Id *',
                          hintStyle: TextStyle(color: Colors.black38),
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          )),
                      keyboardType: TextInputType.text,
                    ),
                    Utils.verticalSpace(16),
                    TextFormField(
                      initialValue: state.propertyVideoDto.videoDescription,
                      onChanged: (value) {
                        description = value;
                        // bloc.propertyVideoDto = PropertyVideoDto(
                        //   videoThumbnail: thumbImage,
                        //   videoId: videoId,
                        //   videoDescription: description,
                        // );
                        bloc.add(PropertyPropertyVideoEvent(
                            propertyVideo: PropertyVideoDto(
                          videoThumbnail: thumbImage,
                          videoId: videoId,
                          videoDescription: description,
                        )));
                      },
                      // onFieldSubmitted: (v) {},
                      // onSaved: (v) {},
                      decoration: const InputDecoration(
                          hintText: 'Video Description *',
                          labelText: 'Video Description *',
                          hintStyle: TextStyle(color: Colors.black38),
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          )),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
