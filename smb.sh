#/bin/bash
sudo apt-get install samba samba-common
echo "������"
sudo /etc/init.d/samba restart
echo "������"
sudo /etc/init.d/samba-ad-dc restart

sudo nano /etc/samba/smb.conf