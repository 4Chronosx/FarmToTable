
import 'package:farm2you/commons.dart';
import 'package:flutter_map/flutter_map.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
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
              child: searchBar(screenWidth),
            )
          ),
        ],
      ),
      
    );
  }

  SizedBox searchBar(double screenWidth) {
    return SizedBox(height: 50, width: screenWidth * 0.8,
            child: SearchAnchor(builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
                trailing: <Widget>[
                  Tooltip(
                    message: 'Filter',
                    child: IconButton(
                      onPressed: (){}, 
                      icon: const Icon(FontAwesomeIcons.filter)
                      ),
                  )
                ],
            
              );
            }, suggestionsBuilder: (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                ); 
              });
            }),
          );
  }
}