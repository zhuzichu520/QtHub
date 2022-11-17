import QtQuick
import QtQuick.Controls
import "../storage"

TextArea {

    id:input_text
    selectionColor: Qt.alpha(Theme.colorPrimary,0.3)
    selectByMouse: true
    selectByKeyboard: true
    textFormat: Text.RichText
    readOnly: true
    padding: 0
    wrapMode: Text.WrapAnywhere
    color: Theme.colorFontPrimary

}
