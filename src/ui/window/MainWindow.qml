import QtQuick
import FluentUI
import "qrc:///QtHub/ui/component"

CustomWindow {
    width: 640
    height: 480
    autoShow: false
    launchMode: FluWindow.SingleTask
    title: qsTr("QtHub")

    Component.onCompleted: {
        visible = false
        FluApp.navigate("/login")
    }


}
