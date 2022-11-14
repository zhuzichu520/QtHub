import QtQuick 2.15
import QtQuick.Controls 2.15
import "../storage"
import UI 1.0

TextEdit {
    id:inputText
    selectionColor: Qt.alpha(Theme.colorPrimary,0.3)
    selectByMouse: true
    selectByKeyboard: true
    selectedTextColor: color
    color:Theme.colorFontPrimary


    onLinkActivated: {
        console.debug("activated"+link)
    }

    onLinkHovered: {
        console.debug("hovered->"+link)
    }

    TextDocument{
        id:doc
        document: inputText.textDocument
        cursorPosition: inputText.cursorPosition
        selectionStart: inputText.selectionStart
        selectionEnd: inputText.selectionEnd
    }

}
