// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:nextintern_mobile/services/criteria_service.dart';
import 'package:nextintern_mobile/widgets/custom_app_bar.dart';
import 'package:nextintern_mobile/models/criteria_model.dart';
import 'package:nextintern_mobile/widgets/criteria_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CriteriaModel>> _criteriaListFuture;

  @override
  void initState() {
    super.initState();
    _criteriaListFuture = CriteriaService.getAllCriteria();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: 'Home',
        ),
      ),
      body: FutureBuilder<List<CriteriaModel>>(
        future: _criteriaListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<CriteriaModel> criteriaList = snapshot.data!;
            return ListView.builder(
              itemCount: criteriaList.length,
              itemBuilder: (context, index) {
                return CriteriaCard(criteria: criteriaList[index]);
              },
            );
          } else {
            return Center(child: Text('No criteria found'));
          }
        },
      ),
    );
  }
}
