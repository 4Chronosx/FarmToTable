import 'package:farm2you/commons.dart';

class ReusableSearchBar extends StatelessWidget {
  final double width;
  final void Function(String)? onSelected;

  const ReusableSearchBar({
    Key? key,
    required this.width,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: SearchAnchor(
        viewBackgroundColor: Colors.white,
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
            elevation: WidgetStateProperty.all(2.0),
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onTap: controller.openView,
            onChanged: (_) => controller.openView(),
            leading: const Icon(Icons.search),
            trailing: <Widget>[
              Tooltip(
                message: 'Filter',
                child: IconButton(
                  onPressed: () {
                    // You could add filter functionality here
                  },
                  icon: const Icon(FontAwesomeIcons.filter),
                ),
              )
            ],
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(5, (int index) {
            final String item = 'item $index';
            return ListTile(
              tileColor: Colors.white,
              title: Text(item),
              onTap: () {
                controller.closeView(item);
                if (onSelected != null) {
                  onSelected!(item);
                }
              },
            );
          });
        },
      ),
    );
  }
}
