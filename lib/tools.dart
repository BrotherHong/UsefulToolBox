
import 'package:flutter/material.dart';
import 'package:useful_toolbox/pages/base_converter_page.dart';
import 'package:useful_toolbox/pages/ncku_id_verify_page.dart';
import 'package:useful_toolbox/pages/prime_number_page.dart';
import 'package:useful_toolbox/widgets/tool_tile_view.dart';

const toolsView = [
  ToolTileView('進制轉換', Icons.computer, BaseConverterPage('進制轉換')),
  ToolTileView('判別質數', Icons.onetwothree, PrimeNumberPage('判別質數')),
  ToolTileView('成大學號驗證', Icons.verified, IdVerifyPage('成大學號驗證')),
];