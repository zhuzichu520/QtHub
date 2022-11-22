import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtWebEngine
import "../js/Router.js" as R
import Controller
import "../component"
import "../storage"

CusWindow {
    id:window

    width: 500
    height: 600
    minimumWidth: 500
    minimumHeight: 600
    title: login+"/"+name

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
        WebEngine.settings.accelerated2dCanvasEnabled = true
        WebEngine.settings.allowGeolocationOnInsecureOrigins = true
        WebEngine.settings.allowRunningInsecureContent = true
        WebEngine.settings.allowWindowActivationFromJavaScript = true
        WebEngine.settings.autoLoadIconsForPage = true
        WebEngine.settings.autoLoadImages = true
        WebEngine.settings.defaultTextEncoding = "utf-8"
        WebEngine.settings.dnsPrefetchEnabled = true
        WebEngine.settings.errorPageEnabled = true
        WebEngine.settings.focusOnNavigationEnabled = true
        WebEngine.settings.fullscreenSupportEnabled = true
        WebEngine.settings.hyperlinkAuditingEnabled = true
        WebEngine.settings.javascriptCanAccessClipboard = true
        WebEngine.settings.javascriptCanOpenWindows = true
        WebEngine.settings.javascriptCanPaste = true
        WebEngine.settings.javascriptEnabled = true
        WebEngine.settings.linksIncludedInFocusChain = true
        WebEngine.settings.localContentCanAccessFileUrls = true
        WebEngine.settings.localContentCanAccessRemoteUrls = true
        WebEngine.settings.localStorageEnabled = true
        WebEngine.settings.navigateOnDropEnabled = true
        WebEngine.settings.pdfViewerEnabled = true
        WebEngine.settings.playbackRequiresUserGesture = true
        WebEngine.settings.pluginsEnabled = true
        WebEngine.settings.printElementBackgrounds = true
        WebEngine.settings.screenCaptureEnabled = true
        WebEngine.settings.showScrollBars = true
        WebEngine.settings.spatialNavigationEnabled = true
        WebEngine.settings.touchIconsEnabled = true
        WebEngine.settings.unknownUrlSchemePolicy = WebEngineSettings.AllowAllUnknownUrlSchemes
        WebEngine.settings.webGLEnabled = true
        WebEngine.settings.webRTCPublicInterfacesOnly = true
        controller.loadReadMe(login,name,AppStorage.isDark)
    }

    page: CusPage{

        CusToolBar {
            id:toolBar
            darkEnable: true
            topEnable: true
            title:window.title
        }

        color: Theme.colorBackground1

        Rectangle{
            anchors{
                top: toolBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            color:Theme.colorBackground
            radius: 10

            Rectangle{
                id:layout_bar
                height: 36
                width: parent.width
                color: Theme.colorBackground2

                ListModel{
                    id:model_tab
                    ListElement{
                        name : "Readme"
                    }
                    ListElement{
                        name : "文件"
                    }
                }

                ListView{
                    id:list_tab
                    model: model_tab
                    anchors.fill: parent
                    orientation: ListView.Horizontal
                    boundsBehavior: ListView.StopAtBounds
                    delegate: Rectangle{
                        height: layout_bar.height
                        width: item_text.contentWidth+20
                        color: list_tab.currentIndex === index ? Theme.colorBackground : Theme.colorBackground2
                        Text {
                            id:item_text
                            anchors.centerIn: parent
                            text: model.name
                            font.pixelSize: 14
                            color: list_tab.currentIndex === index ? Theme.colorPrimary : Theme.colorFontPrimary
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(list_tab.currentIndex === index){
                                    if(index === 0){
                                        webview.reload()
                                    }
                                    return
                                }
                                list_tab.currentIndex = index
                            }
                        }
                    }
                }

            }

            WebEngineView{
                id:webview
                opacity: 0
                anchors{
                    top: layout_bar.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                Behavior on opacity {
                    NumberAnimation{
                        duration: 300
                    }
                }
                onLoadingChanged:
                    (request)=>{
                        if(request.status === 0){
                            var url = request.url.toString()
                            if(url.startsWith("http") || url.startsWith("https")){
                                webview.stop()
                                Qt.openUrlExternally(url)
                            }
                        }
                        if(request.status === 2){
                            opacity = 1
                        }
                    }
            }
        }
    }
}
