import QtQuick 2.7
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {

    property bool storiesLoadedOnce: false

    TabsList {
        id: tabsList
    }

    header: PageHeader {
        id: header
        title: i18n.tr('Jobs')

        leadingActionBar {
            numberOfSlots: 0
            actions: tabsList.actions
        }
    }

    StoriesListView {
        id: listView

        pageTitle: "Job"
        anchors.fill: parent
        /* amount of space from the above component */
        anchors.topMargin: units.gu(15)

        /* disable the dragging features of the ListModel elements */
        boundsBehavior: Flickable.StopAtBounds

        focus: true
        /* set clip:true to prevent that UbuntuListView draw out of his assigned rectangle, default is false */
        clip: true

        onRefreshClicked: loadStories()
    }

    function loadStories() {
        listView.stories.loadJobStories();
    }
}
