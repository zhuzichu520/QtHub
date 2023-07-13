import QtQuick
import FluentUI
import QtHub
import "qrc:///QtHub/ui/component"

CustomWindow {
    width: 278
    height: 378
    fixSize:true
    showMaximize: false
    showMinimize: false
    title: "QtHub"

    LoginController{

    }

    Image{
        width: 80
        height: 80
        source: "qrc:/QtHub/favicon.ico"
        anchors{
            top: parent.top
            topMargin: 80
            horizontalCenter: parent.horizontalCenter
        }
    }

    FluFilledButton{
        text:"授权登录"
        width: 180
        height: 36
        anchors{
            bottom: parent.bottom
            bottomMargin: 80
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            Qt.openUrlExternally("https://github.com/login/oauth/authorize?client_id=ebf59d49ca54dae4bda5&redirect_uri=http://localhost:8080/oauth/redirect")
        }
    }

    FluText{
        text:"V1.0.0"
        color: FluColors.Grey100
        font: FluTextStyle.Caption
        anchors{
            bottom: parent.bottom
            bottomMargin: 26
            horizontalCenter: parent.horizontalCenter
        }
    }

}
