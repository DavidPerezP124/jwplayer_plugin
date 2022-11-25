An unofficial flutter plugin for the JWPlayer platform
**Note**: This is currently in alpha

Use this package for embedding a native video player for iOS, Android and Web.

The interfaces in this package are:

`JWVideoPlayer`: The video player widget
`JWPlayerController`: The controller for the player, for APIs such as play, pause, stop. And to listen to value updates from the player.
`JWPlayerConfiguration`: A configuration that will be used to configure the player.
___
### Example
See [example](https://github.com/DavidPerezP124/jwplayer_plugin/tree/main/jwplayer/example) for an implementation of the library.

### Usage
```dart
// If you are using mobile, 
// you need to set your licence somewhere in the app.
void main() async {
  JWVideoPlayer.setLicenseKey({JW_LICENSE});
  runApp(const App());
}

class App extends StatelessWidget {
    JWPlayerConfiguration config = JWPlayerConfiguration(
        file: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8"
    );
    const App({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Title',
            home: JWVideoPlayer(
                config: config1,
            ),
        );
    }
}
```
## Requirement for web
On the dart side it is the same as above, except no license is required but you need to add the script for the player, that you can get from your [JWPlayer dashboard](https://dashboard.jwplayer.com) or using the [JWPlayer Management API](https://docs.jwplayer.com/platform/reference/get_v2-sites-site-id-players-player-id-).
```html
<!DOCTYPE html>
<html>
<head>
  ...
  <!-- Set your JWPlayer script here -->
  <!-- This should be a player from the JW dashboard or from requesting it more info here https://docs.jwplayer.com/platform/docs/players-get-started -->
  <script src="https://cdn.jwplayer.com/libraries/{PLAYER_ID}.js"></script>
  ...
</head>
<body>
  ...
</body>
</html>
```
---
More examples will be added.

### Reporting issues
You can create a new issue on the [plugin repo](https://github.com/DavidPerezP124/jwplayer_plugin).

0.0.1

- [ ] Full configuration support
- [ ] Wiki addition for plugin
- [ ] Native players with Flutter UI
- [ ] API interface for supported platforms
- [ ] Delegate methods for supported platforms
- [ ] DRM implementations
- [ ] Cookie headers