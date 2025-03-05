# Imagify

This is a simple AI based image generation application. It consists of two pages:

1. Home Page: In the home page, there are two text inputs for the label and the description. One can not generate image without providing a label and a description.
2. Result Page: After providing a label and a description, the user can generate an image which approximately takes 10 seconds. Output image is displayed in the Result Page.

## How to Run the Application?
Clone the repository and then:
- Install Flutter
- Install Pre-commit (not necessary but highly recommended for better development environment)
```bash
# Inin pre-commit
pre-commit install

# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build

# Run the tests
flutter flutter test

# Run the application
flutter run
```
