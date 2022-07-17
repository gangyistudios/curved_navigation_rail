# curved_navigation_rail
[pub package](https://pub.dartlang.org/packages/curved_navigation_rail)

A Flutter package for easy implementation of curved navigation rail. Designed to be a ***direct drop-in replacement*** for [NavigationRail](https://api.flutter.dev/flutter/material/NavigationRail-class.html).

This is a fork of the [curved_navigation_bar](https://pub.dev/packages/curved_navigation_bar) package. Thank you to the developers of that package for inspiration. Now the same curved theme can consistently be applied in adaptive layouts!

![Gif](https://github.com/gangyistudios/curved_navigation_rail/blob/master/example/assets/example1.gif "NavigationRail drop-in example")

Retaining the same example as curved_navigation_bar:

![Gif](https://github.com/gangyistudios/curved_navigation_rail/blob/master/example/assets/example.gif "curved_navigation_rail example")

### Add dependency

```yaml
dependencies:
  curved_navigation_rail: ^2.0.0 #latest version
```

### Easy to use

- See minimal_example.dart in the examples

### Attributes

`destinations`: List of NavigationRailDestinations\
`selectedIndex`: index of NavigationRail, can be used to change current index or to set initial index\
`color`: Color of NavigationRail, default Colors.white\
`buttonBackgroundColor`: background color of floating button, default same as color attribute\
`backgroundColor`: Color of NavigationBar's background, defaults to the context theme's scaffoldBackgroundColor\
`onDestinationSelected`: Function handling taps on items, takes an int of the selectedIndex\
`animationCurve`: Curves interpolating button change animation, default Curves.easeOutCubic\
`animationDuration`: Duration of button change animation, default Duration(milliseconds: 600)\
`width`: Width of NavigationRail, min 0.0, max 75.0\
`letIndexChange`: Function which takes page index as argument and returns bool. If function returns false then page is not changed on button tap. It returns true by default\


### Examples 

1. minimal_example.dart - the bare minimum. 

2. change_page_programatically.dart - example of changing navigation rail item using a button on the page. 

3. navigation_rail_dropin.dart - direct replacement for NavigationRail. Just replace NavigationRail with CurvedNavigationRail!

4. navigation_rail_dropin_inverted.dart - extended example of navigation_rail_dropin.dart showing an inverted navigation rail, for right to left directionalities. (TO BE IMPLEMENTED). 


### Road map 

- Add support for Right-To-Left directionality, i.e. invert the CurvedNavigationRail when placed on the right of the screen.
- Add support for displaying text with the icon, and subsequently support for NavigationRailLabelType as a parameter input as used in NavigationRail. 
- Add parameter for height and alignment, to allow for greater customisation than just spaced evenly along the entire height. 
- Add support for adaptive layout, so that the rail extends to a drawer at a given width threshold. 
