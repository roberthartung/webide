library webide.themes;

import 'package:observe/observe.dart';

/**
 * Theme interface can be used to define own Themes
 * 
 * TODO(roberthartung): Should the Theme class be used as an interface or be extended?
 */

abstract class Theme {
  /**
   * Name of this theme
   */
  
  String name;
  
  /**
   * CSS base path (without / at the end)
   */
  
  String get cssPath;
}

final themeManager = new ThemeManger._();

/**
 * ThemedElement - Used to make polymer elements use the current theme
 * 
 * @mixin
 */

abstract class ThemedElement {
  @observable Theme get theme => themeManager.theme;
}

/**
 * webIDE's default theme
 */

class DefaultTheme implements Theme {
  String name = "default";
  
  // TODO(roberthartung): Subfolder structure?
  String get cssPath => "packages/webide/css/themens/" + name;
}

/**
 * Layout manager
 */

class ThemeManger extends Observable {
  /**
   * Current theme
   */
  
  @observable Theme theme = new DefaultTheme();
  
  /**
   * Private constructor
   */
  
  ThemeManger._() {
    
  }
}