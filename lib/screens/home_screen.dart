import 'package:flutter/material.dart';
import 'package:webtoon/main.dart';
import 'package:webtoon/models/webtoon_model.dart';

import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoon = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "오늘의 웹툰",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: webtoon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(child: makeList(snapshot)),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            Image.network(
              webtoon.thumb,
              width: 200,
              height: 200,
            ),
            Text("${webtoon.title}"),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 40,
        );
      },
    );
  }
}
