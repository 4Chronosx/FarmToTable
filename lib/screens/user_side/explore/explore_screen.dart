
import 'package:farm2you/commons.dart';
import 'package:farm2you/widgets/searchbar.dart';
import 'package:latlong2/latlong.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final mapControllerVar = MapController();

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapControllerVar,
            options: MapOptions(
              initialCenter: LatLng(10.322467560222893, 123.89885172891246),
              initialZoom: 18,
              minZoom: 0,
              maxZoom: 100,
              cameraConstraint: CameraConstraint.contain(
                bounds:LatLngBounds(
                    const LatLng(-85.0, -180.0),
                    const LatLng(85.0, 180.0)
                  )
                )
            ),
            children: [
              TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',)

            ]
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ReusableSearchBar(width: screenWidth * 0.8),
            )
          ),
        ],
      ),
      
    );
  }

}
