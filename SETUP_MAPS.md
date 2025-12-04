# Google Maps Setup for Bellevueopoly

This guide walks you through setting up Google Maps API keys for Android and iOS development.

## Prerequisites
- Google Cloud Console account
- Active Google Cloud project with billing enabled
- Flutter project with `google_maps_flutter` dependency (already added)

## Steps to Get API Keys

### 1. Google Cloud Console Setup
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create a new project or select existing project
3. Enable the following APIs:
   - **Maps SDK for Android**
   - **Maps SDK for iOS**
   - **Geocoding API** (optional, for address lookup)

4. Go to **Credentials** → **Create Credentials** → **API Key**
   - Copy the generated API key (you'll need separate keys for Android/iOS in production, but one key works for dev)

### 2. Android Configuration

**Add API Key to AndroidManifest.xml:**

Edit `android/app/src/main/AndroidManifest.xml` and add this meta-data inside the `<application>` tag (before the closing `</application>`):

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ANDROID_API_KEY_HERE" />
```

Replace `YOUR_ANDROID_API_KEY_HERE` with your actual API key from Google Cloud Console.

**Example:**
```xml
<application
    android:label="bellevueopoly_iteration_1"
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher">
    
    <!-- ... existing activities ... -->
    
    <!-- Google Maps API Key -->
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="AIzaSyDxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" />
        
    <!-- Don't delete the meta-data below. -->
    <meta-data
        android:name="flutterEmbedding"
        android:value="2" />
</application>
```

### 3. iOS Configuration

**Add API Key to Info.plist:**

Edit `ios/Runner/Info.plist` and add the following key-value pair in the root `<dict>`:

```xml
<key>io.flutter.embedded_views_preview</key>
<true/>
<key>UIBackgroundModes</key>
<array>
    <string>location</string>
</array>
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to your location to show nearby businesses.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs access to your location to show nearby businesses.</string>
<key>GMSApiKey</key>
<string>YOUR_IOS_API_KEY_HERE</string>
```

Replace `YOUR_IOS_API_KEY_HERE` with your API key.

### 4. Web Configuration (Optional)

For web platform, add the API key to `web/index.html`:

```html
<script async defer 
    src="https://maps.googleapis.com/maps/api/js?key=YOUR_WEB_API_KEY_HERE&libraries=places">
</script>
```

### 5. Verification

After adding the API keys:

1. Run `flutter clean`
2. Run `flutter pub get`
3. Run `flutter run` (on your target platform)
4. The map should load without errors; if you see "Map initialization failed" or blank map, check:
   - API key is correct
   - APIs (Maps SDK for Android/iOS) are enabled in Google Cloud Console
   - Application restrictions match your package name (e.g., `com.example.bellevueopoly_iteration_1`)
   - Location permissions are granted (see system permission prompts)

### 6. API Key Restrictions (Production)

For production, restrict your API keys:

- **Android**: Restrict to Android apps, add your app's package name and SHA-1 fingerprint
  ```
  Package name: com.example.bellevueopoly_iteration_1
  SHA-1: (get from `flutter run` output or `keytool -list -v -keystore ~/.android/debug.keystore`)
  ```
- **iOS**: Restrict to iOS apps, add your bundle identifier
  ```
  Bundle ID: com.example.bellevueopoly_iteration_1
  ```
- **Web**: Restrict to your domain(s)

### 7. Location Permissions

Ensure location permissions are configured:

- **Android**: Already added to `android/app/src/main/AndroidManifest.xml`
  ```xml
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  ```
- **iOS**: Added `NSLocationWhenInUseUsageDescription` in Info.plist (see step 3)

### 8. Testing Geolocation

Once the app is running:

1. Open HomeScreen — you should see the map centered on Bellevue (47.6205, -122.2022)
2. Business markers should appear as location pins
3. If you enabled location services on the device/emulator, your position (blue dot) should appear
4. Tap a marker or business card to navigate to BusinessDetailScreen
5. Approach a business (within 50m in emulator) to trigger auto-visit logging

### Troubleshooting

**Map is blank or shows gray area:**
- Check API key is correct and APIs are enabled
- Check internet connectivity
- Verify map initialization succeeded (check logs: `flutter run`)

**"Only authorization tokens with an explicit `goog-allowed-client-IDs` field" error:**
- Ensure Maps SDK for Android/iOS is enabled (not just Maps API)
- Regenerate the API key if needed

**Location not showing:**
- Check location permissions are granted in system settings
- On emulator, set GPS location in Extended Controls
- Verify `locationServiceProvider` is streaming positions

**Auto-visit not triggering:**
- Check proximity threshold (default 50m) and cooldown (60s)
- Verify device/emulator location is within threshold
- Check gameStateProvider/playerProvider are updating (ProfileScreen should show visits)

For more details, see:
- [Google Maps SDK for Flutter](https://pub.dev/packages/google_maps_flutter)
- [Geolocator Package](https://pub.dev/packages/geolocator)
- [Google Cloud Console APIs](https://console.cloud.google.com)
