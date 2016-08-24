import QtQuick 1.1

Rectangle {
    property int maxval
    property alias borderimage : border.source
    function setEditable(status) {
        dial1.interactive = status
        dial2.interactive = status
    }

    function getValue() {
        return (dial1.currentIndex%10)*10 + dial2.currentIndex
    }

    function setValue(value) {
        dial1.currentIndex = Math.floor(value/10)
        dial2.currentIndex = value%10
    }

    height: countdownPage.width*0.30
    width: height
    color: "transparent"

    BorderImage {
        id: border
        source: "image://theme/meegotouch-textedit-background"
        anchors.fill: parent
        border.left: 25; border.top: 25
        border.right: 25; border.bottom: 25
        anchors.margins: -3
    }

    Item {
        // tens digit: 0-5
        width: parent.width/2
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: 8
        clip: true
        Dial {
            id: dial1
            model: 6
        }
    }
    Item {
        // ones digit: 0-9
        width: parent.width/2
        height: parent.height
        anchors.right: parent.right
        clip: true
        Dial {
            id: dial2
            model: 10
        }
    }
}
