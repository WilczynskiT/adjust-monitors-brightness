# Readme

### How to install setBrightness.sh:

**Install `acpi` (if it's not already installed)**::

```bash
sudo apt install acpi
```

**Capture ACPI Events:**

Run the following command to listen for ACPI events:

```bash
acpi_listen
```

Now, press the brightness up or down keys. If these keys are recognized by the ACPI system, you will see events like:

```bash
video/brightnessup
video/brightnessdown
```

**Create or Edit the `/etc/acpi/events/` Configuration:**

ACPI events can be configured in the `/etc/acpi/events/` directory. If the brightness keys are detected (e.g., `video/brightnessup` and `video/brightnessdown`), create a new event file like this:

```bash
sudo nano /etc/acpi/events/brightnessup
```

Add the following content:

```bash
event=video/brightnessup
action=/path/to/your/setBrightness.sh up
```

Similarly, create a file for the brightness down key:

```bash
sudo nano /etc/acpi/events/brightnessdown
```

Add add this:

```bash
event=video/brightnessdown
action=/path/to/your/setBrightness.sh down
```

**Install `ddcutil`:**

```bash
sudo apt install ddcutil
```

**Reload the ACPI Event Daemon:**

After configuring the events, reload the ACPI event daemon to apply the changes:

```bash
sudo systemctl restart acpid
```

### How to refresh the cache:

If you want to force a refresh, you can delete the cache file manually:

```bash
rm /tmp/ddcutil_bus_cache
```

It could be useful when you change monitor or connect it to different HDMI/DP port.

### To check cache content:

```bash
cat /tmp/ddcutil_bus_cache
```

### To manually check monitor buses:

```bash
ddcutil detect | awk '/I2C bus:/ {print $3}' | sed 's/\/dev\/i2c-//'
```

### How to check monitor details:

```bash
ddcutil detect
```
