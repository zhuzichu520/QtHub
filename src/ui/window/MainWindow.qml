import QtQuick
import FluentUI
import Qt.labs.platform
import QtHub
import "qrc:///QtHub/ui/component"

CustomWindow {

    id:window
    width: 1050
    height: 640
    closeDestory:false
    minimumWidth: 520
    minimumHeight: 200
    appBarVisible: false
    autoShow: false
    launchMode: FluWindowType.SingleTask
    title: qsTr("QtHub")

    closeFunc:function(event){
        dialog_close.open()
        event.accepted = false
    }

    Component.onCompleted: {
        if(!UserHelper.isLogin()){
            visible = false
            FluApp.navigate("/login")
        }else{
            FluTools.setQuitOnLastWindowClosed(false)
            visible = true
        }
    }

    FluObject{
        id:items_original
        FluPaneItem{
            title:"Home"
            icon:FluentIcons.Home
            onTap:{
                nav_view.push("qrc:/QtHub/ui/page/HomePage.qml")
            }
        }
        FluPaneItem{
            title:"Notifications"
            icon:FluentIcons.Ringer
            onTap:{
                nav_view.push("qrc:/QtHub/ui/page/NotificationsPage.qml")
            }
        }
        FluPaneItem{
            title:"Explore"
            icon:FluentIcons.Send
            onTap:{
                nav_view.push("qrc:/QtHub/ui/page/ExplorePage.qml")
            }
        }
    }

    FluObject{
        id:items_footer
        FluPaneItemSeparator{}
        FluPaneItem{
            title:"Profile"
            icon:FluentIcons.Contact
            onTap:{
                nav_view.push("qrc:/QtHub/ui/page/ProfilePage.qml")
            }
        }

        FluPaneItem{
            title:"Settings"
            icon:FluentIcons.Settings
            tapFunc:function(){
                FluApp.navigate("/settings")
            }
        }
    }

    FluAppBar {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        darkText: "Dark Mode"
        showDark: true
        z:7
    }

    FluNavigationView{
        id:nav_view
        width: parent.width
        height: parent.height
        z:999
        navWidth:200
        items: items_original
        footerItems:items_footer
        topPadding:FluTools.isMacos() ? 20 : 5
        logo: "qrc:/QtHub/favicon.ico"
        title:"QtHub"
        Component.onCompleted: {
            setCurrentIndex(0)
        }
    }

    FluContentDialog{
        id:dialog_close
        title:"退出"
        message:"确定要退出程序吗？"
        negativeText:"最小化"
        buttonFlags: FluContentDialogType.NeutralButton | FluContentDialogType.NegativeButton | FluContentDialogType.PositiveButton
        onNegativeClicked:{
            window.hide()
            system_tray.showMessage("友情提示","QtHub已隐藏至托盘,点击托盘可再次激活窗口");
        }
        positiveText:"退出"
        neutralText:"取消"
        blurSource: nav_view
        onPositiveClicked:{
            window.deleteWindow()
            FluApp.closeApp()
        }
    }

    SystemTrayIcon {
        id:system_tray
        visible: true
        icon.source: "qrc:/QtHub/favicon.ico"
        tooltip: "QtHub"
        menu: Menu {
            MenuItem {
                text: "退出"
                onTriggered: {
                    window.deleteWindow()
                    FluApp.closeApp()
                }
            }
        }
        onActivated:
            (reason)=>{
                if(reason === SystemTrayIcon.Trigger){
                    window.show()
                    window.raise()
                    window.requestActivate()
                }
            }
    }


}
