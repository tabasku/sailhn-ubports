import QtQuick 2.7
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import QtQuick.Controls.Suru 2.2
import sailhn.sailhn 1.0

/*
  Entry point of the application
*/
MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'sailhn.sailhn'
    automaticOrientation: true

    Suru.theme: Suru.System

    property string appVersion : "sailhn.project_version"

    width: units.gu(100)
    height: units.gu(75)

    PageStack {
        id: pageStack

        /* set the firts page to open at startup */
        Component.onCompleted: {
           //pageStack.push(Qt.resolvedUrl("TopStoriesPage.qml"));
           push(tabs)
        }
     }

     Tabs {
            id: tabs

            // Ensure that the last used tab is restored when the app gets killed
            // and brought by the system.
            StateSaver.properties: "selectedTabIndex"

            onSelectedTabChanged: {
                // Load the Podcast page only when the user navigates to it. However
                // do not unload it when the user switches to another tab.
                switch (selectedTab) {
                    case newStoriesTab:
                        newStoriesPage.source = Qt.resolvedUrl("NewStoriesPage.qml")
                        break;

                    case jobStoriesTab:
                        jobStoriesPage.source = Qt.resolvedUrl("JobStoriesPage.qml")
                        break;

                    case bestStoriesTab:
                        bestStoriesPage.source = Qt.resolvedUrl("BestStoriesPage.qml")
                        break;
                
                    default:
                        break;
                }
            }

            TopStoriesTab {
                id: topStoriesTab
                objectName: "topStoriesTab"
            }

            Tab {
                id: newStoriesTab

                // Dynamically load/unload the search tab as required
                page: Loader {
                    id: newStoriesPage
                    parent: newStoriesTab
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }

            Tab {
                id: jobStoriesTab

                // Dynamically load/unload the search tab as required
                page: Loader {
                    id: jobStoriesPage
                    parent: jobStoriesTab
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }

            Tab {
                id: bestStoriesTab

                // Dynamically load/unload the search tab as required
                page: Loader {
                    id: bestStoriesPage
                    parent: bestStoriesTab
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }

            Tab {
                id: settingsTab

                // Dynamically load/unload the settings tab as required
                page: Loader {
                    parent: settingsTab
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    source: (tabs.selectedTab === settingsTab) ? Qt.resolvedUrl("ui/SettingsPage.qml") : ""
                }
            }
        }
}