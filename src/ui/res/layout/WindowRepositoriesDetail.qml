import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtWebView 1.1
import "../js/Router.js" as R
import Controller
import "../component"
import "../storage"

CusWindow {
    id:window

    width: 500
    height: 700
    minimumWidth: 500
    minimumHeight: 700
    title: name

    property string login : ""
    property string name: ""

    RepositoriesController{
        id:controller
        onReadmeChanged: {
            webview.loadHtml(readme,"file:///./html")
        }
    }

    Connections{
        target: AppStorage
        function onIsDarkChanged(){
            controller.loadReadMe(login,name,AppStorage.isDark)
        }
    }

    Component.onCompleted: {
        controller.loadReadMe(login,name,AppStorage.isDark)
    }

    page: CusPage{

        CusToolBar {
            id:toolBar
            darkEnable: false
            topEnable: false
            isTop: false
            title:window.title
        }

        WebView{
            id:webview
            anchors{
                top: toolBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            onLoadingChanged:
                (request)=>{
                    if(request.status === 0){
                        var url = request.url.toString()
                        console.debug(request.url)
                        if(url.startsWith("http") || url.startsWith("https")){
                            webview.stop()
                            Qt.openUrlExternally(url)
                        }
                    }
                }
        }
    }
}
