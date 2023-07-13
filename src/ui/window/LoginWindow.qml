import QtQuick
import FluentUI
import QtHub
import "qrc:///QtHub/ui/component"

CustomWindow {

    id:window
    width: 278
    height: 378
    fixSize:true
    showMaximize: false
    showMinimize: false
    closeDestory: false
    title: "QtHub"

    LoginController{
        onLoginStatusChanged: {
            switch(loginStatus){
            case 1:
                hideLoading()
                break;
            case 2:
                window.show()
                window.raise()
                window.requestActivate()
                showLoading()
                break;
            case 3:
                hideLoading()
                break;
            case 4:
                FluApp.navigate("/")
                window.close()
                break;
            default:
                break;
            }
        }
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
            Qt.openUrlExternally("https://github.com/login/oauth/authorize?client_id=ebf59d49ca54dae4bda5&redirect_uri=http://localhost:8835/oauth/redirect")
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
