import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import Qt.labs.platform 1.1
import Controller 1.0
import "../component"
import "../storage"

CusWindow {
    id:window
    width: 300
    height: 400
    title: "登录"
    closeDestory:false

    LoginController{
        id:controller
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
                finish()
                hideLoading()
                break;
            default:
                break;
            }
        }
    }

    Component.onCompleted: {
        resizable = false
    }

    page: CusPage{

        Image{
            id:img_logo
            width: 60
            height: 60
            anchors{
                top: parent.top
                topMargin: 100
                horizontalCenter: parent.horizontalCenter
            }
            source: "qrc:/image/ic_login_logo.png"
        }


        Text{
            text:"QtHub"
            anchors{
                top: img_logo.bottom
                topMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            color: "#191E24"
            font.pixelSize: 20
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    showToast(settingsHelper.getToken())
                }
            }
        }

        CusToolBar {
            id:toolBar
            maxEnable: false
            darkEnable: false
            topEnable: false
            isTop: false
        }


        PrimaryButton{
            id:btn_login
            width: 260
            height: 36
            text:"去授权"
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom:parent.bottom
                bottomMargin: 100
            }
            onClicked: {
                Qt.openUrlExternally("https://github.com/login/oauth/authorize?client_id=ebf59d49ca54dae4bda5&redirect_uri=http://localhost:8080/oauth/redirect")
            }
        }
    }
}
