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

    width: 800
    height: 640
    minimumWidth: 800
    minimumHeight: 640
    title: login+"/"+name

    property string login : ""
    property string name: ""
    property string folderIcon : "qrc:/image/ic_folder.png"
    property string fileIcon : "qrc:/image/ic_file.png"

    RepositoriesController{
        id:controller
        onReadmeChanged: {
            webview.loadHtml(readme,"file:///./html")
        }
        onFileTreeChanged: {
            tree_file.treeData = listToTree(fileTree.tree)
        }
    }


    function listToTree(arr) {
        var tree = [];
        if (Array.isArray(arr)) {
            for (var i = 0; i < arr.length; ++i) {
                var item = arr[i];
                var path = item.path.split("/");
                var _tree = tree;
                for (var j = 0; j < path.length; ++j) {
                    var name = path[j];
                    var size = item.size
                    var type = item.type
                    var url = item.url
                    var obj = null;
                    for (var k = 0; k < _tree.length; ++k) {
                        var _obj = _tree[k];
                        if (_obj.name === name) {
                            obj = _obj;
                            break;
                        }
                    }
                    if (!obj) {
                        obj = {name:name,size:String(size),type:type,url:url,expanded:false,icon:type==="tree"?folderIcon:fileIcon};
                        if (name.indexOf(".") < 0){
                            obj.subNodes = [];
                        }
                        _tree.push(obj);
                    }
                    if (obj.subNodes){
                        _tree = obj.subNodes;
                    }
                }
            }
        }
        return tree;
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
        controller.loadFileTree(login,name)
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

            Rectangle{
                anchors{
                    top: layout_bar.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                Item{
                    anchors.fill: parent

                    visible: list_tab.currentIndex === 0
                    WebEngineView{
                        id:webview
                        anchors.fill: parent
                        opacity: 0
                        onContextMenuRequested:
                            (request)=>{
                                request.accepted = false
                            }
                        Behavior on opacity {
                            NumberAnimation{
                                duration: 300
                            }
                        }
                        onLoadProgressChanged: {
                            if(loadProgress === 100){
                                opacity = 1
                                controller.showType = 0
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
                            }
                    }

                    Rectangle{
                        anchors.fill: webview
                        visible: controller.showType !== 0
                        color:Theme.colorBackground1
                        CusLoading{
                            anchors.centerIn: parent
                            visible: controller.showType === 1
                        }
                        Text{
                            anchors.centerIn: parent
                            color:Theme.colorFontPrimary
                            font.pixelSize: 20
                            visible: controller.showType === 2 || controller.showType === 3
                            text: {
                                if(controller.showType === 2){
                                    return "无Readme"
                                }
                                return "网路错误"
                            }
                        }
                    }
                }



                Item{
                    anchors.fill: parent
                    visible: list_tab.currentIndex === 1

                    TreeList{
                        id:tree_file
                        height: parent.height
                        width: 200
                    }

                    Rectangle{
                        height: parent.height
                        anchors{
                            left: tree_file.right
                            right: parent.right
                        }
                    }


                    Rectangle{
                        height: parent.height
                        width: 1
                        color: Theme.colorDivider
                        anchors.left: tree_file.right
                    }


                }
            }
        }
    }
}
