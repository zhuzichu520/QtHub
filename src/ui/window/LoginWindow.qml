import QtQuick
import FluentUI
import QtHub
import "qrc:///QtHub/ui/component"

CustomWindow {

    id:window
    width: 278
    height: 378
    fixSize:true
    launchMode: FluWindow.SingleTask
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
                console.debug('-23412312')
                showLoading()
                window.show()
                //将窗口置顶，等获取到焦点后再取消置顶
                window.flags = window.flags | Qt.WindowStaysOnTopHint
                window.requestActivate()
                window.flags = window.flags &~ Qt.WindowStaysOnTopHint
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
