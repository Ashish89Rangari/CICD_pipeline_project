# Install Prometheus Grafana In AWS Instance #

1) To Install Prometheus and Create Service for Prometheus 
```
sudo apt update -y
sudo useradd --system --no-create-home --shell /bin/false prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.47.1/prometheus-2.47.1.linux-amd64.tar.gz
tar -xvf prometheus-2.47.1.linux-amd64.tar.gz
cd prometheus-2.47.1.linux-amd64/
sudo mkdir -p /data /etc/prometheus
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/
sudo cat > /etc/systemd/system/prometheus.service << EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/data \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target
EOF

```
2) To Enable and start the Prometheus Service
```
sudo systemctl enable prometheus
sudo systemctl start prometheus

```
3) To Install Node exporter in Prometheus and Create Service for Node Exporter (enables you to measure various machine resources such as memory, disk and CPU utilization)
```
sudo useradd --system --no-create-home --shell /bin/false node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
tar -xvf node_exporter-1.6.1.linux-amd64.tar.gz
sudo mv node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter*
sudo cat > /etc/systemd/system/node_exporter.service << EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter --collector.logind

[Install]
WantedBy=multi-user.target
EOF

```
4) To Enable and start the Node exporter Service
```
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

```
5) To Install  Grafana
```
$ sudo apt-get update
$ sudo apt-get install -y apt-transport-https software-properties-common
$ wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
$ echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
$ sudo apt-get update
$ sudo apt-get -y install grafana
$ sudo systemctl enable grafana-server
$ sudo systemctl start grafana-server

```
6) Commands to check services (Prometheus,Node-exporter,Grafana)
```
$ sudo systemctl status prometheus
$ sudo systemctl status node_exporter
$ sudo systemctl status grafana-server

```
7) Add job for node exporter in prometheus
```
$ cd /etc/prometheus/, ls, $ sudo nano prometheus.yml and below the job of prometheus, add job for node exporter
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['IP-Address:9100']

```
8) Check the indentation of the prometheus config file with below command
```
$ promtool check config /etc/prometheus/prometheus.yml

```
9) Reload the Prometheus configuration
```
$ curl -X POST http://localhost:9090/-/reload

```
10) On monitoring server go to $ cd /etc/prometheus/ & $ sudo nano prometheus.yml and add job for Jenkins
```
- job_name: 'jenkins'
    metrics_path: '/prometheus'
    static_configs:
      - targets: ['IP-Address:8080']

```