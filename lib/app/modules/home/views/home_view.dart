import 'package:flutter/material.dart';
import 'package:medicalsupport/config/common_bottom_navigation_bar.dart';
import 'package:medicalsupport/config/common_bottom_navigation_floating_button.dart';
import 'package:medicalsupport/config/common_drawer.dart';
import 'package:medicalsupport/config/common_app_bar.dart'; // Import Common AppBar
import 'package:fl_chart/fl_chart.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFEDF0F3), // Background color
      appBar: CommonAppBar(),
      drawer: CommonDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDashboardCards(),
            SizedBox(height: 10),
            _buildAnalyticsCard(),
            SizedBox(height: 10),
            _buildInfoCards(),
            SizedBox(height: 10),
            _buildEmployeesCalendar(),
            SizedBox(height: 10),
            _buildOngoingTickets(),
          ],
        ),
      ),
      floatingActionButton: CommonBottomNavigationFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 2),
    );
  }
  
  // 🔹 Dashboard Cards (Ongoing & Solved Queries)
  Widget _buildDashboardCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCard("Ongoing Queries", "125", Icons.pending, Colors.purple),
        _buildCard("Solved Queries", "218", Icons.check_circle, Colors.blue),
      ],
    );
  }

  Widget _buildCard(String title, String count, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey, fontSize: 14)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(count, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Icon(icon, color: color, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Analytics Card
  Widget _buildAnalyticsCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tickets Analytics", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SizedBox(
			height: 200,
			child: LineChart(
			  LineChartData(
				gridData: FlGridData(show: false),
				borderData: FlBorderData(
				  border: Border.all(color: Colors.grey.shade300),
				),
				titlesData: FlTitlesData(
				  leftTitles: AxisTitles(
					sideTitles: SideTitles(
					  showTitles: true,
					  reservedSize: 40,
					  getTitlesWidget: (double value, TitleMeta meta) {
						return Text(value.toInt().toString(), style: TextStyle(fontSize: 12));
					  },
					),
				  ),
				  bottomTitles: AxisTitles(
					sideTitles: SideTitles(
					  showTitles: true,
					  getTitlesWidget: (double value, TitleMeta meta) {
						switch (value.toInt()) {
						  case 0:
							return Text('Jan');
						  case 1:
							return Text('Feb');
						  case 2:
							return Text('Mar');
						  case 3:
							return Text('Apr');
						  case 4:
							return Text('May');
						  case 5:
							return Text('Jun');
						  default:
							return Text('');
						}
					  },
					),
				  ),
				),
				lineBarsData: [
				  LineChartBarData(
					spots: [
					  FlSpot(0, 12), // January
					  FlSpot(1, 18), // February
					  FlSpot(2, 10), // March
					  FlSpot(3, 24), // April
					  FlSpot(4, 16), // May
					  FlSpot(5, 20), // June
					],
					isCurved: true,
					color: Colors.blue,
					barWidth: 3,
					isStrokeCapRound: true,
					belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
				  ),
				  LineChartBarData(
					spots: [
					  FlSpot(0, 30), // January
					  FlSpot(1, 12), // February
					  FlSpot(2, 20), // March
					  FlSpot(3, 18), // April
					  FlSpot(4, 40), // May
					  FlSpot(5, 10), // June
					],
					isCurved: true,
					color: Colors.purple,
					barWidth: 3,
					isStrokeCapRound: true,
					belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
				  ),
				],
			  ),
			),
		  ),
        ],
      ),
    );
  }

  // 🔹 Info Cards (Support Provided & Business Growth)
  Widget _buildInfoCards() {
    return Column(
      children: [
        _buildInfoCard("Support Provided", "36.80%", "+ 25% High from last month", Colors.green),
        _buildInfoCard("Business Growth", "20.80%", "- 30% Low from last month", Colors.red),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, String change, Color changeColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(change, style: TextStyle(color: changeColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 🔹 Employees Calendar
  Widget _buildEmployeesCalendar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Employees Calendar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Icon(Icons.calendar_today, color: Colors.grey),
        ],
      ),
    );
  }

  // 🔹 Ongoing Tickets Section
  Widget _buildOngoingTickets() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ongoing Tickets Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildTicketDetail("Jens Brincker", "27/05/2016", "Lorem ipsum dummy text...", "SOLVED"),
        ],
      ),
    );
  }

  Widget _buildTicketDetail(String name, String date, String query, String status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name: $name", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Date: $date"),
        Text("Query: $query"),
        Row(
          children: [
            Chip(label: Text(status), backgroundColor: Colors.green),
            Spacer(),
            Icon(Icons.edit, color: Colors.blue),
            SizedBox(width: 10),
            Icon(Icons.delete, color: Colors.red),
          ],
        ),
      ],
    );
  }
}
