// ShalaOS varsayilan panel duzeni. Baslat dugmesi KDE simgesi yerine
// ShalaOS'un basitlestirilmis kartal amblemini (hicolor "shalaos-baslat"
// ikonu) kullanir. Panelde 22-32 px'e kuculdugu icin ayri, sade bir ikon;
// tam logo ("shalaos") diger yerlerde aynen korunur.
var panel = new Panel
panel.location = "bottom"
panel.height = Math.round(gridUnit * 2.2)

var kickoff = panel.addWidget("org.kde.plasma.kickoff")
kickoff.currentConfigGroup = ["General"]
kickoff.writeConfig("icon", "shalaos-baslat")

panel.addWidget("org.kde.plasma.icontasks")
panel.addWidget("org.kde.plasma.marginsseparator")
panel.addWidget("org.kde.plasma.systemtray")
panel.addWidget("org.kde.plasma.digitalclock")
panel.addWidget("org.kde.plasma.showdesktop")
