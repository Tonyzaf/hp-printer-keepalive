# HP Printer Keepalive

Workaround for an HP LaserJet Pro MFP M227sdn that becomes unreachable after
entering sleep mode.

A Raspberry Pi periodically requests the printer's web interface every 5 minutes
to keep the printer active and logs the result.

## Files

- `hp-printer-keepalive.sh` - keepalive script
- `hp-printer-keepalive.service` - systemd service

## Installation

Copy the script:

```bash
sudo cp hp-printer-keepalive.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/hp-printer-keepalive.sh
```

Install the service:

```bash
sudo cp hp-printer-keepalive.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now hp-printer-keepalive.service
```

Check status:

```bash
systemctl status hp-printer-keepalive.service
```

View logs:

```bash
tail -f /var/log/hp-printer-keepalive.log
```

## Configuration

Edit:

```bash
sudo nano /usr/local/bin/hp-printer-keepalive.sh
```

Change:

```bash
PRINTER_IP="192.168.1.141"
INTERVAL=300
```

## Log Examples

Success:

```text
2026-06-16 08:39:29 OK http_code=200
```

Failure:

```text
2026-06-16 12:15:01 FAIL curl_exit=28 output=...
```

## Background

The printer:
- responds to ping
- stops serving the web interface
- stops accepting print jobs

This suggests the network stack remains partially alive while higher-level
services become unresponsive after a sleep/power-management transition.

This keepalive is intended as a workaround and diagnostic tool.
