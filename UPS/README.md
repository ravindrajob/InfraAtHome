# InfraAtHome
Here a simple example of my scripts to scan the state of my UPS battery

## 1. Connect with ssh on your NAS
## 2. Test this command :
#### upsc qnapups@127.0.0.1

#### If you get a result like this :

battery.charge: 100
battery.charge.low: 10
battery.charge.warning: 50
battery.date: 2001/09/25
battery.mfr.date: 2017/04/08
battery.runtime: 1076
battery.runtime.low: 120
battery.type: PbAc
battery.voltage: 13.6
battery.voltage.nominal: 12.0
device.mfr: American Power Conversion
device.model: Back-UPS XS 700U
device.serial: 3B1714X24915
device.type: ups
driver.name: usbhid-ups
driver.parameter.pollfreq: 30
driver.parameter.pollinterval: 10
driver.parameter.port: /dev/ttyS1
driver.parameter.synchronous: no
driver.version: 2.7.4
driver.version.data: APC HID 0.96
driver.version.internal: 0.41
input.sensitivity: medium
input.transfer.high: 300
input.transfer.low: 140
input.transfer.reason: input voltage out of range
input.voltage: 238.0
input.voltage.nominal: 230
ups.beeper.status: enabled
ups.delay.shutdown: 20
ups.firmware: 924.Z3 .I
ups.firmware.aux: Z3
ups.load: 25
ups.mfr: American Power Conversion
ups.mfr.date: 2017/04/08
ups.model: Back-UPS XS 700U
ups.productid: 0002
ups.realpower.nominal: 390
ups.serial: 3B1714X24915
ups.status: OL
ups.test.result: No test initiated
ups.timer.reboot: 0
ups.timer.shutdown: -1
ups.vendorid: 051d



You Can use this scripts :)