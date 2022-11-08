pragma Singleton

import QtQuick
import QtQuick.Controls

ListModel{
    Component.onCompleted: {
        append({name:"JsonFormat",url:Router.window_jsonformat})
    }
}
