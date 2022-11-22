import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtWebEngine
import "../component"
import "../storage"

CusWindow {
    id:window
    width: 500
    height: 700
    minimumWidth: 500
    minimumHeight: 700
    title: "WebView"

    property string url : ""

    page: CusPage{

        CusToolBar {
            id:toolBar
            darkEnable: false
            topEnable: false
            isTop: false
            title:window.title
        }

        WebEngineView{
            anchors{
                top: toolBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            url:window.url
            onLoadingChanged: (request)=>{
                console.debug(request.url)
            }
        }
    }
}
