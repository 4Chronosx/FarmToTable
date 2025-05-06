import 'package:farm2you/commons.dart';

class ProductModel {
  String name;
  String description;
  String source;
  String category;
  String vendor;
  String imgPath;
  double price;
  String unit;
  int id;
  void Function()? onTap;

  ProductModel(
      {required this.name,
      required this.description,
      required this.source,
      required this.category,
      required this.vendor,
      required this.imgPath,
      required this.price,
      required this.unit,
      required this.id,
      this.onTap});

  static List<ProductModel> getProducts(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {
        "name": "Mangoes Carabao",
        "description":
            "Renowned for their exceptional sweetness and smooth, vibrant yellow flesh, Carabao mangoes are a globally prized variety, often considered the 'sweetest mango in the world'. They have a distinct aroma and a rich, tropical flavor profile that makes them ideal for eating fresh, desserts, and juices.",
        "source":
            "A cultivar originating from the Philippines, known for its superior taste and quality.",
        "category": "Fruits",
        "vendor": "The Mango Farm",
        "imgPath":
            "https://fishnchix.ph/cdn/shop/products/innovativete.jpg?v=1630309716",
        "price": 100.00,
        "unit": "kg",
        "id": 1
      },
      {
        "name": "Dragon Fruit Red",
        "description":
            "The red pitaya is a visually striking fruit with vibrant magenta skin and white flesh speckled with tiny black seeds. Its taste is mildly sweet and refreshing, often described as a blend of kiwi and pear. It's also rich in antioxidants and fiber, making it a healthy and exotic addition to any diet.",
        "source":
            "Native to the Americas, but now cultivated in various tropical regions worldwide.",
        "category": "Fruits",
        "vendor": "The DragonFruit Farm",
        "imgPath":
            "https://ever.ph/cdn/shop/files/200000085142-Dizon-Dragon-Fruit-500g-700g-20210802_d3f4b11f-e6f7-41b4-b8a4-acaae1839ec7.jpg?v=1738215010",
        "price": 120.00,
        "unit": "kg",
        "id": 2
      },
      {
        "name": "Broccoli Calabrese",
        "description":
            "Calabrese broccoli is a green vegetable with large flowering heads arranged in a tree-like structure. It's known for its earthy and slightly bitter flavor, which becomes sweeter when cooked. Broccoli is a nutritional powerhouse, packed with vitamins, minerals, and antioxidants, often steamed, roasted, or added to stir-fries.",
        "source":
            "Believed to have originated in Italy, specifically the Calabria region, hence its name.",
        "category": "Vegetables",
        "vendor": "The Vegetable Farm",
        "imgPath":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu1BE-zNy7egcpfeMTR-e7io7Px5g8SNS6WA&s",
        "price": 90.00,
        "unit": "kg",
        "id": 3
      },
      {
        "name": "Carrots Nantes",
        "description":
            "Nantes carrots are a popular variety known for their cylindrical shape, smooth skin, and sweet, tender flesh. They are typically coreless and have a delicate flavor, making them ideal for eating raw, juicing, or cooking in various dishes. Carrots are an excellent source of beta-carotene, which the body converts to Vitamin A.",
        "source":
            "Developed in the Nantes region of France, prized for their quality and flavor.",
        "category": "Vegetables",
        "vendor": "The Vegetable Farm",
        "imgPath": "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Vegetable-Carrot-Bundle-wStalks.jpg/960px-Vegetable-Carrot-Bundle-wStalks.jpg",
        "price": 90.00,
        "unit": "kg",
        "id": 4
      },
      {
        "name": "Pork Heritage",
        "description":
            "Meat from heritage breed pigs is often prized for its richer flavor and higher fat content compared to commercially raised pork. These breeds are known for their ability to thrive in more natural environments and produce meat with greater marbling, resulting in a more tender and flavorful product suitable for roasting, grilling, and charcuterie.",
        "source":
            "Derived from older, traditional breeds of pigs that have distinct genetic traits.",
        "category": "Meat",
        "vendor": "The Meat Farm",
        "imgPath": "https://images.squarespace-cdn.com/content/v1/595aae4ba5790a1570953b2b/1508882502097-I22XOFNR4QQA2ZZ9Y01Y/Heritage-Berkshire-Pork.jpg",
        "price": 300.00,
        "unit": "kg",
        "id": 5
      },
      {
        "name": "Beef Grass-Fed",
        "description":
            "Grass-fed beef comes from cattle that have been raised primarily on pasture and forage. This method of raising cattle is believed to produce meat with a different nutritional profile, often higher in omega-3 fatty acids and antioxidants, and a leaner texture with a more pronounced, 'beefy' flavor.",
        "source":
            "From cattle raised on a diet consisting mainly of grass and other forage, rather than grains.",
        "category": "Meat",
        "vendor": "The Meat Farm",
        "imgPath": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjyRyy_29T-1XBtm2brki2TGgi_7jVB-BFQg&s",
        "price": 300.00,
        "unit": "kg",
        "id": 6
      },
      {
        "name": "Black Chicken",
        "description":
            "Ayam Cemani is a unique and rare breed of chicken originating from Indonesia. What sets them apart is their striking hyperpigmentation (fibromelanosis), which causes most of their tissues to be black – including feathers, skin, beak, tongue, comb, wattles, and even their internal organs. The meat is also darker than that of regular chickens and has a slightly gamey flavor.",
        "source":
            "An ancient breed originating from the island of Java in Indonesia.",
        "category": "Poultry",
        "vendor": "The Poultry Farm",
        "imgPath": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6bM7g6-J-7GqL4MiPm6Sc-ZOk0W_G3a5xOA&s",
        "price": 300.00,
        "unit": "kg",
        "id": 7
      },
      {
        "name": "Bananas Lakatan",
        "description":
            "Lakatan bananas are a popular Filipino variety known for their sweet and slightly tangy flavor, and their relatively firm texture. They are typically smaller and more slender than Cavendish bananas and have a bright yellow peel when ripe. They are enjoyed fresh and are also used in various local desserts.",
        "source":
            "A cultivar widely grown in the Philippines, favored for its taste and texture.",
        "category": "Fruits",
        "vendor": "The Banana Plantation",
        "imgPath": "https://sunnyfreshdelivery.com/cdn/shop/products/13.BANANALAKATAN.png?v=1631516000",
        "price": 40.00,
        "unit": "kg",
        "id": 8
      },
      {
        "name": "Tomato Heirloom",
        "description":
            "Heirloom tomatoes are open-pollinated varieties that have been passed down through generations, prized for their diverse flavors, colors, and shapes. Unlike commercially bred tomatoes, they often have a richer, more complex taste and a less uniform appearance, reflecting their unique genetic heritage.",
        "source":
            "Seeds that have been saved and passed down through families or communities for many generations.",
        "category": "Vegetables",
        "vendor": "The Tomato Patch",
        "imgPath": "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg",
        "price": 60.00,
        "unit": "kg",
        "id": 9
      },
      {
        "name": "Cilantro Mexican",
        "description":
            "Mexican cilantro, also known as coriander leaves, has a bright, citrusy, and slightly peppery flavor that is essential in many Latin American and Southeast Asian cuisines. Its delicate leaves and stems are used fresh as a garnish or incorporated into dishes for their distinct aroma and taste.",
        "source":
            "The leaves of the coriander plant (Coriandrum sativum), widely used in Mexican and other cuisines.",
        "category": "Herbs",
        "vendor": "The Herb Garden",
        "imgPath": "https://wholesale.fresherproduce.ca/storage/images/product/640a3c504c8e3_1678392400.jpg",
        "price": 150.00,
        "unit": "kg",
        "id": 10
      },
      {
        "name": "Rice Jasmine",
        "description":
            "Jasmine rice is a long-grain variety known for its fragrant aroma, often compared to the scent of jasmine flowers. It has a slightly sticky texture when cooked and a delicate, subtly sweet flavor, making it a popular choice in Southeast Asian dishes.",
        "source": "A long-grain aromatic rice originally from Thailand.",
        "category": "Grains",
        "vendor": "The Grain Mill",
        "imgPath": "https://upload.wikimedia.org/wikipedia/commons/0/08/2014_uncooked_Thai_jasmine_rice.jpg",
        "price": 50.00,
        "unit": "kg",
        "id": 11
      },
      {
        "name": "Milk Raw Cow's",
        "description":
            "Raw cow's milk is milk that has not been pasteurized or homogenized. Proponents believe it retains more natural enzymes and nutrients, resulting in a richer flavor and potential health benefits. However, it's important to note that raw milk may also carry a higher risk of harmful bacteria.",
        "source":
            "Fresh milk directly from cows, without undergoing heat treatment.",
        "category": "Dairy",
        "vendor": "The Dairy Farm",
        "imgPath": "https://static.toiimg.com/photo/69464837.cms",
        "price": 70.00,
        "unit": "liter",
        "id": 12
      },
      {
        "name": "Chicken Free-Range",
        "description":
            "Free-range chicken breasts come from chickens that have access to outdoor spaces, allowing them to roam and forage more naturally. This lifestyle is often associated with better animal welfare and can result in meat that has a slightly firmer texture and a more developed flavor compared to conventionally raised chicken.",
        "source": "From chickens raised with access to outdoor areas.",
        "category": "Poultry",
        "vendor": "The Poultry Farm",
        "imgPath": "https://www.lovefoodhatewaste.com/sites/default/files/styles/16_9_two_column/public/2022-08/Poultry-sh583587001.jpg.webp?itok=Keh02AO1",
        "price": 250.00,
        "unit": "kg",
        "id": 13
      },
      {
        "name": "Eggs Brown Pasture",
        "description":
            "Brown, pasture-raised eggs come from hens that are allowed to roam freely on pasture, eating a natural diet of grasses, insects, and seeds. This often results in eggs with richer, darker yolks and a more complex flavor. The brown shell color is breed-specific and doesn't necessarily indicate nutritional superiority over white eggs.",
        "source": "Laid by hens that have ample access to outdoor pasture.",
        "category": "Eggs",
        "vendor": "The Egg Farm",
        "imgPath": "https://cimg0.ibsrv.net/cimg/www.fitday.com/693x350_85-1/728/Eggs_000001615195_Small-108728.jpg",
        "price": 80.00,
        "unit": "dozen",
        "id": 14
      },
      {
        "name": "Salad Organic Mix",
        "description":
            "A mesclun mix is a blend of young, tender salad greens, often including lettuce, arugula, endive, and other leafy varieties. When organically grown, these greens are cultivated without synthetic pesticides or fertilizers, offering a fresh and flavorful base for salads, rich in vitamins and minerals.",
        "source":
            "A traditional mix of tender, young salad greens, grown using organic farming practices.",
        "category": "Organic Packs",
        "vendor": "The Organic Farm",
        "imgPath": "https://www.producemarketguide.com/media/user_RZKVrm5KkV/456/salad-european_variety-page.png",
        "price": 180.00,
        "unit": "pack",
        "id": 15
      },
      {
        "name": "Pineapple Queen V",
        "description":
            "Queen Victoria pineapples are smaller and more elongated than other varieties, known for their exceptionally sweet and fragrant flesh with a low acid content. They have a delicate flavor and a fine texture, making them a prized choice for eating fresh and in gourmet preparations.",
        "source":
            "A premium pineapple variety known for its sweetness and aroma, originating from specific tropical regions.",
        "category": "Fruits",
        "vendor": "The Pineapple Plantation",
        "imgPath": "https://www.healthxchange.sg/sites/hexassets/Assets/food-nutrition/pineapple-health-benefits-and-ways-to-enjoy.jpg",
        "price": 70.00,
        "unit": "piece",
        "id": 16
      },
      {
        "name": "Peppers Org Mix",
        "description":
            "A colorful assortment of organic bell peppers – red, yellow, and green – grown without synthetic pesticides or fertilizers. These peppers offer a range of sweet and slightly tangy flavors and are rich in vitamins and antioxidants, perfect for salads, stir-fries, and roasting.",
        "source":
            "Sweet pepper varieties cultivated using organic farming methods.",
        "category": "Vegetables",
        "vendor": "The Pepper Farm",
        "imgPath": "https://shopanddonate.org/wp-content/uploads/2022/08/mixed-peppers-box.jpg",
        "price": 110.00,
        "unit": "kg",
        "id": 17
      },
      {
        "name": "Basil Genovese",
        "description":
            "Sweet Genovese basil is a classic Italian variety prized for its fragrant, slightly peppery, and sweet flavor. It has large, vibrant green leaves and is a key ingredient in pesto, tomato sauces, and many Mediterranean dishes. Its aromatic oils are also used in aromatherapy.",
        "source":
            "A cultivar of basil originating from the Liguria region of Italy.",
        "category": "Herbs",
        "vendor": "The Herb Garden",
        "imgPath": "https://4rfreshandfrozen.com/cdn/shop/products/BasilLeaves.jpg?v=1617442929",
        "price": 200.00,
        "unit": "kg",
        "id": 18
      },
      {
        "name": "Wheat Flour Whole",
        "description":
            "Whole grain wheat flour is made from the entire wheat kernel – the bran, germ, and endosperm – resulting in a flour that is higher in fiber, nutrients, and has a nuttier flavor compared to refined white flour. It's used for baking bread, muffins, and other goods with a denser texture and more wholesome taste.",
        "source":
            "Ground from the entire kernel of wheat, retaining all its natural components.",
        "category": "Grains",
        "vendor": "The Grain Mill",
        "imgPath": "https://ohoui.com/cdn/shop/articles/Post_Facebook_Mion_9.png?v=1673881584",
        "price": 45.00,
        "unit": "kg",
        "id": 19
      },
      {
        "name": "Cheddar Aged",
        "description":
            "Aged cheddar cheese is a firm cheese that has been allowed to mature for an extended period, developing a sharper, more complex flavor and a drier, more crumbly texture compared to younger cheddar. The aging process allows for the breakdown of fats and proteins, creating a richer and more intense taste.",
        "source":
            "Cheddar cheese that has been matured for several months or years to enhance its flavor.",
        "category": "Dairy",
        "vendor": "The Dairy Farm",
        "imgPath": "https://cheesemaking.com/cdn/shop/files/cheddar-cheese-making-recipe.jpg?v=1743632339",
        "price": 350.00,
        "unit": "kg",
        "id": 20
      },
      {
        "name": "Pork Ground Lean",
        "description":
            "Lean ground pork is minced pork meat with a lower fat content, making it a healthier option for various dishes like meatballs, sauces, and fillings. While leaner, it still retains the characteristic flavor of pork and can be seasoned and cooked in many ways.",
        "source":
            "Minced meat from pigs, with a significant portion of the fat removed.",
        "category": "Meat",
        "vendor": "The Meat Farm",
        "imgPath": "https://goodfinds.ph/wp-content/uploads/2022/08/Ground-Pork-Lean.jpg",
        "price": 280.00,
        "unit": "kg",
        "id": 21
      },
      {
        "name": "Duck Eggs Fert",
        "description":
            "Fertilized duck eggs are laid by ducks that have mated, meaning the egg has the potential to develop into a duckling if incubated. Some people prefer fertilized eggs for their slightly richer flavor and texture, though there may be ethical considerations regarding their consumption.",
        "source": "Duck eggs that have been fertilized by a male duck.",
        "category": "Eggs",
        "vendor": "The Poultry Farm",
        "imgPath": "https://yongsooneggs.com.my/wp-content/uploads/2018/08/blown-duck-eggs-1_02.jpg",
        "price": 120.00,
        "unit": "dozen",
        "id": 22
      }
    ];

    return items.map((item) {
      final product = ProductModel(
          name: item['name'],
          description: item['description'],
          source: item['source'],
          category: item['category'],
          vendor: item['vendor'],
          imgPath: item['imgPath'],
          price: item['price'],
          unit: item['unit'],
          id: item['id']);

      return ProductModel(
          name: product.name,
          description: product.name,
          source: product.source,
          category: product.category,
          vendor: product.vendor,
          imgPath: product.imgPath,
          price: product.price,
          unit: product.unit,
          id: product.id,
          onTap: () {
            context.push('/product_details', extra: product);
          });
    }).toList();
  }
}
