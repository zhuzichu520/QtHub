import QtQuick 2.15

Rectangle{

    property alias text: text_toast.text

    enum Type {Normal, Error}

    id:layout_toast
    height: 0
    clip: true
    antialiasing: true
    color:{
        if(type === Toast.Type.Error){
            return "#FFCECF"
        }
        return "#FFF4CE"
    }

    property int type: Toast.Type.Normal

    Text{
        id:text_toast
        anchors.centerIn: parent
        color: {
            if(type === Toast.Type.Error){
                return "#E2481A"
            }
            return "#A3841A"
        }
        font.pixelSize: 12
    }

    Behavior on height{
        NumberAnimation{
            duration: 300
        }
    }

    Timer{
        id:timer_toast
        interval: 1500
        onTriggered: {
            layout_toast.text = ""
            layout_toast.height = 0
        }
    }

    function showToast(text,type = Toast.Type.Normal){
        layout_toast.type = type
        layout_toast.text = text === undefined ? "" : text
        layout_toast.height = 36;
        timer_toast.restart()
    }
}
