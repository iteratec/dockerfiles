// Configure default app users
grails.de.iteratec.osm.security.initialOsmAdminUser.username='${OSM_ADMIN_USER}'
grails.de.iteratec.osm.security.initialOsmAdminUser.password='${OSM_ADMIN_PASSWORD}'
grails.de.iteratec.osm.security.initialOsmRootUser.username='${OSM_ROOT_USER}'
grails.de.iteratec.osm.security.initialOsmRootUser.password='${OSM_ROOT_PASSWORD}'
//configure charting library
grails.de.iteratec.osm.report.chart.chartTagLib = de.iteratec.osm.report.chart.ChartingLibrary.RICKSHAW
grails.de.iteratec.osm.report.chart.availableChartTagLibs = [de.iteratec.osm.report.chart.ChartingLibrary.RICKSHAW]