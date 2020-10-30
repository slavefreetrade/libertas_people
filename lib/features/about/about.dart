import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';
import 'package:libertaspeople/features/about/about_data.dart';
import 'package:libertaspeople/features/about/principle.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.darkBlue,
        title: Text(
          'About Survey',
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: ColorConstants.darkBlue),
        BottomNavigationBarItem(
            icon: Icon(Icons.report),
            title: Text('About Survey'),
            backgroundColor: ColorConstants.darkBlue),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            backgroundColor: ColorConstants.darkBlue),
      ]),
      body: Container(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 25, right: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'The Libertas People app is how we deliver human rights questions to you in a secure, anonymous, and confidential way. ',
                  style: const TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                      wordSpacing: 3.5),
                ),
                const SizedBox(height: 11),
                const Text(
                    'Our survey is based on the 10 human right principles on international law. ',
                    style: const TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
                        wordSpacing: 3.5)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Image.asset(
                      'assets/slavefreetrade_logo.png',
                      height: 48.88,
                      width: 47,
                    ),
                    const Text(
                      'Read more about slavefreetrade',
                      style: const TextStyle(
                          fontFamily: 'Helvetica Neue',
                          fontWeight: FontWeight.w400,
                          fontSize: 17.0,
                          wordSpacing: 3.5),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                    'Tap on each button to read more about each principle:',
                    style: const TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
                        wordSpacing: 3.5)),
                const SizedBox(height: 14),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      height: height * 0.41,
                      child: GridView.count(
                        primary: false,
                        padding: EdgeInsets.all(10),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        crossAxisCount: 2,
                        childAspectRatio: 6 / 2,
                        children: ABOUT_DATA.map((prin) {
                          return Container(
                            width: 150,
                            height: 55,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return Principle(
                                        logo: prin['logo'],
                                        title: prin['title'],
                                        text: prin['text'],
                                      );
                                    }));
                              },
                              child: Container(
                                width: 300,
                                child: Image(
                                  image: AssetImage(prin['image']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )),
                const SizedBox(height: 30),
                Container(
                  height: 54,
                  width: 240,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: ColorConstants.orange,
                      onPressed: () {},
                      child: const Text(
                        'Take survey',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Helvetica Neue',
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
