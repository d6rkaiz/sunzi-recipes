# firewall

echo "Firewall setup."
echo ""
if ! sunzi.installed "ufw"; then
  sunzi.install "ufw"
  ufw logging off
  ufw default deny
  ufw limit 'OpenSSH'
  yes|ufw enable
fi
