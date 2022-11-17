import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../component"
import "../third/colorpicker"
import "../storage"
import QtQuick.Window 2.15

CusWindow {

    id:window
    width: 420
    height: 260
    minimumWidth: 420
    minimumHeight: 260
    maximumWidth: 420
    maximumHeight: 260
    title:"颜色选择器"

    property var onColorFunc

    page: CusPage{

        clip: true

        ColorPicker{
            id:colorPicker
            color:Theme.colorBackground1
            linkColor:Theme.colorFontPrimary
            width: parent.width
            anchors{
                top: toolBar.bottom
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }

        CusToolBar {
            id:toolBar
            maxEnable: false
            title: window.title
        }

        RowLayout{
            spacing: 10
            anchors{
                bottom: parent.bottom
                right: parent.right
                bottomMargin: 8
                rightMargin: 16
            }
            Text{
                text:"取消"
                font.pixelSize: 12
                color:Theme.colorFontPrimary
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        window.close()
                    }
                }
            }
            Text{
                text:"确定"
                font.pixelSize: 12
                color:Theme.colorPrimary
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if(onColorFunc){
                            onColorFunc(colorPicker.colorValue)
                        }
                        window.close()
                    }
                }
            }
        }
    }
}
