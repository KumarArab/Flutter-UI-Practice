class Location {
  final String imageUrl;
  final String place;
  final String name;

  Location(this.imageUrl, this.place, this.name);
}

List<Location> dummyLocations = [
  Location('https://picsum.photos/seed/300/300', 'Great Wall of China', 'China'),
  Location('https://picsum.photos/seed/300/301', 'Petra', 'Jordan'),
  Location('https://picsum.photos/seed/300/302', 'Chichen Itza', 'Mexico'),
  Location('https://picsum.photos/seed/300/304', 'Machu Picchu', 'Peru'),
  Location('https://picsum.photos/seed/300/305', 'Colosseum', 'Italy'),
  Location('https://picsum.photos/seed/300/306', 'Taj Mahal', 'India'),
  Location('https://picsum.photos/seed/300/307', 'Christ the Redeemer', 'Brazil'),
  Location('https://picsum.photos/seed/300/308', 'Victoria Falls', 'Zimbabwe and Zambia'),
  Location('https://picsum.photos/seed/300/309', 'Grand Canyon', 'United States'),
  Location('https://picsum.photos/seed/300/310', 'Uluru-Kata Tjuta National Park', 'Australia'),
];
