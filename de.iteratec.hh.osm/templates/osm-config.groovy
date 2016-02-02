//base url of application
grails.serverURL = "http://%BASE_URL_OSM%"
// Configure default app users
grails.de.iteratec.osm.security.initialOsmAdminUser.username='%OSM_ADMIN_USER%'
grails.de.iteratec.osm.security.initialOsmAdminUser.password='%OSM_ADMIN_PASSWORD%'
grails.de.iteratec.osm.security.initialOsmRootUser.username='%OSM_ROOT_USER%'
grails.de.iteratec.osm.security.initialOsmRootUser.password='%OSM_ROOT_PASSWORD%'
//configure charting library
grails.de.iteratec.osm.report.chart.chartTagLib = de.iteratec.osm.report.chart.ChartingLibrary.RICKSHAW
grails.de.iteratec.osm.report.chart.availableChartTagLibs = [de.iteratec.osm.report.chart.ChartingLibrary.RICKSHAW]
//configure database
environments {
	production {
		dataSource {
			dbCreate = "update"// one of 'create', 'create-drop', 'update', 'validate', ''
			url = "jdbc:mysql://osm-mysql/%MYSQL_DATABASE%"
			username = "%MYSQL_USER%"
			password = "%MYSQL_PASSWORD%"
			driverClassName = "com.mysql.jdbc.Driver"
			logSql = false
			pooled = true
			properties {
				minEvictableIdleTimeMillis = 60000
				timeBetweenEvictionRunsMillis = 5000
				numTestsPerEvictionRun=3
				testOnBorrow=true
				testWhileIdle=true
				testOnReturn = false
				validationQuery="SELECT 1"
			}
		}
	}
}
