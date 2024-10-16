import QtQuick 2.15
import QtQuick.Controls 2.15
import org.qfield 1.0  // Make sure this is correctly referenced in QField
import org.qgis 1.0
import Theme 1.0

Item {
    id: plugin
    property var dashBoard: iface.findItemByObjectName('dashBoard')
    property var overlayFeatureFormDrawer: iface.findItemByObjectName('overlayFeatureFormDrawer')

    property var positionSource: null

    // When plugin is completed, add the button to the toolbar
    Component.onCompleted: {
        iface.addItemToPluginsToolbar(openSettingsButton)
        // iface.mainWindow().displayToast('Coastal vegetation field plugin loaded!')
        // initializePositioning()
    }


    // Tool button for adding vegetation classification
    QfToolButton {
        id: openSettingsButton
        bgcolor: Theme.white
        iconSource: "beach.png"
        iconColor: Theme.white
        round: true
        // Ciao  
        // Action when the button is clicked
        onClicked: {
            iface.mainWindow().displayToast("Settings button clicked")
            settingsPopup.open();
        }
    }


    Popup {
        id: settingsPopup
        parent: iface.mainWindow().contentItem
        width: parent.width * 0.8
        height: parent.height * 0.8
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        anchors.centerIn: parent

        Column {
            spacing: 10
            anchors.fill: parent  // Fill the available parent space
            anchors.margins: 10

            // Header for the settings popup
            Text {
                text: "Coastal Vegetation Plugin"
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            // Table with two columns: image on the left and description on the right
            Flickable {
                id: flick
                width: parent.width
                contentWidth: parent.width
                contentHeight: 2000  // Ensure height is managed dynamically
                //anchors.top: plantGuideText.bottom
                //anchors.left: parent.left
                //anchors.right: parent.right
                height: parent.height * 0.8  // Set this to control how much space the content takes
                clip: true
                //boundsBehavior: Flickable.StopAtBounds

                Column {
                    width: parent.width
                    spacing: 40

                    Text {
                        text: "Non-invasive Species Guide"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width
                    }

                    Repeater {
                        model: [
                            { imageSource: "zostera.png", description: "Seagrass (Zostera): Soft grass with roots. Z marina (1) long blades. Z Noltii (2) fine lying on mudflats like thin wet lawn.." },
                            { imageSource: "glasswort.png", description: "Glasswort (Salicornia) : Green waxy or red-orange in Autumn." },
                            { imageSource: "cordgrass.png", description: "Cordgrass (Spartina): Forms dense upright clumps or fields." },
                            { imageSource: "green_seaweed.png", description: "Green Seaweed: Mainly Ulvas. Tissue tube or thread-like. Attached by holdfast. No roots." },
                            { imageSource: "brownred_seaweed.png", description: "Brown or Read Seaweed: Many species and many forms on rocks and other seaweeds." }
                        ]

                        delegate: Row {
                            spacing: 10
                            width: parent.width
                            height: 80  // Define row height to ensure proper layout

                            Image {
                                source: modelData.imageSource
                                width: parent.width * 0.45
                                height: 100
                                fillMode: Image.PreserveAspectFit
                            }

                            Text {
                                text: modelData.description
                                font.pixelSize: 12
                                width: parent.width * 0.55
                                wrapMode: Text.Wrap
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                    Text {
                        text: "Invasive Species Guide"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width
                    }

                    Repeater {
                        model: [
                            { imageSource: "jap_seaweed.png", description: "Japanese Seaweed: Brown/yellowish long thin main stem seaweed with even side branches. Pin shape & size vesicles on stems. Growth up to 10 cm /day. Branches die back in autumn. Dried > black." },
                            { imageSource: "hogweed.png", description: "Giant Hogweed (Check downstream!): Huge hogweed with thick hairy reddish stem, carrying umbrella-shaped seed heads. Can grow up to 5m. DON’T TOUCH gives very nasty burn." },
                            { imageSource: "him_balsam.png", description: "Himalayan Balsam (Check downstream!): Many white or pink trumpet-shaped flowers on bushy 1-1.6m high annual. Can form dense stands or bands marking top of flood water. Seed pods explode when ripe." },
                            { imageSource: "jap_knotweed.png", description: "Japanese Knotweed: Mainly Ulvas. Dense stands, hollow stems with distinct raised nodes (like bamboo), with leaves shaped like those of garden beans. Long clusters of small beige flowers from late summer. " },
                            { imageSource: "rubharb.png", description: "Giant Rubharb: Up to 2m. thick stems with hooked bristles. Massive leathery umbrella-shaped toothed leaves. Produces tiny red or orange seeds." },
                            { imageSource: "nz_flax.png", description: "New Zealand Flax: Leathery, dark grey-green, strap-shaped 1-3 m leaves. Evergreen perennial. Up to 5 m long flowering stems, with dull red flowers. Large seedpods with black shiny seeds" },
                            { imageSource: "sea_buckthorn.png", description: "Sea Buckthorn: Deciduous shrubs, up to 6 m high, dense with stiff branches and very thorny. Leaves pale silvery-green, 3–8 cm long. Bright orange edible berries in autumn" }
                        ]

                        delegate: Row {
                            spacing: 10
                            width: parent.width
                            height: 120  // Define row height to ensure proper layout

                            Image {
                                source: modelData.imageSource
                                width: parent.width * 0.45
                                height: 100
                                fillMode: Image.PreserveAspectFit
                            }

                            Text {
                                text: modelData.description
                                font.pixelSize: 12
                                width: parent.width * 0.55
                                wrapMode: Text.Wrap
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                }
            }

            

/*             // Dropdown for selecting survey type
            ComboBox {
                id: compositeTypeCombo
                model: ["True Color", "False 7-3-2", "False 4-3-2"]
                anchors.horizontalCenter: parent.horizontalCenter
                width: 200
            } */
/* 
            // Dropdown for selecting vegetation types
            ComboBox {
                id: vegetationTypeCombo
                model: ["Seagrass", "Saltmarsh", "Mangroves", "Grass"]
                anchors.horizontalCenter: parent.horizontalCenter
                width: 200
            } */

            // Button to submit settings
            /* Button {
                text: "Save Settings"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {

                    var layer = qgisProject.mapLayersByName("Vegetation (General)")[0]
                    var positionSource = iface.findItemByObjectName('positionSource')
                    var position = positionSource.positionInformation
                    if (!position) {
                        iface.mainWindow().displayToast("Current position not available", "error")
                        return
                    }

                    iface.mainWindow().displayToast("layer: " + layer + " " + "position: " + position)
                    // var layer = iface.mapCanvas().mapLayersByName("Vegetation (General)")[0]
 

                    /* if (layer && layer.type === QgsMapLayer.VectorLayer && layer.geometryType() === Qgis.Point) {
                        var feature = new QgsFeature()
                        feature.setGeometry(QgsGeometry.fromPointXY(new QgsPointXY(12.34, 56.78))) // Example coordinates
                        var success = LayerUtils.addFeature(layer, feature)
                        if (success) {
                            iface.mainWindow().displayToast("New point feature added successfully")
                        } else {
                            iface.mainWindow().displayToast("Failed to add new point feature")
                        }
                    } else {
                        iface.mainWindow().displayToast("No valid point layer selected")
                    } */
                    
            //        settingsPopup.close()
            //    }
            //} 
        }
    }

    // Function to initialize positioning and check the current position
    function initializePositioning() {
        iface.mainWindow().displayToast("Positioning")
        positionSource = iface.findItemByObjectName('positionSource')

        if (positionSource) {
            if (positionSource.active) {
                showCurrentPosition()  // Show the current position
                setupPositionChangeHandler()  // Set up position change handler
            } else {
                iface.mainWindow().displayToast("Positioning service is not active")
            }
        } else {
            iface.mainWindow().displayToast("Position source not found", "error")
        }
    }

    // Function to display the current position
    function showCurrentPosition() {
        let currentPosition = positionSource.projectedPosition
        if (currentPosition) {
            let longitude = currentPosition.x.toFixed(5)
            let latitude = currentPosition.y.toFixed(5)
            iface.mainWindow().displayToast("Current position: Lon " + longitude + ", Lat " + latitude)
        } else {
            iface.mainWindow().displayToast("Position not available", "error")
        }
    }

    // Function to set up the position change handler
    function setupPositionChangeHandler(positionSource, iface) {
        positionSource.onProjectedPositionChanged.connect(function() {
            let longitude = positionSource.projectedPosition.x.toFixed(5)
            let latitude = positionSource.projectedPosition.y.toFixed(5)
            iface.mainWindow().displayToast("Position updated: Lon " + longitude + ", Lat " + latitude)
        })
    }

}

