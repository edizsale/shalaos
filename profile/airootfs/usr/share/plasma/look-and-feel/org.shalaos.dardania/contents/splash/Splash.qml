import QtQuick 2.15

// ShalaOS / dardania acilis ekrani: giris sonrasi Plasma yuklenirken gosterilir.
Rectangle {
    id: root
    color: "#0d0b0c"

    property int stage
    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        Image {
            id: logo
            source: "images/logo.png"
            width: 220
            height: 220
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -30
        }

        // Kirmizi yukleme cubugu: asama ilerledikce dolar
        Rectangle {
            id: barTrack
            width: 240
            height: 3
            radius: 1.5
            color: "#2a2526"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: logo.bottom
            anchors.topMargin: 48

            Rectangle {
                id: bar
                height: parent.height
                radius: parent.radius
                color: "#e4141e"
                width: parent.width * Math.min(1, Math.max(0, root.stage / 5))
                Behavior on width {
                    NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
                }
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        target: content
        from: 0
        to: 1
        duration: 700
        running: false
        easing.type: Easing.InOutQuad
    }
}
