library webide.themes;

import 'package:observe/observe.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';

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

abstract class ThemedElement extends PolymerElement {
  @observable Theme get theme => themeManager.theme;
  
  ThemedElement.created() : super.created() {
    _setupTheme();
  }
  
  void _setupTheme() {
    print('setupTheme for ${theme.cssPath}/$tagName.css');
    // 'shadowRoot.' will result in Removing disallowed element <LINK> (:1)
    // inserting a <link> into template does not work also!
    //shadowRoot.querySelector('template').appendHtml('<link rel="stylesheet" href="${theme.cssPath}/'+tagName.toLowerCase()+'.css">');
    
    // Using a style works
    // TODO(roberthartung): correct path
    StyleElement style = new StyleElement();
   /* :host {
    background-color: #ccc;
  }
  */
    style.text = "@import \"${theme.cssPath}/"+tagName.toLowerCase()+".css\";";
    shadowRoot.querySelector('template').append(style);
  }
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
  
  ThemeManger._();
  
  void setTheme(Theme theme) {
    this.theme = theme;
  }
}