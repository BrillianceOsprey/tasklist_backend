# tasklist_backend

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

CRUD API built with dart_frog

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis


## Getting Started 🚀

This project contains 3 Databases:

- firebase
- mongoDb
- postgresql

To run the routes and middleware use the following commands:

```sh
# For middleware
$ dart_frog new middleware "authentication/bearer"

# For routes
$ dart_frog new route "authentication/bearer"

# etc..
$ dart_frog new route "authentication/bearer[id]"
```

## Running commands 🧪
To run dart_forg server
```sh
# dart_frog dev
