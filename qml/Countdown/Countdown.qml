import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.systeminfo 1.1
import QtMultimediaKit 1.1

Page {
    id: countdownPage
    tools: commonTools

    signal clicked

    property int countdown: 0
    property int passed : 0

    onClicked: toggleStart()

    ScreenSaver {
        id: screenSaver
        screenSaverDelayed: false
    }

    SoundEffect {
        id: soundEffect
        source: "../../sounds/bell.wav"
    }

    function updatetime() {
        countdown = hours.getValue() * 60 * 60 + minutes.getValue() * 60 + seconds.getValue()
    }
    function updateclock(time) {
        hours.setValue(Math.floor(time / 3600))
        minutes.setValue(Math.floor(time % 3600/60))
        seconds.setValue(time%60)
    }

    function toggleStart() {
        if(countdowntimer.running) {
            countdowntimer.stop()
            enablemodify()
        } else {
            passed = 0
            updatetime()
            if(countdown != 0) {
                countdowntimer.start()
                disablemodify()
            }
        }
    }
    function checktime() {
        if(passed >= countdown) {
            countdowntimer.stop()
            changecolor("red")
            resettimer.start()
            passed = 0
            soundEffect.play()
        }
    }

    function disablemodify() {
        hours.setEditable(false)
        minutes.setEditable(false)
        seconds.setEditable(false)
        changecolor("green")
    }

    function enablemodify() {
        hours.setEditable(true)
        minutes.setEditable(true)
        seconds.setEditable(true)
        changecolor("normal")
    }

    function changecolor(color) {
        if(color === "red") {
            hours.borderimage = "image://theme/meegotouch-textedit-background-error"
            minutes.borderimage = "image://theme/meegotouch-textedit-background-error"
            seconds.borderimage = "image://theme/meegotouch-textedit-background-error"
        } else if(color === "green") {
            hours.borderimage = "image://theme/meegotouch-textedit-background-selected"
            minutes.borderimage = "image://theme/meegotouch-textedit-background-selected"
            seconds.borderimage = "image://theme/meegotouch-textedit-background-selected"
        } else if(color === "normal") {
            hours.borderimage = "image://theme/meegotouch-textedit-background"
            minutes.borderimage = "image://theme/meegotouch-textedit-background"
            seconds.borderimage = "image://theme/meegotouch-textedit-background"
        }
    }

    Timer {
        id: resettimer
        interval: 3000; running: false; repeat: false
        onTriggered: {
            updateclock(countdown)
            enablemodify()
            soundEffect.stop()
        }
    }

    Timer {
        id: countdowntimer
        interval: 1000; running: false; repeat: true
        onTriggered: {
            passed++
            updateclock(countdown - passed)
            checktime()
        }
    }

    Row {
        id: timeRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        Column {
            Text {
                text: "hours"
                font.pixelSize: 30
                font.family: "Nokia Pure Text Light"
                color: "gray"
                anchors.right: parent.right
            }
            Digit {
                id: hours
                maxval: 100
            }
        }
        Column {
            Text {
                text: "minutes"
                font.pixelSize: 30
                font.family: "Nokia Pure Text Light"
                color: "gray"
                anchors.right: parent.right
            }
            Digit {
                id: minutes
                maxval: 60
            }
        }
        Column {
            Text {
                text: "seconds"
                font.pixelSize: 30
                font.family: "Nokia Pure Text Light"
                color: "gray"
                anchors.right: parent.right
            }
            Digit {
                id: seconds
                maxval: 60
            }
        }
    }

    Row {
        visible: appWindow.inPortrait
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20
        anchors.bottomMargin: 50
        spacing: 20

        Label {
            text: "disable screensaver"
            font.pixelSize: 30
            font.family: "Nokia Pure Text Light"
            color: "dark gray"
        }
        Switch {
            id: screensaverSwitch
            onCheckedChanged: {
                if(checked)
                    screenSaver.setScreenSaverDelayed(true)
                else
                    screenSaver.setScreenSaverDelayed(false)
            }
        }
    }
}
