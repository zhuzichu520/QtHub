import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Material as M
import Controller
import "../js/Router.js" as R
import "../storage"
import "../component"
import "../view"


Item {

    Text {
        anchors.centerIn: parent
        color:Theme.colorFontPrimary
        font.pixelSize: 20
        text: qsTr("正在建设中...")
    }

}
