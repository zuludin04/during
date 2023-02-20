import 'package:during/data/source/entity/category_entity.dart';

const savingPickedType = 'saving_picked';
const savingDetailType = 'saving_detail';
const emptySavingHash =
    '6382e3553f60f84fd8819574ede44e5202883dbd'; // during empty saving

/// category type
/// 1 = saving
/// 2 = income
/// 3 = expense
var initialCategories = [
  CategoryEntity(
      name: 'Transfer', icon: 'icon_transfer.svg', type: 4, color: '9E9E9E'),
  CategoryEntity(name: 'Bank', icon: 'icon_bank.svg', type: 1, color: '2196F3'),
  CategoryEntity(
      name: 'E-Money', icon: 'icon_emoney.svg', type: 1, color: '009688'),
  CategoryEntity(name: 'Cash', icon: 'icon_cash.svg', type: 1, color: 'FFC107'),
  CategoryEntity(name: 'Fee', icon: 'icon_fee.svg', type: 2, color: '2196F3'),
  CategoryEntity(
      name: 'Bonus', icon: 'icon_bonus.svg', type: 2, color: '009688'),
  CategoryEntity(
      name: 'Selling', icon: 'icon_selling.svg', type: 2, color: 'FFC107'),
  CategoryEntity(
      name: 'Education', icon: 'icon_education.svg', type: 3, color: '2196F3'),
  CategoryEntity(name: 'Food', icon: 'icon_food.svg', type: 3, color: '009688'),
  CategoryEntity(
      name: 'Grocery', icon: 'icon_groceries.svg', type: 3, color: 'FFC107'),
  CategoryEntity(
      name: 'Health', icon: 'icon_health.svg', type: 3, color: '9C27B0'),
  CategoryEntity(name: 'Home', icon: 'icon_home.svg', type: 3, color: '3F51B5'),
  CategoryEntity(
      name: 'Subscription',
      icon: 'icon_subcription.svg',
      type: 3,
      color: '607D8B'),
  CategoryEntity(
      name: 'Transportation',
      icon: 'icon_transportation.svg',
      type: 3,
      color: 'F44336'),
  CategoryEntity(
      name: 'Travel', icon: 'icon_travel.svg', type: 3, color: '3F51B5'),
];

var categories = [
  'icon_wallet.svg',
  'icon_airplane.svg',
  'icon_bank.svg',
  'icon_barcode.svg',
  'icon_bitcoin.svg',
  'icon_bonus.svg',
  'icon_box.svg',
  'icon_briefcase.svg',
  'icon_brush.svg',
  'icon_camera.svg',
  'icon_cash.svg',
  'icon_category.svg',
  'icon_coffee.svg',
  'icon_delivery.svg',
  'icon_discount.svg',
  'icon_education.svg',
  'icon_emoney.svg',
  'icon_fee.svg',
  'icon_food.svg',
  'icon_game.svg',
  'icon_gas.svg',
  'icon_groceries.svg',
  'icon_health.svg',
  'icon_home.svg',
  'icon_lamp.svg',
  'icon_microphone.svg',
  'icon_mobile.svg',
  'icon_pet.svg',
  'icon_project.svg',
  'icon_selling.svg',
  'icon_subcription.svg',
  'icon_ticket.svg',
  'icon_transportation.svg',
  'icon_travel.svg',
  'icon_bus.svg',
  'icon_cake.svg',
  'icon_clock.svg',
  'icon_folder.svg',
  'icon_globe.svg',
  'icon_monitor.svg',
  'icon_receipt.svg',
  'icon_scan.svg',
  'icon_shop.svg',
  'icon_star.svg',
  'icon_tag.svg',
  'icon_topup.svg',
  'icon_unlimited.svg',
  'icon_fitness.svg',
  'icon_signpost.svg',
];

var types = ['Saving', 'Income', 'Expense'];

const categoryColors = [
  'F44336', // red
  'E91E63', // pink
  '9C27B0', // purple
  '673AB7', // deep purple
  '3F51B5', // indigo
  '2196F3', // blue
  '03A9F4', // light blue
  '00BCD4', // cyan
  '009688', // teal
  '4CAF50', // green
  '8BC34A', // light green
  'CDDC39', // lime
  'FFEB3B', // yellow
  'FFC107', // amber
  'FF9800', // orange
  'FF5722', // deep orange
  '795548', // brown
  '9E9E9E', // grey
  '607D8B', // blue grey
];
