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
            "/":"qrc:/QtHub/login/LoginWindow.qml",
        }
        FluApp.initialRoute = "/"
        FluApp.run()
    }
}
