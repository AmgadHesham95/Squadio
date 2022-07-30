import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:squadio/core/strings/api.dart';
import 'package:squadio/features/popular_people/domain/entities/person_entity.dart';
import 'package:squadio/features/popular_people/presentation/widgets/error_loading_image_widget.dart';
import 'package:squadio/features/popular_people/presentation/widgets/person_image_view_widget.dart';
import 'package:squadio/features/popular_people/presentation/widgets/shimmer_widget.dart';

class PersonDetailsWidget extends StatelessWidget {
  const PersonDetailsWidget({Key? key, required this.person}) : super(key: key);

  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                color: Colors.indigo,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Name: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(person.name),
            ],
          ),
          const Divider(
            height: 50,
          ),
          Row(
            children: [
              const Icon(
                Icons.home,
                color: Colors.green,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Known For Department: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(person.knownForDepartment),
            ],
          ),
          const Divider(
            height: 50,
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Popularity: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(person.popularity.toString()),
            ],
          ),
          const Divider(
            height: 50,
          ),
          Row(
            children: [
              Icon(
                getGenderIcon(person.gender),
                color: Colors.pink,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Gender: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(getGender(person.gender)),
            ],
          ),
          const Divider(
            height: 50,
          ),
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            children: [
              // There's a problem with the images url
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PersonImageViewWidget(
                        imageUrl: baseUrl + person.profilePath,

                        /// For testing purpose as there's a problem with image's url coming from the API
                        // imageUrl:
                        //     'https://media.istockphoto.com/photos/taj-mahal-mausoleum-in-agra-picture-id1146517111?k=20&m=1146517111&s=612x612&w=0&h=vHWfu6TE0R5rG6DJkV42Jxr49aEsLN0ML-ihvtim8kk=',
                      ),
                    ),
                  );
                },
                child: CachedNetworkImage(
                    imageUrl: baseUrl + person.profilePath,

                    /// For testing purpose as there's a problem with image's url coming from the API
                    // imageUrl:
                    //     'https://media.istockphoto.com/photos/taj-mahal-mausoleum-in-agra-picture-id1146517111?k=20&m=1146517111&s=612x612&w=0&h=vHWfu6TE0R5rG6DJkV42Jxr49aEsLN0ML-ihvtim8kk=',

                    placeholder: (context, url) => const ShimmerWidget(),
                    errorWidget: (context, url, error) =>
                        ErrorLoadingMessageWidget(
                            textColor: Colors.black,
                            iconColor: Colors.red[700]!)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getGender(int gender) {
    if (gender == 1) {
      return 'Female';
    }
    return 'Male';
  }

  IconData getGenderIcon(int gender) {
    if (gender == 1) {
      return Icons.female;
    }
    return Icons.male;
  }
}
