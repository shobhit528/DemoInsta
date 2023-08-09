part of 'AnimationClass.dart';

/*
class ExampleAnimation extends StatefulWidget {
  const ExampleAnimation({Key? key}) : super(key: key);

  @override
  _ExampleAnimationState createState() => _ExampleAnimationState();
}

class _ExampleAnimationState extends State<ExampleAnimation> {
  void _togglePlay() {
    if (_controller == null) {
      return;
    }
    setState(() => _controller!.isActive = !_controller!.isActive);
  }

  bool get isPlaying => _controller?.isActive ?? false;

  Rive.RiveAnimationController? _controller;

  @override
  void initState() {
    super.initState();
    // _controller = Rive.SimpleAnimation('idle');
    _controller = Rive.SimpleAnimation('trigSuccess');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Example'),
      ),
      body: Center(
        child: Rive.RiveAnimation.asset(
          'assets/images/login_screen.riv',
          controllers: [_controller!],
          // Update the play state when the widget's initialized
          onInit: (atr) => setState(() {}),
        ),
        // : Rive.Rive(artboard: _riveArtboard!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlay,
        tooltip: isPlaying ? 'Pause' : 'Play',
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
*/

class PlayOneShotAnimation extends StatefulWidget {
  const PlayOneShotAnimation({Key? key}) : super(key: key);

  @override
  _PlayOneShotAnimationState createState() => _PlayOneShotAnimationState();
}

class _PlayOneShotAnimationState extends State<PlayOneShotAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
  // /// Controller for playback
  // late Rive.RiveAnimationController _controller;
  //
  // /// Is the animation currently playing?
  // bool _isPlaying = false;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = Rive.OneShotAnimation(
  //     'bounce',
  //     autoplay: false,
  //     onStop: () => setState(() => _isPlaying = false),
  //     onStart: () => setState(() => _isPlaying = true),
  //   );
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('One-Shot Example'),
  //     ),
  //     body: Center(
  //       child: Rive.RiveAnimation.network(
  //         'https://cdn.rive.app/animations/vehicles.riv',
  //         animations: const ['idle', 'curves'],
  //         controllers: [_controller],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       // disable the button while playing the animation
  //       onPressed: () => _isPlaying ? null : _controller.isActive = true,
  //       tooltip: 'Play',
  //       child: const Icon(Icons.arrow_upward),
  //     ),
  //   );
  // }

}