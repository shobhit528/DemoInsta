import 'dart:math';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PDView extends StatefulWidget {
  const PDView({Key? key}) : super(key: key);

  @override
  State<PDView> createState() => _PDViewState();
}
class _PDViewState extends State<PDView> with TickerProviderStateMixin {
  final _carouselController = PageController(viewportFraction: 0.8);
  late AnimationController _animationController;
  bool _isPriceTagExpanded = true; //initially set to true

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isPriceTagExpanded = true;
        });
      }
    });
    final carouselCubit = context.read<CarouselCubit>();
    _carouselController.addListener(() {
      final page = _carouselController.page?.round();
      if (page == null) return;
      if (carouselCubit.state.selectedCardIndex != page) {
        carouselCubit.selectCard(page);

        setState(() {
          _isPriceTagExpanded = false;
          _animationController.forward(from: 0.0);
        });
      }
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff1d1d1d),
          elevation: 0,
          title: const Text(
            "DISCOVER",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: Container(
              margin: const EdgeInsets.all(8),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/image_profile.png"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue)),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {},
            ),
          ]),
      backgroundColor: const Color(0xff1d1d1d),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                 Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Column(
                    children: [
                      Text("F   E   A   T   .",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 13),
                      Text(".  U   R   E   D",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: ExpandablePageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        _isPriceTagExpanded = false;
                        _animationController.forward(from: 0.0);
                      });
                    },
                    padEnds: false,
                    controller: _carouselController,
                    clipBehavior: Clip.none,
                    itemCount: 100,
                    itemBuilder: (_, index) {
                      if (!_carouselController.position.haveDimensions) {
                        return const SizedBox();
                      }

                      final int normalizedIndex =
                          index % 100; // Normalize the index
                      final Color color =
                      AppTheme.getCardColor(index); // Get the card color
                      final items = profileItems.map((item) {
                        return ProfileName(name: item.name, date: item.date);
                      }).toList();

                      final recipeAndNurtients = recipeItems.map((item) {
                        return RecipeNNutrients(
                            recipeNames: item.recipeNames,
                            nutrientQuantity: item.nutrientQuantity);
                      }).toList();

                      return AnimatedBuilder(
                        animation: _carouselController,
                        builder: (_, __) => Transform.scale(
                          origin: Offset.fromDirection(0.0, 50.0),
                          alignment: Alignment.topLeft,
                          scale: max(
                            0.6,
                            (1 - (_carouselController.page! - index).abs() / 2),
                          ),
                          child: CarouselCard(
                            isExpanded: _isPriceTagExpanded,
                            icon: Icons.bolt_outlined,
                            name: items[normalizedIndex].name,
                            date: items[normalizedIndex].date,
                            index: normalizedIndex,
                            color: color,
                            carouselController: _carouselController,
                            nutrient: recipeAndNurtients[normalizedIndex]
                                .nutrientQuantity,
                            recipeName:
                            recipeAndNurtients[normalizedIndex].recipeNames,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CarouselCard extends StatefulWidget {
  final IconData icon;
  final String name;
  final String date;
  final int index;
  final Color color;
  final String recipeName;
  final String nutrient;
  final bool isExpanded;
  final PageController carouselController;

  const CarouselCard({
    Key? key,
    required this.icon,
    required this.name,
    required this.index,
    required this.color,
    required this.isExpanded,
    required this.carouselController,
    required this.date,
    required this.recipeName,
    required this.nutrient,
  }) : super(key: key);

  @override
  State<CarouselCard> createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard>
    with TickerProviderStateMixin {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: widget.color,
            ),
            child: Stack(children: [
              Positioned(
                left: -20,
                top: 550 / 2.4,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 8,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -100,
                bottom: -50,
                child: Container(
                  width: 380,
                  height: 380,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.13,
                      image: AssetImage('assets/images/food.png'),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -20,
                bottom: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 8,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.cyan,
                          backgroundImage: AssetImage('assets/images/image_profile.png'),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.date,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(
                      color: Colors.white.withOpacity(0.8),
                      thickness: 1,
                      endIndent: 80,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.recipeName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.nutrient,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 20,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadowColor: Colors.black.withOpacity(0.6),
                      ),
                      onPressed: () {},
                      child:  Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                )),
                            SizedBox(width: 12),
                            Text(
                              'Add to bag',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    AnimatedSize(
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Visibility(
                        visible: widget.carouselController.page == widget.index,
                        child: SizedBox(
                          height: 32,
                          width: widget.isExpanded ? 90 : 0,
                          child: CustomPaint(
                            painter: PriceTagPaint(),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Center(
                                child: Text(
                                  "\$42.32",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ]),
          ),
          Positioned(
            right: -25,
            bottom: 0,
            child: AnimatedBuilder(
              animation: widget.carouselController,
              builder: (_, __) {
                final double page = widget.carouselController.page ?? 0;
                final double rotation = (page - widget.index) *
                    -1.0; // Adjust the rotation speed here

                return Transform.rotate(
                  angle: rotation,
                  child: Hero(
                    tag: "food${widget.index}",
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/food.png'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PriceTagPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 255, 217, 151)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Path path = Path();

    path
      ..moveTo(size.width, size.height * .5)
      ..lineTo(size.width - size.width * .20, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width - size.width * .20, size.height)
      ..lineTo(size.width, size.height * .5)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit()
      : super(
    const CarouselState(selectedCardIndex: 0),
  );

  void selectCard(int cardIndex) {
    emit(CarouselState(selectedCardIndex: cardIndex));
  }
}

class CarouselState {
  final int selectedCardIndex;

  const CarouselState({required this.selectedCardIndex});
}
class AppTheme {
  static const Color pricetagcolor = Color(0xffFFB942);
  static List<Color> cardColors = [
    const Color(0xffFFC43A),
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.yellow,
    Colors.indigo,
  ];

  static Color getCardColor(int index) {
    return cardColors[index % cardColors.length];
  }
}
class ButtonModel {
  final String text;
  bool isPressed;

  ButtonModel({required this.text, this.isPressed = false});
}

List<ButtonModel> buttons = [
  ButtonModel(text: "Salad"),
  ButtonModel(text: "Pizza"),
  ButtonModel(text: "Burger"),
  ButtonModel(text: "Pasta"),
  ButtonModel(text: "Noodle"),
  ButtonModel(text: "Soup"),
  ButtonModel(text: "Steak"),
  ButtonModel(text: "Dessert"),
];
final List<SauceItem> sauceItems = [
  SauceItem(
      imagePath: 'assets/banana.png', name: 'Banana', price: '\$72.52/Kg'),
  SauceItem(
      imagePath: 'assets/banana.png', name: 'Banana', price: '\$72.52/Kg'),
  SauceItem(
      imagePath: 'assets/banana.png', name: 'Banana', price: '\$72.52/Kg'),
];

class SauceItem {
  final String imagePath;
  final String name;
  final String price;

  SauceItem({required this.imagePath, required this.name, required this.price});
}
final List<ProfileName> profileItems = [
  ProfileName(name: "Linda Miller", date: '29 JUL'),
  ProfileName(name: "Linda Miller", date: '29 JUL'),
  ProfileName(name: "Linda Miller", date: '22 JUL'),
  ProfileName(name: "Linda Miller", date: '22 JUL'),
  ProfileName(name: "Linda Miller", date: '22 JUL'),
  ProfileName(name: "Linda Miller", date: '22 JUL'),
  ProfileName(name: "Linda Miller", date: '22 JUL'),
  ProfileName(name: "Linda Miller", date: '22 JUL'),
  ProfileName(name: "Linda Miller", date: '22 JUL'),
];

class ProfileName {
  final String name;
  final String date;

  ProfileName({required this.name, required this.date});
}
final List<RecipeNNutrients> recipeItems = [
  RecipeNNutrients(recipeNames: "Spicy Maguro", nutrientQuantity: 'Rich Nutrition'),
  RecipeNNutrients(recipeNames: "Spicy Maguro", nutrientQuantity: 'Rich Nutrition'),
  RecipeNNutrients(recipeNames: "Spicy Maguro", nutrientQuantity: 'Rich Nutrition'),
  RecipeNNutrients(recipeNames: "Spicy Maguro", nutrientQuantity: 'Rich Nutrition'),
  RecipeNNutrients(recipeNames: "Spicy Maguro", nutrientQuantity: 'Rich Nutrition'),
  RecipeNNutrients(recipeNames: "Spicy Maguro", nutrientQuantity: 'Rich Nutrition'),
  RecipeNNutrients(recipeNames: "Spicy Maguro", nutrientQuantity: 'Rich Nutrition'),
  RecipeNNutrients(recipeNames: "Spicy Maguro", nutrientQuantity: 'Rich Nutrition'),
  RecipeNNutrients(recipeNames: "Spicy Maguro", nutrientQuantity: 'Rich Nutrition'),
];

class RecipeNNutrients {
  final String recipeNames;
  final String nutrientQuantity;

  RecipeNNutrients({required this.recipeNames, required this.nutrientQuantity});
}