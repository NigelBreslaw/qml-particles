import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    width: 665
    height: 800
    color: "black"

    property int targetLogoEmit: 2000
    property int targetLogoSideEmit: 300
    property int targetTextEmit: 5000
    property int targetTextSideEmit: 500

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    ParticleSystem {
        id: ps
        anchors.fill: parent
        scale: 0.6

        ImageParticle {
            id: logoParticle
            source: "images/particle.png"
            groups: ["logo"]
            z: 2
            anchors.fill: parent
            color: "#66af36"
            alpha: 0
            colorVariation: 0.1
//            greenVariation: 0.2
        }

        ImageParticle {
            id: logoSideParticle
            source: "images/particle.png"
            groups: ["logoSide"]
            z: 2
            anchors.fill: parent
            color: "#0b471e"
            alpha: 0
            colorVariation: 0.0
            greenVariation: 0.4
            rotationVariation: 9
        }

        ImageParticle {
            source: "images/star.png"
            groups: ["textSide"]
            z: 2
            anchors.fill: parent
            color: "#0b471e"
            alpha: 0
            colorVariation: 0.3
//            greenVariation: 0.8
            rotationVariation: 9

        }

        ImageParticle {
            source: "images/star.png"
            groups: ["logoText"]
            z: 2
            anchors.fill: parent
            color: "white"
            alpha: 0.6
            colorVariation: 0.2
            rotationVelocity: 50
            rotationVelocityVariation: 100
        }



        Emitter {
            id: logoEmitter
            anchors.fill: parent
            group: "logo"
            emitRate: 10
            lifeSpan: 750
            size: 10
            endSize: 2
            sizeVariation: 80
            //! [0]
            shape: MaskShape {
                source: "images/logo-shape.png"
            }
            //! [0]
        }

        Emitter {
            id: logoSideEmitter
            width: 143
            height: 800
            group: "logoSide"
            emitRate: 10
            lifeSpan: 700
            size: 25
            sizeVariation: 25
            //! [0]
            shape: MaskShape {
                source: "images/logo-shape-side.png"
            }
            //! [0]
        }

        Emitter {
            id: textEmitter
            anchors.fill: parent
            group: "logoText"
            emitRate: 10
            lifeSpan: 400
            size: 30
            sizeVariation: 80
            //! [0]
            shape: MaskShape {
                source: "images/logo-text.png"
            }
            //! [0]
        }

        Emitter {
            id: textSideEmitter
            anchors.fill: parent
            group: "textSide"
            emitRate: 10
            lifeSpan: 750
            size: 30
            sizeVariation: 50
            //! [0]
            shape: MaskShape {
                source: "images/logo-text-side.png"
            }
            //! [0]
        }


        Loader {
            id: ageAffectorLoader
            enabled: true
            sourceComponent: ageAffector
        }



        Component {
            id: ageAffector
            Age {
                system: ps
                width: 665
                height: 800
                enabled: true
            }
        }



        Turbulence {
            anchors.fill: parent
            strength: 100
        }
        Gravity {
//            anchors.fill: parent
            magnitude: 400
            angle: -90
        }
    }

    SequentialAnimation {
        running: true
        ParallelAnimation {

            NumberAnimation { target: logoEmitter; property: "emitRate"; to: targetLogoEmit; duration: 5000; easing.type: Easing.InSine }
            SequentialAnimation {
                NumberAnimation { target: ageAffectorLoader.item; property: "height"; to: 10; duration: 4000; easing.type: Easing.InSine }
                ScriptAction { script: ageAffectorLoader.sourceComponent = undefined }
            }


            NumberAnimation { target: logoSideEmitter; property: "emitRate"; to: targetLogoSideEmit; duration: 5000; easing.type: Easing.InSine }
            SequentialAnimation {
                PauseAnimation { duration: 3000 }

                ParallelAnimation {
//                    NumberAnimation { targets: [logoParticle, logoSideParticle]; properties: "alpha"; to: 0; duration: 200 }
                    NumberAnimation { target: textEmitter; property: "emitRate"; to: targetTextEmit; duration: 3000; easing.type: Easing.InSine }
                    NumberAnimation { target: textSideEmitter; property: "emitRate"; to: targetTextSideEmit; duration: 3000; easing.type: Easing.InSine }
                }
            }
        }
    }



}

