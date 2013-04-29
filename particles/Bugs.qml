import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    width: 400
    height: 400
    color: "black"


    ParticleSystem {
        id: ps
        anchors.fill: parent

        ImageParticle {
            id: logoParticle
            source: "images/particle.png"
            color: "white"
            anchors.fill: parent
        }

        Emitter {
            anchors.fill: parent
            emitRate: 1000
            lifeSpan: 750
            size: 10
            endSize: 2
            sizeVariation: 80
            velocity: AngleDirection {angleVariation: 180; magnitude: 50}
        }
        Age {
            id: ageAffector
            width: 400
            height: 400
            enabled: false
        }

    }

    Text {
        color: "steelblue"
        text: ageAffector.enabled
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            print(ageAffector.enabled)
            ageAffector.enabled = !ageAffector.enabled
        }
    }

}
