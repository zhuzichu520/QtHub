pragma Singleton

import QtQuick
import QtQuick.Controls
import "../js/Router.js" as R

ListModel{
    Component.onCompleted: {
        append({name:"JsonFormat",url:R.WINDOW_JSONFORMAT})
    }
}
