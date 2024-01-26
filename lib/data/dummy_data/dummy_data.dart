import 'package:ascom/features/shop/models/brand_model.dart';
import 'package:ascom/features/shop/models/product_attribute_model.dart';
import 'package:ascom/features/shop/models/product_variation_model.dart';
import 'package:ascom/routes/routes.dart';
import 'package:ascom/utils/constants/image_strings.dart';
import '../../features/shop/models/banner_model.dart';
import '../../features/shop/models/category_model.dart';
import '../../features/shop/models/product_model.dart';

/// -- List of All Products
final List<ProductModel> products = [
  ProductModel(
    id: '001',
    stock: 12,
    price: 6000,
    title: "Shoes Red Nike",
    thumbnail: AImages.productImage14,
    description: "Shoes Nike Red",
    brand: BrandModel(id: '1', name: 'Nike', image: AImages.accessoryIcon, productsCount: 235, isFeatured: true), 
    images: [AImages.productImage13, AImages.productImage15, AImages.productImage21], 
    salePrice: 5000, 
    sku: "ABR4562",
    categoryId: '1',
    productAttributes: [
      ProductAttributeModel(name: 'Couleur', values: ['Vert', 'Bleu', 'Orange']), 
      ProductAttributeModel(name: 'Taille', values: ['EU 30', 'EU 31', 'EU 33'])
    ],
    productVariations: [
      ProductVariationModel(
        id: '1', 
        stock: 25, 
        price: 3500, 
        salePrice: 3000, 
        image: AImages.productImage16, 
        description: 'This is a Product description for Red Nike Sports Shoes.',
        attributeValues: {'Couleur':'Vert', 'Taille':'EU 35'},
      ),
      ProductVariationModel(
        id: '2', 
        stock: 26, 
        price: 7500, 
        salePrice: 6000, 
        image: AImages.productImage18, 
        description: 'This is a Product description for Red Nike Sports Shoes.',
        attributeValues: {'Couleur':'Bleu', 'Taille':'EU 41'},
      ),
        ProductVariationModel(
        id: '3', 
        stock: 15, 
        price: 2500, 
        salePrice: 2000, 
        image: AImages.productImage20, 
        description: 'This is a Product description for Red Nike Sports Shoes.',
        attributeValues: {'Couleur':'Jaune', 'Taille':'EU 26'},
      ),
    ],
    productType:' ProductType.variable',
  ),
];

/// -- Banners
final List<BannerModel> banners = [
  BannerModel(
      targetScreen: ARoutes.order, imageUrl: AImages.banner5, active: false),
  BannerModel(
      targetScreen: ARoutes.cart, imageUrl: AImages.banner6, active: true),
  BannerModel(
      targetScreen: ARoutes.favourites,
      imageUrl: AImages.banner7,
      active: true),
  BannerModel(
      targetScreen: ARoutes.settings, imageUrl: AImages.banner8, active: true),
  BannerModel(
      targetScreen: ARoutes.search, imageUrl: AImages.banner1, active: true),
  BannerModel(
      targetScreen: ARoutes.userAddress,
      imageUrl: AImages.banner2,
      active: true),
  BannerModel(
      targetScreen: ARoutes.checkout, imageUrl: AImages.banner3, active: true),
  BannerModel(
      targetScreen: ARoutes.onBoarding,
      imageUrl: AImages.banner4,
      active: true),
];

/// -- List of all Categories
final List<CategoryModel> categories = [
  CategoryModel(
      id: '1', name: 'Sports', image: AImages.sportIcon, isFeatured: true),
  CategoryModel(
      id: '2', name: 'Meubles', image: AImages.furnitureIcon, isFeatured: true),
  CategoryModel(
      id: '3',
      name: 'Electroniques',
      image: AImages.electronisIcon,
      isFeatured: true),
  CategoryModel(
      id: '4',
      name: 'Habillements',
      image: AImages.clothIcon,
      isFeatured: true),
  CategoryModel(
      id: '5', name: 'Animals', image: AImages.animalIcon, isFeatured: true),
  CategoryModel(
      id: '6', name: 'Chaussures', image: AImages.shoeIcon, isFeatured: true),
  CategoryModel(
      id: '7',
      name: 'Cosmétiques',
      image: AImages.cosmeticsIcon,
      isFeatured: true),
  CategoryModel(
      id: '8',
      name: 'Accessoires',
      image: AImages.accessoryIcon,
      isFeatured: true),

  /// SubCategories
  CategoryModel(
      id: '9',
      name: 'Chaussures Sport',
      image: AImages.sportIcon,
      parentId: '1',
      isFeatured: false),
  CategoryModel(
      id: '10',
      name: 'Sous Vêtements',
      image: AImages.sportIcon,
      parentId: '1',
      isFeatured: false),
  CategoryModel(
      id: '11',
      name: 'Equipements Sports',
      image: AImages.sportIcon,
      parentId: '1',
      isFeatured: false),

  /// Furnitures
  CategoryModel(
      id: '12',
      name: 'Meubles Maisons',
      image: AImages.furnitureIcon,
      parentId: '5',
      isFeatured: true),
  CategoryModel(
      id: '13',
      name: 'Meubles Bureaus',
      image: AImages.furnitureIcon,
      parentId: '5',
      isFeatured: true),
  CategoryModel(
      id: '14',
      name: 'Meubles Restaurants',
      image: AImages.furnitureIcon,
      parentId: '5',
      isFeatured: true),

  /// Electronics
  CategoryModel(
      id: '15',
      name: 'Ordinateurs',
      image: AImages.electronisIcon,
      parentId: '2',
      isFeatured: true),
  CategoryModel(
      id: '16',
      name: 'Téléphones',
      image: AImages.electronisIcon,
      parentId: '2',
      isFeatured: true),

  /// Clothes
  CategoryModel(
      id: '17',
      name: 'T-Shirts',
      image: AImages.clothIcon,
      parentId: '3',
      isFeatured: true),
];
