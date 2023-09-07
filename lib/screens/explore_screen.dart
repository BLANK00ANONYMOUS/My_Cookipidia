import 'package:cookipidia/screens/message_list.dart';
import 'package:flutter/material.dart';
import '../components/components.dart';
import '../models/models.dart';
import '../api/mock_cookipidia_service.dart';

class ExploreScreen extends StatelessWidget {

  final mockService = MockCookipidiaService();
  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
              const SizedBox(height: 70),
              Center(
                child: MaterialButton(
                  textColor: Colors.white,
                  child: const Text('Show Chat Room'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MessageList()),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
