# GPT Window

**GPT Window** is an open-source version of VERA designed to provide quick access to popular AI models like ChatGPT, Google Gemini, Claude, and more. This lightweight tool allows users to interact with these models seamlessly through a simple, responsive window that appears with a single keyboard shortcut.

## Features

- **Quick Access Window**: Press `Ctrl + Space` to instantly bring up a window from the left side of your screen.
- **WebView Integration**: Load AI models like ChatGPT (currently supported) directly in the app through embedded WebViews.
- **Future Expansion**: The project is designed to be expandable, with plans to add support for Google Gemini, Claude, and other AI models in future releases.

## Installation (brew)

1.  **Tap repo using brew**
    ```bash
    brew tap AbhijeetDash/gptwindow
    ```
2. **Install the latest release**
    ```bash
    brew install --cask gpt-widget 
    ```
3. **Open the installed app**
    ```bash
    open /Applications/
    ```
    Right Click on gptwidget -> click open Anyways.

## Installation

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/yourusername/gpt_window.git
    ```

2. **Build the App**:
    - Make sure you have Flutter installed.
    - Run the following command to build the macOS app:
    ```bash
    flutter build macos
    ```

3. **Run the App**:
    - After building, you can find the app in the `build/macos/Build/Products/Release/` directory.
    - Simply double-click to launch the app.

## Usage

- Once the app is running, press `Ctrl + Space` to bring up the GPT Window from the left side of your screen.
- The initial version supports ChatGPT by loading chatgpt.com in a WebView.

## Future Scope

- **Multi-Model Support**: Add WebViews for Google Gemini, Claude, and other AI models.
- **Enhanced Features**: Explore options for integrating more advanced features and interactions.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contributing

We welcome contributions! Please feel free to submit pull requests, issues, or feature suggestions.

---

*GPT Window is a part of the VERA ecosystem aimed at enhancing productivity through quick AI model access.*  
