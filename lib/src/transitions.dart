/// Available transition types for page navigation.
///
/// Each type provides a different visual effect when navigating between pages.
enum PageTransitionType {
  /// Use the platform's default transition.
  platform,

  /// Fade transition - page fades in/out.
  fade,

  /// Slide from right to left.
  slideRight,

  /// Slide from left to right.
  slideLeft,

  /// Slide from bottom to top.
  slideUp,

  /// Slide from top to bottom.
  slideDown,

  /// Scale transition - page scales in/out.
  scale,

  /// Rotation transition - page rotates in.
  rotation,

  /// Size transition - page grows/shrinks.
  size,

  /// Slide and fade combination.
  slideAndFade,

  /// No transition - instant navigation.
  none,

  /// Custom parallax transition with depth.
  parallax,

  /// Morphing transition that transforms elements.
  morphing,

  /// Flip transition - page flips like a card.
  flip,

  /// Zoom transition with focal point.
  zoom,

  /// Elastic bounce effect.
  elastic,
}

/// Transition configuration for a route.
///
/// Use this class to customize the transition animation for specific routes.
class TransitionConfig {
  /// Creates a transition configuration.
  const TransitionConfig({
    this.type = PageTransitionType.platform,
    this.durationMs = 300,
    this.reverseDurationMs,
    this.curveType = 'easeInOut',
    this.reverseCurveType,
  });

  /// The type of transition to use.
  final PageTransitionType type;

  /// The duration of the forward transition in milliseconds.
  final int durationMs;

  /// The duration of the reverse transition in milliseconds.
  /// If null, uses [durationMs].
  final int? reverseDurationMs;

  /// The curve to use for the forward transition.
  /// Common values: 'linear', 'easeIn', 'easeOut', 'easeInOut', 'bounceIn', 'bounceOut'
  final String curveType;

  /// The curve to use for the reverse transition.
  /// If null, uses [curveType].
  final String? reverseCurveType;

  /// A convenient fade transition configuration.
  static const TransitionConfig fade = TransitionConfig(
    type: PageTransitionType.fade,
  );

  /// A convenient slide right transition configuration.
  static const TransitionConfig slideRight = TransitionConfig(
    type: PageTransitionType.slideRight,
  );

  /// A convenient slide left transition configuration.
  static const TransitionConfig slideLeft = TransitionConfig(
    type: PageTransitionType.slideLeft,
  );

  /// A convenient slide up transition configuration.
  static const TransitionConfig slideUp = TransitionConfig(
    type: PageTransitionType.slideUp,
  );

  /// A convenient slide down transition configuration.
  static const TransitionConfig slideDown = TransitionConfig(
    type: PageTransitionType.slideDown,
  );

  /// A convenient scale transition configuration.
  static const TransitionConfig scale = TransitionConfig(
    type: PageTransitionType.scale,
  );

  /// A convenient no transition configuration.
  static const TransitionConfig none = TransitionConfig(
    type: PageTransitionType.none,
    durationMs: 0,
  );
}

/// Annotation to specify transition configuration for a page.
///
/// Use this annotation on your page classes to customize their transition.
///
/// Example:
/// ```dart
/// @PageTransition(TransitionConfig.fade)
/// class HomePage extends StatelessWidget {
///   // ...
/// }
/// ```
class PageTransition {
  /// Creates a page transition annotation.
  const PageTransition(this.config);

  /// The transition configuration for this page.
  final TransitionConfig config;
}
