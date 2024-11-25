import 'package:easier_dodam/feature/night_study/item/night_study_item.dart';
import 'package:flutter/material.dart';

class NightStudyPresentItem extends StatelessWidget {
  final String presetTitle;
  final String reason;
  final PlaceType place;
  final bool doNeedPhone;
  final String phoneReason;
  final String startDate;
  final String endDate;
  final Function() onTrashClick;
  final Function() onClickCreate;

  const NightStudyPresentItem({
    super.key,
    required this.presetTitle,
    required this.reason,
    required this.place,
    required this.doNeedPhone,
    required this.phoneReason,
    required this.startDate,
    required this.endDate,
    required this.onTrashClick,
    required this.onClickCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("심자 프리셋 생성하기"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("프리셋 제목", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(hintText: "프리셋#1"),
            ),
            SizedBox(height: 16),
            Text("사유", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(hintText: reason),
            ),
            SizedBox(height: 16),
            Text("장소 선택", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<PlaceType>(
              value: place,
              items: PlaceType.values.map((placeType) {
                return DropdownMenuItem<PlaceType>(
                  value: placeType,
                  child: Text(placeType.toString().split('.').last),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: doNeedPhone,
                  onChanged: (value) {},
                ),
                Text("휴대폰 사용"),
              ],
            ),
            if (doNeedPhone)
              TextField(
                decoration: InputDecoration(hintText: "사유: $phoneReason"),
              ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("심자 시작", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {},
                        child: Text(startDate),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("심자 종료", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {},
                        child: Text(endDate),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: onClickCreate,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text("생성하기", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }
}