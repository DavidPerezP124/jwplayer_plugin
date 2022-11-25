# jwplayer_example

To run the example app you need to add a .env file to the `/example` dir, i.e: `/example/.env`.

The `.env` file should contain the following:
```txt
ANDROID_LICENSE="{YOUR_ANDROID_V4_LICENSE}"
IOS_LICENSE="{YOUR_iOS_V4_LICENSE}"
```
To run on web, you need to add a player script to the `example/web/index.html` file:
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