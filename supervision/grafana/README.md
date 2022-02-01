# cheatSheet  Grafana
:::success
cheatSheet pour nos variables dans Grafana :tada:
:::

**interval**	Interval		``` 1m,10m,30m,1h,6h,12h,1d,7d,14d,30d```\
custom	Custom		``` prom1, prom2, prom3, prom4```\
userName	Query	MySQL```	SELECT username AS metric FROM exampledb.simple_table ORDER BY id```\
name	Query	Loki	``` label_names()```\
host	Query	Loki	``` label_values(host)```\
job	Query	Loki	``` label_values(job)```\
promNames	Query	Prometheus	``` label_names()```\
promJob	Query	Prometheus	``` label_values(job)```\
promHost	Query	Prometheus	``` label_values(node_uname_info{job="$promJob"}, nodename)```\
source	Query	InfluxDB	``` from(bucket: "telegraf")\
|> range(start: v.timeRangeStart, stop: v.timeRangeStop)\
|> filter(fn: (r) => r["_measurement"] == "snmp")\
|> group(columns: ["_field"])\
|> distinct(column: "source")```\
interface	Query	InfluxDB	``` from(bucket: "telegraf")\
|> range(start: -1m)\
|> filter(fn: (r) => r["_measurement"] == "interface")\
|> filter(fn: (r) => r["source"] == "${source}")\
|> group(columns: ["_field"])\
|> distinct(column: "ifDescr")```\
zabbixHost	Query	Zabbix	```Query Type Host, Group /.*/, Host /.*/\
unit	Query	Elasticsearch-Metricbeat	{"find": "terms", "field": "systemd.unit"}```\
unit	Query	Elasticsearch-Metricbeat	```{"find": "terms", "field": "systemd.unit"}```\

# Exemple

### LOKI

Par exemple, pour LOKI si on souhaite afficher de manière dynamique tous les "host" dans une variable pour faire varié nos dashbaords par exemple,nous utiliserons mettre : 

```label_values(host)```

Cela nous affichera toutes les "host" disponibles 

![Alt text](./lokiquery.png?raw=true "Title")
