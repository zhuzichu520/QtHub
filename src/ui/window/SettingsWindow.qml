import QtQuick
import FluentUI
import QtHub
import "qrc:///QtHub/ui/component"

CustomWindow {

    id:window
    width: 480
    height: 520
    fixSize:true
    launchMode: FluWindowType.SingleTask
    showMaximize: false
    showMinimize: false
    closeDestory: false
    title: "Settings"


    FluFilledButton{
        text:"Sign Out"
        width: 200
        anchors{
           horizontalCenter: parent.horizontalCenter
           bottom: parent.bottom
           bottomMargin: 20
        }
        onClicked: {
            dialog_sign_out.open()
        }
    }

    FluContentDialog{
        id:dialog_sign_out
        title:"Sign Out"
        buttonFlags: FluContentDialogType.NeutralButton | FluContentDialogType.PositiveButton
        positiveText:"SIGN OUT"
        neutralText:"CANCEL"
        onNegativeClicked:{

        }
        onPositiveClicked:{
        }
    }
}
