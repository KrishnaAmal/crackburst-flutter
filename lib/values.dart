// ignore_for_file: public_member_api_docs, sort_constructors_first
List<Firework> cart = [];

const List<Firework> fireworks = [
  Firework(
    name: 'Cocktail Sparklers',
    description:
        'Elevate your cocktail experience with our enchanting Cocktail Sparklers! Transform any drink into a celebration with these miniature pyrotechnic wonders. Crafted from high-quality materials, our cocktail sparklers are designed to add a touch of glamour and excitement to your beverages.',
    image: 'assets/images/firework1.jpg',
    price: '100',
  ),
  Firework(
    name: 'Artillery Shells',
    description:
        'Introducing our Artillery Shells - the pinnacle of pyrotechnic perfection! Ignite the night sky with these powerful and awe-inspiring fireworks that redefine your celebration. Each artillery shell is a carefully crafted explosive device designed to deliver breathtaking displays of color, light, and sound.',
    image: 'assets/images/firework2.webp',
    price: '200',
  ),
  Firework(
    name: 'AA Artillery',
    description:
        'Introducing our AA Artillery Fireworks , where pyrotechnic prowess meets the excitement of the night sky! Elevate your celebrations with this explosive masterpiece that combines dazzling visual displays with the thrill of artillery-inspired fireworks.',
    image: 'assets/images/firework3.jpg',
    price: '300',
  ),
  Firework(
    name: 'Chocolate Crackers',
    description:
        'Indulge your taste buds with our delectable Chocolate Crackers, a harmonious blend of rich chocolate and crisp, flaky goodness that will satisfy even the most discerning sweet tooth.',
    image: 'assets/images/firework4.jpg',
    price: '400',
  ),
  Firework(
    name: 'Cannon Fire',
    description:
        'Introducing our Cannon Fire Fireworks, where the explosive beauty of pyrotechnics meets the grandeur of historical artillery! Prepare to be awestruck as you witness the stunning spectacle of Cannon Fire, a display designed to captivate and celebrate with a touch of historical flair.',
    image: 'assets/images/firework5.jpg',
    price: '500',
  ),
  Firework(
    name: 'Sparkler Pack',
    description:
        'Introducing our Sparkler Pack, a dazzling ensemble of enchanting sparklers designed to ignite the magic in your celebrations! Elevate every special moment with this assortment of radiant lights, adding a touch of brilliance and joy to your festivities.',
    image: 'assets/images/firework6.webp',
    price: '600',
  ),
  Firework(
    name: 'Rockets',
    description:
        'The ultimate expression of explosive excitement that will launch your celebrations to new heights! Designed for thrill-seekers and firework enthusiasts, our Rockets promise a jaw-dropping display of lights, colors, and exhilarating pyrotechnics.',
    image: 'assets/images/fireworks7.webp',
    price: '700',
  ),
  Firework(
    name: 'Midnight Party Pack',
    description:
        'An all-in-one assortment designed to transform your celebration into a mesmerizing extravaganza under the night sky! This carefully curated pack combines a variety of dazzling fireworks to ensure that your midnight revelry is nothing short of spectacular.',
    image: 'assets/images/firework8.gif',
    price: '800',
  ),
  Firework(
    name: 'DUM-BUM 49',
    description:
        'Introducing the DUM-BUM 49 Aerial Spectacle,  where explosive excitement meets the magic of the night sky! Get ready for an exhilarating display of lights, colors, and pyrotechnic mastery that will elevate your celebrations to new heights.',
    image: 'assets/images/firework9.jpg',
    price: '900',
  ),
  Firework(
    name: 'Salute Rockets',
    description:
        'A powerful and awe-inspiring addition to your fireworks display, designed to command attention and create a grand spectacle in the night sky. Elevate your celebration with these explosive marvels that deliver thunderous salutes and breathtaking visual displays.',
    image: 'assets/images/firework10.jpg',
    price: '1000',
  ),
];

class Firework {
  final String name;
  final String description;
  final String image;
  final String price;

  String get id => name.toLowerCase().trim();

  const Firework({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  @override
  bool operator ==(covariant Firework other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.image == image &&
        other.price == price;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        price.hashCode;
  }
}
