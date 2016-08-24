import QtQuick 1.1

PathView {
    property int blockX : width
    property int blockY : height

    MouseArea {
        anchors.fill: parent
        onClicked: countdownPage.clicked();
    }

    anchors.fill: parent
    delegate: Text {
        height: blockY
        width: blockX
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: index <= 1 ? ( index === 0 ? count - 2 : count - 1 ) : index - 2
        font.pixelSize: blockY - blockY/5
        style: Text.Outline
        styleColor: "#444444"
        color: "#999999"
    }

    path: Path {
        startX: blockX/2
        startY: -blockY - blockY/2
        PathLine { x: blockX/2; y: (model-2)*(blockY) + blockY/2 }
    }
}
