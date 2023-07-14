import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import FluentUI

Window {
    id: app
    flags: Qt.SplashScreen
    Component.onCompleted: {
        FluApp.init(app)
        FluTheme.darkMode = FluDarkMode.System
        FluTheme.enableAnimation = true
        FluApp.routes = {
            "/":"qrc:/QtHub/ui/window/MainWindow.qml",
            "/login":"qrc:/QtHub/ui/window/LoginWindow.qml",
            "/settings":"qrc:/QtHub/ui/window/SettingsWindow.qml",
        }
        FluApp.initialRoute = "/"
        FluApp.run()
    }
}
