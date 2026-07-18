import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation {
    id: presentation

    Timer {
        interval: 20000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    Slide {
        Image {
            source: "slide1.png"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
    }
}
