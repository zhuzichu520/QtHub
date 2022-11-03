pragma Singleton

import QtQuick 2.15
import Qt.labs.settings 1.1

Settings {
    category: "General"
    property bool isDark : false
    //0=0 1=5 2=10
    property int windowRadiusStep : 1

    property color colorPrimary:  "#1A7EFE"
}
