// PositionUtils.qml
import QtQuick 2.15
import org.qfield 1.0

QtObject {
    // Function to initialize positioning and check the current position
    function initializePositioning(iface, positionSource) {
        iface.mainWindow().displayToast("Positioning")
        positionSource = iface.findItemByObjectName('positionSource')

        if (positionSource) {
            if (positionSource.active) {
                showCurrentPosition(positionSource, iface)  // Show the current position
                // setupPositionChangeHandler(positionSource, iface)  // Set up position change handler
            } else {
                iface.mainWindow().displayToast("Positioning service is not active")
            }
        } else {
            iface.mainWindow().displayToast("Position source not found", "error")
        }
    }

    // Function to display the current position
    function showCurrentPosition(positionSource, iface) {
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
