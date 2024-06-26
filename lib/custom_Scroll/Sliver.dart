import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _color = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.deepOrange,
  ];
  @override
  Widget build(BuildContext context) {
    bool visible = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('ScrollView'),
      ),
      body: Stack(children: [
        CustomScrollView(
          slivers: [
            //
            SliverAppBar.large(
              backgroundColor: Colors.green,
              pinned: true, //pins the title
              //expandedHeight: 150, //sets the height of the appbar when expanded
              title: const Text(
                'SliverAppbar',
              ),
              //this title is found at the top
              flexibleSpace: FlexibleSpaceBar(
                background: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Image.network(
                    'https://c8.alamy.com/comp/2CBYXT2/v-logo-valorant-shooter-game-symbol-vector-on-isolated-white-background-eps-10-2CBYXT2.jpg',
                  ),
                ),
              ),
            ),
            //
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 20,
                (context, index) {
                  return ListTile(title: Text('Item ${index + 1}'));
                },
              ),
            ),
            const SliverAppBar(
              backgroundColor: Colors.red,
              pinned: true,
              title: Text(
                'SliverAppBar 2',
              ),
            ),
            SliverPadding(
                padding: EdgeInsetsDirectional.all(
                    25)), //this provides padding to the next widget

            SliverConstrainedCrossAxis(
              maxExtent: 500, //controls the width of each grid item
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 200, //height of each grid item
                    //crossAxisSpacing: 20,
                    //mainAxisSpacing: 20,
                    crossAxisCount: 2),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    //padding: EdgeInsets.symmetric(horizontal: 25),
                    color: _color[index],
                  );
                },
              ),
            ),
            SliverAppBar(
              pinned: true,
              title: Text('SliverAppBar 3'),
            ),
            SliverToBoxAdapter(
              child: DividerTheme(
                data: DividerThemeData(
                  color: Colors.red,
                  thickness: 2,
                ),
                child: SizedBox(
                  height: 500,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          horizontalTitleGap:
                              50, //provides gap between the titles and other like trailing/leading
                          leading: Icon(Icons.account_circle_rounded),
                          title: Text('Person ${index + 1}'),
                          subtitle: Text('Phone No....'),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: 10),
                ),
              ),
            ),
            const SliverAppBar(
              backgroundColor: Colors.amber,
              pinned: true,
              title: Text('SliverAppBar 4'),
            ),

            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(
                  //splashColor: Colors.blueGrey,
                  tileColor: Colors.blueGrey[100 * (index % 9)],
                  title: Text('Item ${index + 1}'),
                );
              }, childCount: 20),
              itemExtent: 50,
              //tallness or height of each tile
            ),
            SliverAppBar(
              pinned: true,
              title: Text('SliverAppBar5'),
            ),

            SliverConstrainedCrossAxis(
              maxExtent: 200,
              sliver: SliverList.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    color: _color[index],
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        title: Text('Item ${index + 1}')),
                  );
                },
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false, //this is to stop the overscroll
              fillOverscroll: true,
              child: Center(child: Text("This is End")),
            )
            // SliverList(
            //     delegate:
            //         SliverChildBuilderDelegate(childCount: 20, (context, index) {
            //   return ListTile(title: Text('Item ${20 + index + 1}'));
            // }))
          ],
        ),
        Align(
          alignment: Alignment(0.9, 0.9), //ranges from -1 to 1
          child: FloatingActionButton(
            onPressed: () {
              visible = !visible;
            },
            child: Icon(Icons.add),
          ),
        )
      ]),
    );
  }
}
