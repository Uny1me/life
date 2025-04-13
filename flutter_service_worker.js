'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "9b94c1ed9452b2fada4bc0d15b6a90b6",
"version.json": "c94170f473e452ef61a939e74d0cc69d",
"index.html": "45cf1f26f30e5012f0ad24279fb48d98",
"/": "45cf1f26f30e5012f0ad24279fb48d98",
"main.dart.js": "25184211f89eb80ba24c1045fbdeca1a",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "5c6edf92f70350ee20ed2f999e8d34f8",
".git/ORIG_HEAD": "86dfa7d1289bfc5d6bf8c9fc2f7b1e43",
".git/config": "90ba1547403cfedef39d7f1bb197b8f7",
".git/objects/0d/32931b2c5b6c1519d6398c6dbdd3fae14f31fb": "ac966b41bb01ebf6117c50f2e6983a5b",
".git/objects/0c/a81f6c06ff14dabfd31ebb634a9b904dde5ca0": "2b6d73489c83249574af7867f92d6472",
".git/objects/50/08ddfcf53c02e82d7eee2e57c38e5672ef89f6": "d18c553584a7393b594e374cfe29b727",
".git/objects/68/dc59c3de8f4cfb3b7280c96188522c7297eafc": "0de9c94a1ba9504ad545ab0646366410",
".git/objects/3b/06da34b3d54999807e421f88b9010768ef6d08": "f866e372ac6ca30d75255d1b07ebb5d8",
".git/objects/9b/6f1768f627020735cef7996d67b9650c46bd11": "80ff2e52afce2c5bf6c3b202bb76e8a0",
".git/objects/32/aa3cae58a7432051fc105cc91fca4d95d1d011": "4f8558ca16d04c4f28116d3292ae263d",
".git/objects/69/d4a358737ff19fce6c94423d57fcce05423216": "d41e674dfd231bb68f6714c17b431acb",
".git/objects/3c/3a15a71acc941ac558874d85ed60daf5eb6ff4": "0f90f315b7104b4bcb52d7b23ebfcb2c",
".git/objects/a4/85cf9fa6aa1ecfe22e49f8e3e95a91580ab70c": "047c079c5fc99467f8a7eb716ca6f6b3",
".git/objects/bb/6530ef71841d94f317cfdba0258b93188bb839": "2c0f4534014282b0674720a942d437b8",
".git/objects/d7/98d5af655e566e376011702afda228a43035b6": "44c68a2a6a213bcb4aa7d0d49c616691",
".git/objects/d7/10cb85e683bd0bfe7fd724694f7107ccc52c1e": "b86f47fb040fff8d9c2afbb70514e762",
".git/objects/d0/23371979cf1e985205df19078051c10de0a82d": "700b71074bad7afee32068791dec7442",
".git/objects/be/62f3f8aacf8551c829760a13d46384c5969a0d": "bc8dc637edf06d7dbe9ebfc1b7e9b202",
".git/objects/da/fd65422747502c19b5c74b4230282644d2169c": "d8a62caf99a372ff6c7692e143787ce3",
".git/objects/d1/f278ede466e35ef3ff839cc253ef8893a11f35": "1b9b9bb5f9268b518008a9aef2eca090",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d6/c2571d8fd35fb9ac076dce51594f9d1f951343": "98f449265c6b5a0295378cc908575c60",
".git/objects/e2/08bade79791a9ed933ad71c93cde17a56dff71": "53aaa75086997525765031be4011a334",
".git/objects/e2/6a684f5a3882311b140be4f63e24893ef614ce": "c51900232449dd54680e8dfd0b07bdba",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ee/3736ceabd3cfb64c22e8a7f75b67f300634928": "aa61377452846cb7613410d5e433ac49",
".git/objects/fc/d691a97179952e86a05dd7dd6bd24cc40ba39b": "8557a92d7c4ef68c58d67d010ab3fbfc",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f2/35ea6a85938ae60121030c542ca32bd1d054fd": "8ffa96dd884621b31c6ece018520bb19",
".git/objects/f2/5a85a27aedcc110aaaba95fc9c6177ba822090": "f3d79b3de93d82ef391736d2b7804e38",
".git/objects/e3/2034ea13ebf7a92695b064c2c321cbfd77e59d": "e449c6a6b651df1c3562e16f155c2605",
".git/objects/e3/ce141a0f4e3a1bee37e49cccd45a21ebad8bcb": "29ed5676d5f34387156bb903c124103b",
".git/objects/e4/fafb5a01f37bd7caef83f3fe3b0b63e5ea83a2": "ff392cd40d2ea2b02cc8d90ce92c40e6",
".git/objects/fe/e0b8715e25c797d832e6247a612c68df31eb85": "2042e6befca5b4e1769ba40d735673ff",
".git/objects/ec/e57e5173a30a9395555042ac328fc7b8c7d03d": "120f8c6c1ddd089fa99f5419aa04b3b0",
".git/objects/20/8a6b41ad0d66471f67df65152e6daf388e3847": "fb4953e2c236dfb297ce5ae0344d5055",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/17/764c124b35fabf0f06aa2821b278b9e8ea79f3": "198f2189968cc48b9699e89af3709ea9",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/19/54f4d766dd57591a128e77b07544830a79d2c7": "cf174f8dc3cdda5685234a3f448d5b12",
".git/objects/4c/a5413d9422ae964ecba653a251235929ff970e": "bb47d6aa98c778b0144e5f7f7472d796",
".git/objects/75/a6c7e32999d566f3fbe81f51b9b4845f6bef53": "70598ec990c14cdd9d1af6be8811cbbc",
".git/objects/86/a9a36cc29751b7287c8a461d105ac874d53b88": "5e5a557b96722996477931f70b3f938b",
".git/objects/44/a8b8e41b111fcf913a963e318b98e7f6976886": "5014fdb68f6b941b7c134a717a3a2bc6",
".git/objects/44/0297bab0c4f56c6e44ccc249802d1c34f7299a": "3d0e73f2592fb9de9962c3a93b5c019c",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/6b/e909fbf40b23748412f0ea89bf0fae827ed976": "5f118419157d9534688915220cc803f7",
".git/objects/36/e33abeb3e9d83ccc3ab93c21b73900c484f9ec": "468f2d954dcdafd3b0d3368a788f5c52",
".git/objects/91/24df5837d110cc748c513914a6f8dc9e365c31": "657960b8225283fc9f148ffe51c5d48f",
".git/objects/3a/7525f2996a1138fe67d2a0904bf5d214bfd22c": "ab6f2f6356cba61e57d5c10c2e18739d",
".git/objects/98/57c9b3b0448c92818efc5fda0f206b21914168": "ecbde07c564dabbec0f249821051b8af",
".git/objects/37/7031f1d597090b590ebb9433b387ec552f50d4": "ba091ba73753cd198a66d7dfcab53994",
".git/objects/08/32d0db2def1613c1c45aa4fe9156a1c6b7d589": "e05df183e5eeaddf39672a2516f9c41d",
".git/objects/6d/3c50e904f2ee05f92affe89730bac103309aa2": "64f53fb2e6cd5697629e55d0591ac026",
".git/objects/99/fe532d5af78f66b7c791b83442e4ae9ebc554a": "2faf5393ce297611e8a2e4881b4bff7d",
".git/objects/90/bcfcf0a77ab618a826db0fd8b0942963b653af": "fc109675cdf1233dd6599a4c3c0a7a69",
".git/objects/d3/d87a98fe916b5ae3cb4e3fffd3ca8a78d0a6d8": "5f86d8c754cf4ddd7dac9741fe9bd0e5",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d4/6430d6efbe566ba6f8d879755b6672f8df3341": "e0ae76d80ea0117d2c6d3e1b7d07fa9a",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/ba/afc58ee42c73c2cadc59b678127fc55f4b1960": "563e479e4909b303618c1715a57e8780",
".git/objects/b1/5ad935a6a00c2433c7fadad53602c1d0324365": "8f96f41fe1f2721c9e97d75caa004410",
".git/objects/b1/6730c6aa05d21b28934d106e78bcb5070c89f5": "6ddfde37a90da2fdc3472d5581efa637",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b0/346b578e3f39a679c9951276ff864110b28c3a": "5944a1c0c6f5731eda5ca31b05bf5a2c",
".git/objects/a6/e4e797b1fdfe8823e6ecefd93bcb61336587d4": "c22020d60ea5d1d818b8652224676e8a",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/df0c03ed3ee578125b69469322c967eb8cdc92": "719239a2da97caacb14479664f869093",
".git/objects/c4/c84acc0ee14bb6e0c8fc89ad89b8bc599be624": "6855c80469dfce1295c4b70cfd95cbd0",
".git/objects/e1/8997e8450f1ac4a7090e751eb62740d3f26a98": "9a7a452511c62b06fe68f7a33b8efcad",
".git/objects/e6/5976da5d1afa77c208c94b732ca20e2682d60f": "477b4b3aff7c9f74d4e1c2bd94813a66",
".git/objects/c2/d3b615637cbb64d5e7c6469c82207af300235f": "7b23a57ed3a5fe6a6cd07e58598a0ce5",
".git/objects/46/7b28119c6d741caec6e2d2a35ab7d7f01e08bf": "f4db87c57ba4aa6c724e7ecaa6707d58",
".git/objects/2d/b801f7d3bced9c3ce33b3041df71544da0d9c2": "702decddfebfc262da69466404874f25",
".git/objects/77/0ad9c5e6facab9b270878474586e85c41b6ce7": "8287025f338486f70dfbe5126d5cb875",
".git/objects/77/e84289ffaf809968c056a72893917b59d10dbb": "49cd5898085e3947713bd148308e98cf",
".git/objects/70/42e85823a114cf0b2334eafd18993317dabb5b": "fa37755debf028fa061c7fa4784ab0c3",
".git/objects/84/0516208d35dcb4298847ab835e2ef84ada92fa": "36a4a870d8d9c1c623d8e1be329049da",
".git/objects/24/d7ec452d11ea8aed4c3014ee9e89b8a8fe15af": "5b22b524f5bf107fe1e2aa180cd682ad",
".git/objects/23/a09b188449276bd8ea7081f40f4789db15a887": "8c8a8b7355c6038efd6a0585841b500c",
".git/objects/12/c5f27777e4025482c9c6820c964b5ac7becb7f": "719910bb3fa6dfb8510d65080a1daa33",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/2e/5d657b528b02a54e0ae65354b3ac5d78dbde8d": "33388f2413e4fce3176e464ab751d910",
".git/objects/47/71c6d276d17cac6632c0c9130fb447ef0454bc": "2652c9fc017dea10f2cd58dcda416983",
".git/objects/7f/0fe127f411c5970c23c5dfc75604ca345894e0": "4b5852a8cf1e498d654f6d81fb0b3aa1",
".git/objects/25/8b3eee70f98b2ece403869d9fe41ff8d32b7e1": "05e38b9242f2ece7b4208c191bc7b258",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "cca2a8ecd0077e583097769be8c444ba",
".git/logs/refs/heads/main": "cca2a8ecd0077e583097769be8c444ba",
".git/logs/refs/remotes/origin/main": "6f38c5c900840e02d8cf11a9e4d2554e",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/main": "3cd593e115f96503aaa4f0939328ce6c",
".git/refs/remotes/origin/main": "3cd593e115f96503aaa4f0939328ce6c",
".git/index": "4727f1087d410a8a53e937a9dbd48812",
".git/packed-refs": "a891e6bb26eb0d480aef486a7e8ea166",
".git/COMMIT_EDITMSG": "ddea84c62ec7ff1e47770340c12a098a",
".git/FETCH_HEAD": "e20022386945f038aa7d9a99dd70742b",
"assets/AssetManifest.json": "9fc4a8e8c7c7257784ca1f4863184a0f",
"assets/NOTICES": "6fb181225fd9ca07b418f278ca0739d2",
"assets/FontManifest.json": "dc3365cda5aac9a8c988a48750ed914f",
"assets/AssetManifest.bin.json": "3f35c09e6aa1545d7e01f71d19c112cb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/youtube_player_iframe/assets/player.html": "663ba81294a9f52b1afe96815bb6ecf9",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "db1fcebba1b808d984bf959e69a68746",
"assets/fonts/MaterialIcons-Regular.otf": "083fe5ae113ce61d443c362c4f32d64c",
"assets/assets/images/onboarding-2.jpg": "b31f2d825e11160d66cc06aa57f07f95",
"assets/assets/images/onboarding-3.png": "8b9f71949d31ddb5de1ae0a9ea25686c",
"assets/assets/images/onboarding-1.png": "3734ece660004d56e4364488948d3489",
"assets/assets/images/hard.png": "8b397cf33be32de058fd3a511bb1776d",
"assets/assets/images/fast.png": "e8dd03fc36192bf80c9e6419c34d37a9",
"assets/assets/icons/goal.svg": "75037bcc98b5faecf8764566a907065f",
"assets/assets/icons/exercise.svg": "e2a91dfcf1b140d856b801483152b5b2",
"assets/assets/icons/flame.svg": "7f3261b5a040a052bb8bc65243161fc1",
"assets/assets/icons/moon.svg": "4c128f6c67760d7221c06f471bc90037",
"assets/assets/fonts/WorkSans-Regular.ttf": "a3d6c7f7606fc33a6ab5bed9688d1fe8",
"assets/assets/fonts/WorkSans-Light.ttf": "02db4b738c689e05f3f12b3f22969815",
"assets/assets/fonts/WorkSans-ExtraBold.ttf": "bbd6edc88df326a3283424a0a1c711f0",
"assets/assets/fonts/WorkSans-ExtraLight.ttf": "16ad283672151ea426e8c98d8ad0cfb5",
"assets/assets/fonts/WorkSans-Medium.ttf": "73f5c36f3da9740c41b2c1aeb7fc94e5",
"assets/assets/fonts/WorkSans-SemiBold.ttf": "c1b2dde1705db3ada7fd668c36523f66",
"assets/assets/fonts/WorkSans-Thin.ttf": "6b3fb1a15d5c60fd9944e8c218525984",
"assets/assets/fonts/WorkSans-Bold.ttf": "1559ffc7cf61cbae7ea55a250722009c",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
