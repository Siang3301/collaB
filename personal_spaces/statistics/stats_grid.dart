import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Total Collaborator', '3 User', Colors.orange , "assets/images/collaborator.png"),
                _buildStatCard('Time Remaining', '9 Days', Colors.red, 'assets/images/time.png'),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Completed', '15 task', Colors.green, 'assets/images/archive.png'),
                _buildStatCard('In Progress', '4 task', Colors.lightBlue, 'assets/images/inprogress.png'),
                _buildStatCard('Overdue', 'N/A', Colors.purple, "assets/images/overdue.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color, String image) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(children: [
              Image.asset(
              image,
              width: 20,
            ),
            SizedBox(width: 5),
            Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
             )
            ]),
          ],
        ),
      ),
    );
  }
}
