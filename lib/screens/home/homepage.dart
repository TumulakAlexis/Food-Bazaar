import 'package:bite_bazaar/screens/categories/beverages.dart';
import 'package:bite_bazaar/screens/categories/breakfast.dart';
import 'package:bite_bazaar/screens/categories/lunch.dart';
import 'package:bite_bazaar/screens/categories/pasta.dart';
import 'package:bite_bazaar/screens/categories/snacks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    'https://scontent-mnl1-2.xx.fbcdn.net/v/t39.30808-6/448187230_918863866918800_279664386124984647_n.jpg?stp=cp6_dst-jpg&_nc_cat=102&ccb=1-7&_nc_sid=5f2048&_nc_ohc=xwUAVcgndYkQ7kNvgGNaUB3&_nc_ht=scontent-mnl1-2.xx&oh=00_AYBVSyvCOnZSSPUQUNW2dFN37sHjA5fT-35OQ_APj9_BXw&oe=6671FCFE',
    'https://scontent-mnl1-2.xx.fbcdn.net/v/t39.30808-6/448002739_917028410435679_5632604437778069355_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=5f2048&_nc_ohc=TxgyfWo0eREQ7kNvgGRaneI&_nc_ht=scontent-mnl1-2.xx&oh=00_AYAWQag9Y5qCo-YryUpSXKudg9BS3tF-sYQ1iX04wDLmAg&oe=6671F72C',
    'https://scontent-mnl1-2.xx.fbcdn.net/v/t39.30808-6/438036692_122134487462227880_6833150349880112023_n.jpg?stp=cp6_dst-jpg_s960x960&_nc_cat=107&ccb=1-7&_nc_sid=5f2048&_nc_ohc=uHz2pR_Oy_wQ7kNvgEqd4Nd&_nc_ht=scontent-mnl1-2.xx&oh=00_AYAS4VMAttrQmkA39KCmy03secMx0q3Xua1s6QhIQ8mE4w&oe=667200BE',
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // Add your search logic here
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: imgList.map((item) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: Center(
                      child: Image.network(item, fit: BoxFit.cover, width: 1000),
                    ),
                  ),
                )).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      _current = entry.key;
                    }),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.red)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
              Row(
                children: [
                  SizedBox(width: 30,height: 30,),
                  Text('Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),),
                ],
              ),
              
               SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Breakfast()));
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Image.asset('assets/BREAKFAST.png'),
                            ),
                          ),
                          Text('Breakfast',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Lunch()));
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Image.asset('assets/LUNCH.png'),
                            ),
                          ),
                          Text('Lunch',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Pasta()));
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Image.asset('assets/PASTA.png'),
                            ),
                          ),
                          Text('Pasta',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Beverages()));
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Image.asset('assets/BEVERAGES.png'),
                            ),
                          ),
                          Text('Beverages',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Snacks()));
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Image.asset('assets/SNACKS.png'),
                            ),
                          ),
                          Text('Snacks',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                        ],
                      ),
                      SizedBox(width: 30,)
                    ],
                  ),
                ),
                SizedBox(height: 30,),
               Row(
                children: [
                  SizedBox(width: 30,height: 30,),
                  Text('Flash Deals',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),),
                ],
              ),
              SizedBox(height: 30,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Container(
                      width: 150,
                      height: 150,
                      child: Image.asset('assets/FLASH1.png'),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: Image.asset('assets/FLASH2.png'),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: Image.asset('assets/FLASH3.png'),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: Image.asset('assets/FLASH4.png'),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
              ),
              SizedBox(height: 30,)
        
        
              
        
              
            ],
          ),
        ),
      ),
    );
  }
}
