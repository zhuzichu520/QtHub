import QtQuick 2.15

// @disable-check M129
Rectangle {
    Behavior on color{
        ColorAnimation {
            duration: 300
        }
    }
}
